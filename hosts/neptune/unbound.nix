{ inputs, config, pkgs, ... }:
{
services.unbound = {
    enable = true;
    settings = {
      server = {
        interface = [ "127.0.0.1" "10.1.1.1" ];
#        port = "5513";
        tls-system-cert = true;
        access-control = [
          "0.0.0.0/0 refuse"
          "127.0.0.0/8 allow"
          "10.1.1.0/24 allow"
        ];

#        prefer-ip6 = true;

        private-domain = [ "local" "lan" ];
        private-address = [
          "10.1.1.0/8"
        ];
        unblock-lan-zones = true;
        insecure-lan-zones = true;
      };
      forward-zone = [
        {
          name = ".";
          forward-tls-upstream = true;
          forward-ssl-upstream = true;
          forward-addr = [
            "45.90.28.0#ed2bdf.dns1.nextdns.io"
            "2a07:a8c0::#ed2bdf.dns1.nextdns.io"
            "45.90.30.0#ed2bdf.dns2.nextdns.io"
            "2a07:a8c1::#ed2bdf.dns2.nextdns.io"

#            "1.1.1.1@853#cloudflare-dns.com"
#            "8.8.8.8@853:dns.google"
#            "1.0.0.1@853#cloudflare-dns.com"
#            "8.8.4.4@853#dns.google"
          ];
        }
      ];
      remote-control.control-enable = false;
    };
  };
}
