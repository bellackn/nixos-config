{ pkgs }:

with pkgs;
let shared-packages = import ../shared/packages.nix { inherit pkgs; }; in
shared-packages ++ [
  # General
  #cryptomator - TODO 24-11-12 broken
  firefox
  keepassxc
  mattermost-desktop
  nextcloud-client
  protonmail-desktop
  seahorse
  signal-desktop
  slack
  spotify
  threema-desktop
  thunderbird
  vivaldi

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
  (pkgs.nerdfonts.override { fonts = [ "DroidSansMono" "FiraCode" ]; })
  noto-fonts
  noto-fonts-emoji
  vistafonts
]
