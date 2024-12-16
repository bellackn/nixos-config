{ pkgs }:

with pkgs;
let shared-packages = import ../shared/packages.nix { inherit pkgs; }; in
shared-packages ++ [
  # General
  cryptomator
  firefox
  keepassxc
  libreoffice
  mattermost-desktop
  nextcloud-client
  protonmail-bridge-gui
  protonmail-desktop
  seahorse
  signal-desktop
  slack
  spotify
  threema-desktop
  thunderbird
  vivaldi
  whatsapp-for-linux

  # Dev
  ansible-lint
  autoconf
  aw-server-rust
  aw-watcher-afk
  aw-watcher-window
  dconf2nix
  devenv
  doctl
  gcc
  gnumake
  k9s
  kubectl
  kubectl
  krew
  opentofu
  nmap
  tcpdump

  # System libraries
  openssl
  zlib

  # Fonts
  corefonts
  nerd-fonts.droid-sans-mono
  nerd-fonts.fira-code
  noto-fonts
  noto-fonts-emoji
  vistafonts
]
