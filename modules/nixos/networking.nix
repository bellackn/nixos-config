{ config, ... }:

{
  networking.networkmanager.enable = true;
  networking.hostName = "barahir";

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = true;

  # DNS resolver
  services.resolved = {
    enable = true;
    dnsovertls = "opportunistic";
    dnssec = "allow-downgrade";
  };

  networking.wg-quick.interfaces = {
    home = {
      autostart = false;
      address = [ "192.168.66.2/32" ];
      dns = [ "192.168.104.1" "wg.hof-trotzdem.de" ];
      mtu = 1400;
      privateKeyFile = config.sops.secrets."vpn/home-key".path;
      peers = [
        {
          allowedIPs = [ "0.0.0.0/0" "::/0" ];
          endpoint = config.sops.templates."home-endpoint".path;
          persistentKeepalive = 25;
          publicKey = "p3LMRDKv6WyIAEPG/bTQ4McfTGu/7E/pwzbp8bQqJW8=";
        }
      ];
    };

    proton = {
      autostart = false;
      address = [ "10.2.0.2/32" ];
      dns = [ "10.2.0.1" ];
      privateKeyFile = config.sops.secrets."vpn/proton-key".path;
      peers = [
        {
          allowedIPs = [ "0.0.0.0/0" "::/0" ];
          endpoint = "185.177.124.219:51820";
          persistentKeepalive = 25;
          publicKey = "GqrhIyCiFfxq4hRI46+//Qtevp2D+gqzAIZrMAL//XM=";
        }
      ];
    };

    vino = {
      autostart = false;
      address = [ "10.192.122.14/32" ];
      dns = [ "192.168.188.1" "fritz.box" ];
      privateKeyFile = config.sops.secrets."vpn/vino-key".path;
      peers = [
        {
          allowedIPs = [ "192.168.188.0/24" "10.192.122.0/24" ];
          endpoint = config.sops.templates."vino-endpoint".path;
          persistentKeepalive = 25;
          publicKey = "aRCDI7DHb6+e/VVh2+NHswnYHQwTn0KJDBvRzueVqi4=";
        }
      ];
    };
  };

  sops.secrets = {
    "vpn/home-key" = { };
    "vpn/home-endpoint" = { };
    "vpn/proton-key" = { };
    "vpn/vino-key" = { };
    "vpn/vino-endpoint" = { };
  };

  # SOPS templates are necessary to render config files with secrets in it
  # on "build-time". Using ".path" as with the "privateKeyFile" setting doesn't
  # work; wg-quick will fail with something like this: 
  #   Unable to find port of endpoint: `/run/secrets/vpn/home-endpoint'
  # => It takes the path as value, whereas we want the content of that path.
  sops.templates = {
    "home-endpoint".content = "${config.sops.placeholder."vpn/home-endpoint"}";
    "vino-endpoint".content = "${config.sops.placeholder."vpn/vino-endpoint"}";
  };
}
