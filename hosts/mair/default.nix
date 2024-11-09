{ config, inputs, lib, pkgs, ... }:

let
  user = "n2o";
in
{
  imports = [
    ../../modules/darwin/home-manager.nix
    ../../modules/shared
  ];

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;

  system = {
    # Used for backwards compatibility, please read the changelog before changing.
    # $ darwin-rebuild changelog
    stateVersion = 4;
  };

  # Load configuration that is shared across systems
  environment.systemPackages = with pkgs; [ ] ++ (import ../../modules/shared/packages.nix { inherit pkgs; });
}
