{ pkgs, ... }:

with pkgs;
[
  age
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
  gh
  glab
  helix
  htop
  jq
  just
  k9s
  krew
  kubectl
  kubectx
  kubernetes-helm
  mani
  fastfetch
  nixfmt
  nmap
  opentofu
  poetry
  poppler-utils
  ripgrep
  rustup
  shfmt
  sops
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
