{ config, pkgs, ... }:
{
  # enable the tailscale service
  services.tailscale = {
    enable = true;
    useRoutingFeatures = "both";
  };
  
  # create a oneshot job to authenticate to Tailscale
  systemd.services.tailscale-autoconnect = {
    description = "Automatic connection to Tailscale";

    # make sure tailscale is running before trying to connect to tailscale
    after = ["network-pre.target" "tailscale.service"];
    wants = ["network-pre.target" "tailscale.service"];
    wantedBy = ["multi-user.target"];
    serviceConfig.Type = "oneshot";
    script = with pkgs; ''
      # wait for tailscaled to settle
      sleep 2

      NETDEV="$(/run/current-system/sw/bin/ip -o route get 8.8.8.8 | cut -f 5 -d " ")"
      ${pkgs.ethtool}/bin/ethtool -K $NETDEV rx-udp-gro-forwarding on rx-gro-list off

      status="$(${tailscale}/bin/tailscale status -json | ${jq}/bin/jq -r .BackendState)"
      if [ $status = "Running" ]; then # if so, then do nothing
        exit 0
      fi

      ${tailscale}/bin/tailscale up --authkey $(cat ${config.age.secrets.tailscale_key.path}) --advertise-exit-node
    '';
  };

  environment.systemPackages = with pkgs; [
    tailscale
    iproute2
    ethtool
  ];

  # Open ports in the firewall.
  networking.firewall = {
    trustedInterfaces = ["tailscale0"];
    allowedUDPPorts = [config.services.tailscale.port];
    #checkReversePath shouldn't be needed with useRoutingFeatures
    #    checkReversePath = "loose";
  };

  age.secrets.tailscale_key.file = ../../secrets/tailscale_key.age;
}
