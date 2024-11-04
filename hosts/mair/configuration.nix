{ config, inputs, lib, pkgs, ... }:

{
  # Temporary bugfix; cf. https://github.com/LnL7/nix-darwin/issues/1041
  nixpkgs.overlays = [
    (_: prev: {
      inherit (inputs.nixpkgs-stable.legacyPackages.${prev.system}) karabiner-elements;
    })
  ];

  environment.systemPackages = with pkgs; [
    nixpkgs-fmt
  ];

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  services.karabiner-elements.enable = true;
  # nix.package = pkgs.nix;

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
