# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a NixOS/nix-darwin flake configuration managing multiple hosts across Linux (NixOS) and macOS (nix-darwin) systems. The configuration uses a modular architecture with shared components for both platforms.

## Build and Deployment Commands

### Building Configurations

**For macOS (darwin) hosts:**
```bash
darwin-rebuild switch --flake .#<hostname>
```
Available darwin hosts: `io`, `saturn`

**For NixOS hosts:**
```bash
sudo nixos-rebuild switch --flake .#<hostname>
```
Available NixOS hosts: `anubis`, `neptune`, `zelda`, `nixmacVM`

### Testing Without Activation
```bash
# macOS
darwin-rebuild build --flake .#<hostname>

# NixOS
sudo nixos-rebuild build --flake .#<hostname>
```

### Updating Dependencies
```bash
nix flake update
```

### Working with Secrets (agenix)
```bash
# Edit secrets (requires appropriate SSH key)
agenix -e secrets/<secret-name>.age

# Rekey secrets after adding new hosts/users
agenix -r
```

## Architecture

### Directory Structure

- **`flake.nix`**: Main flake definition with inputs and output configurations
- **`hosts/`**: Per-host configurations (both NixOS and darwin)
  - Each host has its own directory with `default.nix` and host-specific modules
- **`modules/`**: Reusable NixOS configuration modules
  - `common/`: Shared configuration for all NixOS systems
  - `desktop/`: Desktop environment configurations (bspwm, hyprwm, wayland)
  - `gnome/`: GNOME-specific configurations
  - `server/`: Server-specific configurations
- **`hm/`**: Home Manager configurations
  - `common/`: Shared home-manager configs (CLI tools, nvim, fish)
  - `darwin.nix`: macOS-specific home-manager config
  - Desktop environment configs (bspwm, hypr, waybar, etc.)
- **`users/`**: User-specific configurations
  - Separate directories for each user and platform combination
  - Format: `<username>` (Linux) or `darwin-<username>` (macOS)
- **`secrets/`**: Encrypted secrets managed by agenix
  - `secrets.nix`: Public key mappings for secret encryption

### Key Architecture Patterns

**Platform Separation:**
- NixOS systems use `nixosConfigurations` in flake outputs
- macOS systems use `darwinConfigurations` in flake outputs
- Both share home-manager configurations from `hm/`

**Module Import Chain:**
1. Host imports platform-specific common module (`modules/common/darwin-common.nix` or `modules/common/sys-default.nix`)
2. Host imports user configuration from `users/`
3. User configuration imports home-manager modules from `hm/`
4. Additional feature modules (desktop, server, etc.) imported as needed

**Special Args Pattern:**
All configurations receive `{ inherit inputs outputs; }` as `specialArgs`, making flake inputs available throughout the configuration tree.

**Unstable Packages:**
Many configurations use a pattern to access nixpkgs-unstable:
```nix
let
  unstable = import inputs.nixpkgs-unstable {
    system = pkgs.stdenv.hostPlatform.system;
    config.allowUnfree = true;
  };
in
```

**Secret Management:**
- Uses agenix for encrypted secrets
- Secrets are encrypted for specific users and hosts defined in `secrets/secrets.nix`
- NixOS: secrets loaded via `inputs.agenix.nixosModules.age`
- Darwin: secrets loaded via `inputs.agenix.darwinModules.default`
- Home-manager: uses `inputs.agenix.homeManagerModules.default`

**SSH Key Fetching:**
User configurations use a common pattern to fetch SSH keys from GitHub:
```nix
fetchKeys = username:
  (builtins.fetchurl {
    url = "https://github.com/${username}.keys";
    sha256 = "<hash>";
  });
```

### Host-Specific Notes

**io (macOS):**
- Primary macOS workstation with yabai (tiling window manager) + skhd + sketchybar
- Uses homebrew for casks (fonts, GUI apps)
- Custom yabai rules for app-to-space assignments

**anubis (NixOS):**
- Media/storage server with Plex, Jellyfin, NFS, and Samba
- Uses ZFS pool "mercury" for storage
- Impermanence setup for stateless configuration
- Sanoid/Syncoid for ZFS snapshot management

**neptune (NixOS):**
- Appears to be a router/network appliance (has `router.nix`)

### Configuration Files to Check

When modifying configurations:
1. Check if changes should be in `modules/common/` (affects all hosts)
2. Check if changes should be in `hm/common/` (affects all users)
3. Platform-specific changes go in `modules/common/darwin-common.nix` or `modules/common/sys-default.nix`
4. Host-specific overrides go in `hosts/<hostname>/`

### Common Development Patterns

**Adding a New Package System-Wide:**
- NixOS: Add to `environment.systemPackages` in relevant module
- Darwin: Add to `environment.systemPackages` in host config or darwin-common

**Adding a New Package to User Environment:**
Add to `hm/common/cli.nix` in `home.packages`

**Modifying Window Manager on macOS:**
Edit `hosts/io/default.nix` - yabai config, skhd keybindings, sketchybar settings

**ZFS Management:**
- Check `hosts/anubis/sanoid.nix` and `hosts/anubis/syncoid.nix` for backup configurations
- ZFS pools are defined in host-specific configs with `boot.zfs.extraPools`
