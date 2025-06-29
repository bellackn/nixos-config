{
  config,
  lib,
  pkgs,
  ...
}:

{
  networking.hostName = "barahir";

  networking.networkmanager = {
    enable = true;
    dns = "none"; # dnsmasq takes care of this
  };

  networking.search = [
    "z.lan"
  ];

  services.dnsmasq = {
    enable = true;
    settings = {
      conf-dir = "/var/lib/dnsmasq";
      listen-address = [
        "127.0.0.1"
        "::1"
      ];
      # Upstream servers will be used in reverse order!
      strict-order = true;
      server = [
        "2620:fe::fe:11"
        "2620:fe::11"
        "149.112.112.11"
        "9.9.9.11"
        "192.168.0.108"
        "/sanktionsfrei.intern/10.66.3.2"
        "/nezk.de/10.5.0.1"
        "/z.lan/192.168.0.108"
      ];
    };
  };

  networking.resolvconf.useLocalResolver = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = true;

  services.openvpn.servers = {
    nezk = {
      config = "config /home/n2o/Nextcloud/Arbeit/KundInnen/NEZK/nezk.ovpn";
      autoStart = false;
    };
  };

  networking.wg-quick.interfaces = {
    home = {
      autostart = false;
      address = [ "192.168.66.2/24" ];
      mtu = 1400;
      privateKeyFile = config.sops.secrets."vpn/home-key".path;
      peers = [
        {
          allowedIPs = [
            "192.168.0.0/24"
          ];
          # SOPS cannot use secrets on evaluation time:
          # https://github.com/Mic92/sops-nix?tab=readme-ov-file#using-secrets-at-evaluation-time
          # So to make this here work, a dirty (but very simple) workaround is to
          # use a dummy value for the endpoint, build the system, then use the
          # actual value afterwards and build again.
          endpoint = builtins.readFile config.sops.secrets."vpn/home-endpoint".path;
          persistentKeepalive = 25;
          publicKey = "p3LMRDKv6WyIAEPG/bTQ4McfTGu/7E/pwzbp8bQqJW8=";
        }
      ];
    };

    proton = {
      autostart = false;
      address = [ "10.2.0.2/24" ];
      privateKeyFile = config.sops.secrets."vpn/proton-key".path;
      peers = [
        {
          allowedIPs = [
            "0.0.0.0/0"
            "::/0"
          ];
          endpoint = "185.177.124.219:51820";
          persistentKeepalive = 25;
          publicKey = "GqrhIyCiFfxq4hRI46+//Qtevp2D+gqzAIZrMAL//XM=";
        }
      ];
    };

    sf = {
      autostart = false;
      address = [ "10.66.100.101/32" ];
      privateKeyFile = config.sops.secrets."vpn/sf-key".path;
      peers = [
        {
          allowedIPs = [
            "10.66.0.0/16"
          ];
          endpoint = builtins.readFile config.sops.secrets."vpn/sf-endpoint".path;
          persistentKeepalive = 25;
          publicKey = "WRf+hvqV1Pep7dvwsJHBkDSMKjUIySkYihBWtX1/hjw=";
        }
      ];
    };

    vino = {
      autostart = false;
      address = [ "10.192.122.14/24" ];
      privateKeyFile = config.sops.secrets."vpn/vino-key".path;
      peers = [
        {
          allowedIPs = [
            "192.168.188.0/24"
            "10.192.122.0/24"
          ];
          endpoint = builtins.readFile config.sops.secrets."vpn/vino-endpoint".path;
          persistentKeepalive = 25;
          publicKey = "aRCDI7DHb6+e/VVh2+NHswnYHQwTn0KJDBvRzueVqi4=";
        }
      ];
      postUp = ''
        echo "server=/fritz.box/192.168.188.1" > /var/lib/dnsmasq/vino-vpn.conf
        systemctl restart dnsmasq
      '';
      postDown = ''
        rm -f /var/lib/dnsmasq/vino-vpn.conf
        systemctl restart dnsmasq
      '';
    };
  };

  sops.secrets = {
    "vpn/home-key" = { };
    "vpn/home-endpoint" = { };
    "vpn/proton-key" = { };
    "vpn/sf-endpoint" = { };
    "vpn/sf-key" = { };
    "vpn/vino-key" = { };
    "vpn/vino-endpoint" = { };
  };

}
