#!/usr/bin/env bash
set -euo pipefail

# --- Configuration ---
dir_temp=/home/wash/bin/tmpOneDrivePhotos
processed_log=/home/wash/bin/.onedrive_processed
canary=/home/wash/OneDriveCanary.txt

photo_dest=/mercury/photos
video_dest=/mercury/homevids

pushover_token=/run/agenix/pushover_token
pushover_user=/run/agenix/pushover_user

# --- Functions ---
notify() {
    local title="$1" message="$2"
    curl -s \
        -F "token=$(cat "$pushover_token")" \
        -F "user=$(cat "$pushover_user")" \
        -F "title=$title" \
        -F "message=$message" \
        https://api.pushover.net/1/messages.json > /dev/null 2>&1 || true
}

get_date_dir() {
    local file="$1"
    local date_dir

    # Prefer EXIF DateTimeOriginal > CreateDate, fall back to mtime
    date_dir=$(exiftool -s3 -d '%Y/%m' \
        -DateTimeOriginal -CreateDate \
        "$file" 2>/dev/null | grep -m1 -oP '\d{4}/\d{2}' || true)

    if [[ -z "$date_dir" ]]; then
        date_dir=$(date -r "$file" +%Y/%m)
    fi

    echo "$date_dir"
}

# --- Phase 1: Download from OneDrive ---
mkdir -p "$dir_temp"

if ! rclone -v copy "onedrive:Pictures/Samsung Gallery/" "$dir_temp"; then
    notify "S25 Onedrive to Anubis" "FAILED - rclone download"
    exit 99
fi

# --- Phase 2: Sort photos/videos by EXIF date ---
# Load already-processed paths into associative array for fast lookup
declare -A processed
touch "$processed_log"
while IFS= read -r line; do
    [[ -n "$line" ]] && processed["$line"]=1
done < "$processed_log"

count=0
errors=0

while IFS= read -r -d '' file; do
    rel_path="${file#"$dir_temp"/}"

    # Skip already processed
    [[ -v processed["$rel_path"] ]] && continue

    ext="${file##*.}"
    ext="${ext,,}" # lowercase

    # Determine destination base by extension
    case "$ext" in
        jpg|jpeg|png|dng|heic)
            base="$photo_dest" ;;
        mp4|mov|gif)
            base="$video_dest" ;;
        *)
            # Unknown extension - mark processed so we don't retry
            echo "$rel_path" >> "$processed_log"
            continue ;;
    esac

    date_dir=$(get_date_dir "$file")
    dest="$base/$date_dir"
    mkdir -p "$dest"

    if cp -np "$file" "$dest/"; then
        echo "$rel_path" >> "$processed_log"
        ((count++))
    else
        ((errors++))
    fi
done < <(find "$dir_temp" -type f -print0)

echo "Sorted $count new files ($errors errors) at $(date)" >> "$canary"

if ((errors > 0)); then
    notify "S25 Onedrive to Anubis" "PARTIAL - $count sorted, $errors errors"
else
    notify "S25 Onedrive to Anubis" "SUCCESS - $count new files"
fi

# --- Phase 3: Sync music to OneDrive ---
if ! rclone -v copy /mercury/music onedrive:/Music; then
    notify "Anubis Music to Onedrive" "FAILED"
    exit 99
fi

echo "Music synced at $(date)" >> "$canary"

exit 0
