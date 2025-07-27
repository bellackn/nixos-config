{ pkgs, ... }:

with pkgs;
[
  # General
  cachix

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
  devenv
  jq
  k9s
  kubectl
  kubectx
  kubernetes-helm
  krew
  libmysqlclient
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
