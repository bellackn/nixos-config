{ pkgs, ... }:

with pkgs;
[
  alacritty-theme
  bat
  btop
  cachix
  devenv
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
  neofetch
  nixfmt-rfc-style
  nmap
  opentofu
  poetry
  ripgrep
  rustup
  shfmt
  vault
  zola

  # Fonts
  corefonts
  nerd-fonts.droid-sans-mono
  nerd-fonts.fira-code
  noto-fonts
  noto-fonts-color-emoji
]
