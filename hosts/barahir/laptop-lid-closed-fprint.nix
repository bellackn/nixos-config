# Source: https://github.com/fzakaria/nix-home/blob/framework-laptop/modules/nixos/fprint-laptop-lid.nix
# - applied some minor changes to work with my system.
#
# On Lenovo T14s, the fingerprint sensor is this:
# Bus 001 Device 003: ID 27c6:6594 Shenzhen Goodix Technology Co.,Ltd. Goodix USB2.0 MISC

{ config, ... }:

{
  config.services.acpid = {
    enable = true;
    logEvents = true;

    lidEventCommands = ''
      lock=/tmp/fingerprint-reader-disabled

      # Match for either DP or HDMI
      if grep -Fq closed /proc/acpi/button/lid/LID/state &&
        (
          grep -Fxq connected /sys/class/drm/card1-DP-*/status ||
          grep -Fxq connected /sys/class/drm/card1-HDMI-*/status
        )
      then
        touch "$lock"
        echo 0 > /sys/bus/usb/devices/1-3/authorized
      elif [ -f "$lock" ]
      then
        echo 1 > /sys/bus/usb/devices/1-3/authorized
        rm "$lock"
      fi
    '';
  };
}
