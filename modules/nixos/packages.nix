{ pkgs, inputs }:

with pkgs;
let
  shared-packages = import ../shared/packages.nix {
    inherit pkgs;
  };

  unstable = import inputs.nixpkgs-unstable { };
in
shared-packages
++ [
  # General
  alsa-utils
  cryptomator
  firefox
  gnupg
  karere
  keepassxc
  libreoffice
  mattermost-desktop
  nextcloud-client
  unstable.orca-slicer
  protonmail-bridge-gui
  protonmail-desktop
  rofimoji
  seahorse
  signal-desktop
  slack
  spotify
  telegram-desktop
  threema-desktop
  thunderbird
  vivaldi
  vlc
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
  vista-fonts
]
