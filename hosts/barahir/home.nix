{ config, pkgs, ... }:

{
  imports = [
    ./dconf.nix
    ../../modules/alacritty.nix
    ../../modules/git.nix
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

  # Allow managing fonts via home-manager
  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    dconf2nix
    keepassxc
    nextcloud-client
    nixpkgs-fmt
    nmap
    protonmail-bridge
    seahorse
    shfmt
    signal-desktop
    thunderbird
    vivaldi

    (pkgs.nerdfonts.override { fonts = [ "DroidSansMono" "FiraCode" ]; })
  ];

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

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/n2o/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    EDITOR = "nvim";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
