{ pkgs }:

with pkgs;
let
  shared-packages = import ../shared/packages.nix { inherit pkgs; };
in
shared-packages
++ [
  # General
  alsa-utils
  cryptomator
  firefox
  gnupg
  keepassxc
  libreoffice
  mattermost-desktop
  nextcloud-client
  protonmail-bridge-gui
  protonmail-desktop
  rofimoji
  roomarranger
  seahorse
  signal-desktop
  slack
  spotify
  threema-desktop
  thunderbird
  vivaldi
  whatsapp-for-linux
  wofi
  xdotool

  # Dev
  ansible-lint
  autoconf
  aw-server-rust
  aw-watcher-afk
  aw-watcher-window
  dconf2nix
  docker-buildx
  doctl
  gcc
  gnumake
  opentofu
  openvpn
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

  # LaTeX
  texlive.combined.scheme-full
  texstudio
]
