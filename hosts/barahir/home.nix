{ config, pkgs, ... }:

{
  imports = [
    ./dconf.nix
    ../../modules/activitywatch.nix
    ../../modules/alacritty.nix
    ../../modules/git.nix
    ../../modules/shellnanigans.nix
    ../../modules/tmux.nix
    ../../modules/vim.nix
    ../../modules/vscode.nix
    ../../modules/zsh.nix
  ];

  home.username = "n2o";
  home.homeDirectory = "/home/n2o";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  # Install user-specific packages
  home.packages = with pkgs; [
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
    thunderbird
    vivaldi
    zlib

    # Fonts
    corefonts
    (pkgs.nerdfonts.override { fonts = [ "DroidSansMono" "FiraCode" ]; })
    noto-fonts
    noto-fonts-emoji
    vistafonts
  ];

  # Allow managing fonts via home-manager
  fonts.fontconfig.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
