{ pkgs, ... }:

with pkgs; [
  # General
  cachix
  gnupg

  # CLI
  alacritty-theme
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
  vault
]
