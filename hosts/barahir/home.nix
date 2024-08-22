{ config, pkgs, ... }:

{
  imports = [
    ../../modules/home-manager/alacritty.nix
    ../../modules/home-manager/vscode.nix
    ../../modules/home-manager/zsh.nix
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
    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })
    (pkgs.nerdfonts.override { fonts = [ "DroidSansMono" "FiraCode" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
    alacritty
    keepassxc
    nextcloud-client
    nixpkgs-fmt
    shfmt
    vivaldi
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

  # Programs Settings
  # =================

  # Git
  programs.git = {
    enable = true;
    userName = "Nico Bellack";
    userEmail = "nico@bellack.dev";
  };

  # Nextcloud
  # Create a custom autostart entry for Nextcloud
  home.file.".config/autostart/nextcloud.desktop".text = ''
    [Desktop Entry]
    Type=Application
    Exec=${pkgs.nextcloud-client}/bin/nextcloud
    Hidden=false
    NoDisplay=false
    X-GNOME-Autostart-enabled=true
    Name=Nextcloud
    Comment=Start Nextcloud client after login
  '';

  # Vim
  programs.neovim = {
    enable = true;
  };

}
