{ pkgs }:

# Packages for all nix-darwin hosts
with pkgs;
let
  shared-packages = import ../shared/packages.nix { inherit pkgs; };
in
shared-packages
++ [
]
