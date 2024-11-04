{ config, pkgs, ... }:

{
  imports = [
    ../../modules/alacritty.nix
    ../../modules/git.nix
    ../../modules/tmux.nix
    ../../modules/vim.nix
    ../../modules/zsh.nix
  ];

  home.username = "nico";
  home.homeDirectory = "/Users/nico";

  # Home Manager needs a bit of information about you and the paths it should
  # manage.

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  home.packages = with pkgs; [
    neofetch

    # Fonts
    (pkgs.nerdfonts.override { fonts = [ "DroidSansMono" "FiraCode" ]; })
  ];

  # Allow managing fonts via home-manager
  fonts.fontconfig.enable = true;

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
