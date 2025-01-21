{ lib, ... }:

with lib.hm.gvariant;

{
  dconf.settings = {

    "org/gnome/desktop/interface" = {
      font-antialiasing = "rgba";
      font-hinting = "slight";
    };

    "org/gnome/desktop/input-sources" = {
      mru-sources = [
        (mkTuple [ "xkb" "us" ])
      ];
      sources = [
        (mkTuple [ "xkb" "us" ])
        (mkTuple [ "xkb" "de" ])
      ];
    };

    "org/gnome/desktop/wm/preferences" = {
      button-layout = "appmenu:minimize,maximize,close";
    };


    # Keyboard shortcuts
    "org/gnome/settings-daemon/plugins/media-keys" = {
      custom-keybindings = [
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/"
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2/"
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

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2" = {
      name = "rofimoji";
      command = "rofimoji --selector wofi --action clipboard --typer xdotool";
      binding = "<Super>period";
    };

    "org/gnome/shell/keybindings" = {
      show-screenshot-ui = ["<Shift><Super>4"];
    };
  };
}
