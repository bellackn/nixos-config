{ pkgs }:

with pkgs;
let shared-packages = import ../shared/packages.nix { inherit pkgs; }; in
shared-packages ++ [
  ansible-lint
  autoconf
  aw-server-rust
  aw-watcher-afk
  aw-watcher-window
  bat
  cryptomator
  dconf2nix
  devenv
  doctl
  doggo
  dust
  firefox
  fzf
  gcc
  gnumake
  htop
  just
  k9s
  keepassxc
  kubectl
  kubectx
  krew
  libreoffice
  mattermost-desktop
  neofetch
  nextcloud-client
  nixpkgs-fmt
  nmap
  openssl
  opentofu
  protonmail-desktop
  ripgrep
  seahorse
  shfmt
  signal-desktop
  slack
  spotify
  tcpdump
  threema-desktop
  thunderbird
  vivaldi
  zlib

  # Fonts
  corefonts
  (pkgs.nerdfonts.override { fonts = [ "DroidSansMono" "FiraCode" ]; })
  noto-fonts
  noto-fonts-emoji
  vistafonts
]
