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
    aw-server-rust
    aw-watcher-afk
    aw-watcher-window
    cryptomator
    dconf2nix
    doctl
    dogdns
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
    pipenv
    poetry
    protonmail-desktop
    python312
    seahorse
    shfmt
    signal-desktop
    slack
    tcpdump
    thunderbird

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

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Minor package settings can go here.
  #
}
