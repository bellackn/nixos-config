{ config, pkgs, lib, ... }:

let
  user = "n2o";
in
{
  home = {
    enableNixpkgsReleaseCheck = false;
    username = "${user}";
    homeDirectory = "/home/${user}";
    packages = pkgs.callPackage ./packages.nix { };
    file = shared-files // import ./files.nix { inherit user pkgs; };
    stateVersion = "21.05";
  };

  # Let Home Manager install and manage itself.
  programs = shared-programs // { home-manager.enable = true; };

  # Allow managing fonts via home-manager
  fonts.fontconfig.enable = true;
}
