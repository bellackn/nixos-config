{ config, inputs, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [ ];

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;

  # Necessary for using flakes on this system.
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;

  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "aarch64-darwin";

  home-manager = {
    # Also pass inputs to home manager modules
    extraSpecialArgs = {
      inherit inputs;
    };
    users = {
      "nico" = import ./home.nix;
    };
  };

  users.users.nico = {
    name = "nico";
    home = "/Users/nico";
  };
}
