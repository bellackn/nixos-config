{ config, ... }:

let
  localDomain = "wg.hof-trotzdem.de";
in
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
      dns = [
        "192.168.104.1"
        "${localDomain}"
      ];
      mtu = 1400;
      privateKeyFile = config.sops.secrets."vpn/home-key".path;
      peers = [
        {
          allowedIPs = [
            "0.0.0.0/0"
            "::/0"
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
      address = [ "10.2.0.2/32" ];
      dns = [ "10.2.0.1" ];
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

    vino = {
      autostart = false;
      address = [ "10.192.122.14/32" ];
      dns = [
        "192.168.188.1"
        "fritz.box"
      ];
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
    };
  };

  sops.secrets = {
    "vpn/home-key" = { };
    "vpn/home-endpoint" = { };
    "vpn/proton-key" = { };
    "vpn/vino-key" = { };
    "vpn/vino-endpoint" = { };
  };

}
