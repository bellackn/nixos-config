{ pkgs, ... }:

with pkgs;
[
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
  jq
  k9s
  kubectl
  kubectx
  krew
  nixfmt-rfc-style
  nmap
  opentofu
  poetry
  rustup
  shfmt
  vault
  zola
]
