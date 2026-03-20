{ pkgs, lib, config, ... }:

{
  virtualisation.oci-containers.backend = "podman";

  # Enable container name DNS for Podman networks + open n8n port
  networking.firewall.interfaces = let
    matchAll = if !config.networking.nftables.enable then "podman+" else "podman*";
  in {
    "${matchAll}".allowedUDPPorts = [ 53 ];
    "enp5s0".allowedTCPPorts = [ 5678 ];
  };

  # n8n container
  virtualisation.oci-containers.containers."n8n" = {
    image = "docker.n8n.io/n8nio/n8n";
    environment = {
      "GENERIC_TIMEZONE" = "America/New_York";
      "N8N_ENFORCE_SETTINGS_FILE_PERMISSIONS" = "true";
      "N8N_HOST" = "n8n.washatka.net";
      "N8N_PORT" = "5678";
      "N8N_PROTOCOL" = "https";
      "N8N_RUNNERS_ENABLED" = "true";
      "NODE_ENV" = "production";
      "NODES_EXCLUDE" = "[]";
      "N8N_RESTRICT_FILE_ACCESS_TO" = "/files;/home/node/.n8n-files";
      "TZ" = "America/New_York";
      "WEBHOOK_URL" = "https://n8n.washatka.net/";
    };
    volumes = [
      "/home/wash/n8n-files:/files:rw"
      "n8n_data:/home/node/.n8n:rw"
    ];
    ports = [
      "0.0.0.0:5678:5678/tcp"
    ];
    log-driver = "journald";
  };

  systemd.services."podman-n8n" = {
    serviceConfig = {
      Restart = lib.mkOverride 90 "always";
    };
    after = [
      "podman-volume-n8n_data.service"
    ];
    requires = [
      "podman-volume-n8n_data.service"
    ];
    wantedBy = [ "multi-user.target" ];
  };

  # Volume
  systemd.services."podman-volume-n8n_data" = {
    path = [ pkgs.podman ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
    };
    script = ''
      podman volume inspect n8n_data || podman volume create n8n_data
    '';
    wantedBy = [ "multi-user.target" ];
  };

}
