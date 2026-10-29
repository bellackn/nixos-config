{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:

let
  user = "n2o";
in
{
  imports = [
    ./activitywatch.nix
    ./dconf.nix
  ];

  home = {
    enableNixpkgsReleaseCheck = false;
    username = "${user}";
    homeDirectory = "/home/${user}";

    packages = import ./packages.nix {
      inherit pkgs;
    };

    stateVersion = "24.05";
  };

  # Let Home Manager install and manage itself.
  programs = {
    home-manager.enable = true;
  }
  // import ../shared/dotfiles.nix { inherit pkgs; };

  # Allow managing fonts via home-manager
  fonts.fontconfig.enable = true;
}
