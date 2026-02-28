{ pkgs, lib, config, ... }:

let
  ticktickMcpDir = "${config.home.homeDirectory}/.local/share/ticktick-mcp";

  mcpServers = {
    context7 = {
      type = "stdio";
      command = "npx";
      args = [ "-y" "@upstash/context7-mcp" ];
    };
    ticktick = {
      type = "stdio";
      command = "${lib.getExe pkgs.uv}";
      args = [ "run" "--directory" ticktickMcpDir "-m" "ticktick_mcp.cli" "run" ];
    };
  };

  mcpJson = builtins.toJSON { inherit mcpServers; };
in
{
  home.packages = [ pkgs.uv ];

  home.activation.ticktickMcpRepo = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    if [ ! -d "${ticktickMcpDir}" ]; then
      ${lib.getExe pkgs.git} clone https://github.com/jacepark12/ticktick-mcp.git "${ticktickMcpDir}"
      ${lib.getExe pkgs.uv} venv "${ticktickMcpDir}/.venv"
      ${lib.getExe pkgs.uv} pip install --python "${ticktickMcpDir}/.venv/bin/python" -e "${ticktickMcpDir}"
    fi
  '';

  home.activation.claudeMcpServers = lib.hm.dag.entryAfter [ "writeBoundary" "ticktickMcpRepo" ] ''
    claude_json="$HOME/.claude.json"

    if [ ! -f "$claude_json" ]; then
      echo '{}' > "$claude_json"
    fi

    ${lib.getExe pkgs.jq} -s '.[0] * .[1]' \
      "$claude_json" \
      <(echo '${mcpJson}') \
      > "$claude_json.tmp" \
    && mv "$claude_json.tmp" "$claude_json"
  '';
}
