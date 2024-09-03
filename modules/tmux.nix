{ pkgs, ... }:

{
  programs.tmux =
    {
      enable = true;
      baseIndex = 1;
      clock24 = true;
      keyMode = "vi";
      mouse = true;
      newSession = true;
      prefix = "C-a";

      extraConfig = ''
        # Split panes with + and -
        bind + split-window -h
        bind - split-window -v
        unbind '"'
        unbind %

        # Switch panes using Alt-Arrow w/o prefix
        bind -n M-Left select-pane -L
        bind -n M-Right select-pane -R
        bind -n M-Up select-pane -U
        bind -n M-Down select-pane -D

        # Synchronize panes on/off
        bind-key X set-window-option synchronize-panes\; display-message "synchronize-panes is now #{?pane_synchronized,on,off}"
      '';

      plugins = with pkgs;
        [
          {
            plugin = tmuxPlugins.net-speed;
            extraConfig = ''
              set -g @tmux_power_show_upload_speed true
              set -g @tmux_power_show_download_speed true
            '';
          }
          {
            plugin = tmuxPlugins.power-theme;
            extraConfig = "set -g @tmux_power_theme 'sky'";
          }
        ];
    };
}
