{ pkgs, ... }:

with pkgs; [
  # General
  gnupg

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
  shfmt
]
