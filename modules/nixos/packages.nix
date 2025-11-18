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
  wasistlos
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

  # LaTeX
  texlive.combined.scheme-full
  texstudio

  # Fonts
  vista-fonts
]
