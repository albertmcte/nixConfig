{ pkgs, ... }:

let
  camillagui = pkgs.callPackage ../../pkgs/camillagui.nix { };

  configFile = pkgs.writeText "camillagui.yml" ''
    ---
    camilla_host: "127.0.0.1"
    camilla_port: 1234
    port: 5005
    bind_address: "0.0.0.0"
    ssl_certificate: ~
    ssl_private_key: ~
    config_dir: "/var/lib/camilladsp/configs"
    coeff_dir: "/var/lib/camilladsp/coeffs"
    default_config: "/var/lib/camilladsp/default_config.yml"
    statefile_path: "/var/lib/camilladsp/statefile.yml"
    log_file: "/var/lib/camilladsp/camilladsp.log"
    gui_config_file: ~
    on_set_active_config: ~
    on_get_active_config: ~
    supported_capture_types: ~
    supported_playback_types: ~
  '';
in
{
  users.users.camillagui = {
    isSystemUser = true;
    group = "camillagui";
    extraGroups = [ "audio" ];
  };
  users.groups.camillagui = { };

  systemd.services.camillagui = {
    description = "CamillaGUI - Web interface for CamillaDSP";
    after = [ "network.target" ];
    wantedBy = [ "multi-user.target" ];

    serviceConfig = {
      Type = "simple";
      User = "camillagui";
      Group = "camillagui";
      ExecStart = "${camillagui}/bin/camillagui -c ${configFile}";
      Restart = "on-failure";
      RestartSec = 5;

      # Allow access to shared CamillaDSP state directories
      ReadWritePaths = [ "/var/lib/camilladsp" ];
    };
  };

  networking.firewall.allowedTCPPorts = [ 5005 ];

  environment.systemPackages = [ camillagui ];
}
