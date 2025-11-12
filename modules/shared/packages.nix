{ pkgs, ... }:

with pkgs;
[
  alacritty-theme
  bat
  btop
  cachix
  devenv
  dive
  docker-compose
  doggo
  dust
  fzf
  htop
  jq
  just
  k9s
  krew
  kubectl
  kubectx
  kubernetes-helm
  mani
  neofetch
  nixfmt-rfc-style
  nmap
  opentofu
  poetry
  ripgrep
  rustup
  shfmt
  uv
  vault
  zola

  # Fonts
  corefonts
  nerd-fonts.droid-sans-mono
  nerd-fonts.fira-code
  noto-fonts
  noto-fonts-color-emoji
]
