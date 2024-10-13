{ inputs, config, pkgs, ...}: 
{
boot.kernel.sysctl = {
  # if you use ipv4, this is all you need
  "net.ipv4.conf.all.forwarding" = true;

  # If you want to use it for ipv6
  "net.ipv6.conf.all.forwarding" = true;

  # source: https://github.com/mdlayher/homelab/blob/master/nixos/routnerr-2/configuration.nix#L52
  # By default, not automatically configure any IPv6 addresses.
  "net.ipv6.conf.all.accept_ra" = 0;
  "net.ipv6.conf.all.autoconf" = 0;
  "net.ipv6.conf.all.use_tempaddr" = 0;

  # On WAN, allow IPv6 autoconfiguration and tempory address use.
  "net.ipv6.conf.wan.accept_ra" = 2;
  "net.ipv6.conf.wan.autoconf" = 1;

  # Better network performance
  "net.core.default_qdisc" = "fq";
  "net.ipv4.tcp_congestion_control" = "bbr";
};

services.kea.dhcp4 = {
    enable = true;
    settings = {
      interfaces-config = {
        interfaces = [ "enp2s0" ];
      };
      lease-database = {
        name = "/var/lib/kea/dhcp4.leases";
        persist = true;
        type = "memfile";
      };
      option-data = [
        {
          name = "domain-name-servers";
          data = "1.1.1.1";
          always-send = true;
        }
        {
          name = "routers";
          data = "10.1.1.1";
        }
        {
          name = "domain-name";
          data = "${config.networking.hostName}.lan";
        }
      ];

      rebind-timer = 2000;
      renew-timer = 1000;
      valid-lifetime = 4000;

      subnet4 = [
        {
          pools = [
            {
              pool = "10.1.1.5 - 10.1.1.200";
            }
          ];
          subnet = "10.1.1.0/24";
#          reservations = [
#            {
#              hw-address = mac-address;
#              ip-address = ip-address;
#            }
#            {
#              hw-address = mac-address;
#              ip-address = ip-address;
#            }
#          ];
        }
      ];
    };
  };

networking = {
  nat = { 
    enable = true;
    internalInterfaces = [ "enp2s0" ];
    externalInterface = "enp1s0";
  };

  interfaces = {
    enp1s0.useDHCP = true;
    enp2s0 = 
    {
      useDHCP = false;
      ipv4.addresses = [{
        address = "10.1.1.1";
        prefixLength = 24;
      }];
    };
  };
  firewall.interfaces."enp2s0" = {
    allowedTCPPorts = [ 31225 ];
    allowedUDPPorts = [ 31225 ];
  };
};

}
