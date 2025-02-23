{ pkgs, ... }:

with pkgs;
[
  # General
  cachix
  gnupg

  # CLI
  alacritty-theme
  bat
  btop
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
  kubernetes-helm
  krew
  nixfmt-rfc-style
  nmap
  ollama
  opentofu
  poetry
  rustup
  shfmt
  vault
  zola
]
