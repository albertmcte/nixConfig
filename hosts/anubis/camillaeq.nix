{ pkgs, ... }:

let
  camillaeq = pkgs.callPackage ../../pkgs/camillaeq.nix { };
in
{
  users.users.camillaeq = {
    isSystemUser = true;
    group = "camillaeq";
  };
  users.groups.camillaeq = { };

  systemd.services.camillaeq = {
    description = "CamillaEQ - Graphical equalizer for CamillaDSP";
    after = [ "network.target" ];
    wantedBy = [ "multi-user.target" ];

    environment = {
      NODE_ENV = "production";
      SERVER_PORT = "3001";
      SERVER_HOST = "0.0.0.0";
      CAMILLA_CONTROL_WS_URL = "ws://127.0.0.1:1234";
      CAMILLA_SPECTRUM_WS_URL = "ws://127.0.0.1:1234";
    };

    serviceConfig = {
      Type = "simple";
      User = "camillaeq";
      Group = "camillaeq";
      StateDirectory = "camillaeq";
      ExecStart = "${camillaeq}/bin/camillaeq";
      Restart = "on-failure";
      RestartSec = 5;
    };
  };

  networking.firewall.allowedTCPPorts = [ 3001 ];

  environment.systemPackages = [ camillaeq ];
}
