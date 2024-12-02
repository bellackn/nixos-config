{ pkgs, ... }:

with pkgs; [
  # General
  cachix
  gnupg
  protonmail-bridge-gui

  # CLI
  bat
  doggo
  dust
  fzf
  htop
  just
  neofetch
  ripgrep

  # Dev
  nixpkgs-fmt
  poetry
  shfmt
]
