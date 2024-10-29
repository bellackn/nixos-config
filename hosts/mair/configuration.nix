{ config, inputs, lib, pkgs, ... }:

{
    nixpkgs.overlays = [
      (_: prev: {
        # https://github.com/LnL7/nix-darwin/issues/1041
        inherit (inputs.nixpkgs-stable.legacyPackages.${prev.system}) karabiner-elements;
      })
    ];

    environment.systemPackages =
    [ pkgs.nixpkgs-fmt ];

    # Auto upgrade nix package and the daemon service.
    services.nix-daemon.enable = true;
    services.karabiner-elements.enable = true;
    # nix.package = pkgs.nix;

    # Necessary for using flakes on this system.
    nix.settings.experimental-features = "nix-command flakes";

    # Create /etc/zshrc that loads the nix-darwin environment.
    programs.zsh.enable = true;  # default shell on catalina
    # programs.fish.enable = true;

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