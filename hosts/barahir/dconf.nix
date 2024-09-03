{ lib, ... }:

with lib.hm.gvariant;

{
  dconf.settings = {
    # Input sources
    "org/gnome/desktop/input-sources" =
      {
        mru-sources = [
          (mkTuple [ "xkb" "us" ])
        ];
        sources = [
          (mkTuple [ "xkb" "us" ])
          (mkTuple [ "xkb" "de" ])
        ];
      };

    # Keyboard shortcuts
    "org/gnome/settings-daemon/plugins/media-keys" = {
      custom-keybindings = [
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/"
      ];
    };
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
      name = "Alacritty w/ tmux";
      command = "alacritty -e tmux attach";
      binding = "<Super>Return";
    };
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1" = {
      name = "Alacritty";
      command = "alacritty";
      binding = "<Ctrl><Alt>t";
    };
  };
}
