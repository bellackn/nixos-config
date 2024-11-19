{ config, inputs, lib, pkgs, ... }:

let
  user = "n2o";
in
{
  imports = [
    ../../modules/darwin/home-manager.nix
    ../../modules/shared
  ];

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;

  nix = {
    package = pkgs.nix;

    settings = {
      trusted-users = [ "@admin" "${user}" ];
    };

    gc = {
      user = "root";
      automatic = true;
      interval = { Weekday = 0; Hour = 2; Minute = 0; };
      options = "--delete-older-than 30d";
    };

    # Turn this on to make command line easier
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  environment.systemPackages = with pkgs; [
    pinentry_mac
  ] ++ (import ../../modules/shared/packages.nix { inherit pkgs; });

  system = {
    # Used for backwards compatibility, please read the changelog before changing.
    # $ darwin-rebuild changelog
    stateVersion = 4;

    # Turn off NIX_PATH warnings now that we're using flakes
    checks.verifyNixPath = false;

    defaults = {
      LaunchServices = {
        LSQuarantine = false;
      };

      ".GlobalPreferences" = {
        # Equals "Boop" under sound settings
        "com.apple.sound.beep.sound" = "/System/Library/Sounds/Tink.aiff";
      };

      NSGlobalDomain = {
        AppleShowAllExtensions = true;
        ApplePressAndHoldEnabled = false;

        # 120, 90, 60, 30, 12, 6, 2
        KeyRepeat = 2;

        # 120, 94, 68, 35, 25, 15
        InitialKeyRepeat = 15;

        "com.apple.sound.beep.volume" = 0.5;
        "com.apple.sound.beep.feedback" = 1;
      };

      dock = {
        autohide = false;
        show-recents = false;
        launchanim = true;
        mouse-over-hilite-stack = true;
        orientation = "bottom";
        tilesize = 48;
      };

      trackpad = {
        TrackpadThreeFingerDrag = true;
      };
    };

    keyboard = {
      enableKeyMapping = true;
      remapCapsLockToControl = true;
    };
  };
}
