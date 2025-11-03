{ config, pkgs, ... }:

{
  services.skhd = {
    enable = true;
    skhdConfig = ''
      # Alacritty w/ tmux
      cmd - return : open -a Alacritty --args -e tmux attach
    '';
  };
}
