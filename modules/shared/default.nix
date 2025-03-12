{
  config,
  pkgs,
  lib,
  ...
}:

{
  nix.settings = {
    substituters = [
      "https://cache.nixos.org"
      "https://nix-community.cachix.org"
      "https://devenv.cachix.org"
    ];
    trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };

  nixpkgs = {
    config = {
      allowBroken = false;
      allowInsecure = false;
      allowUnfree = true;
    };
  };

  programs.direnv = {
    enable = true;
  };

  # Add fuse-t entry to /etc/hosts for Cryptomator
  networking.hosts = {
    "127.0.0.1" = [ "fuse-t" ];
  };
}
