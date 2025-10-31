{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:

let
  user = "n2o";
in
{
  imports = [
    ./home-manager.nix
    ../../modules/shared
  ];

  # Set default Nix build user group
  ids.gids.nixbld = 350;

  nix = {
    enable = true;

    settings = {
      trusted-users = [
        "@admin"
        "${user}"
      ];
    };

    gc = {
      automatic = true;
      interval = {
        Weekday = 0;
        Hour = 0;
        Minute = 0;
      };
      options = "--delete-older-than 30d";
    };

    # Turn this on to make command line easier
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  environment.systemPackages = with pkgs; [
    pinentry_mac
  ];

  system = {
    # Used for backwards compatibility, please read the changelog before changing.
    # $ darwin-rebuild changelog
    stateVersion = 4;

    primaryUser = "${user}";

    # Turn off NIX_PATH warnings now that we're using flakes
    checks.verifyNixPath = false;

    defaults = {
      LaunchServices = {
        LSQuarantine = false;
      };

      NSGlobalDomain = {
        AppleShowAllExtensions = true;
        ApplePressAndHoldEnabled = false;

        # 120, 90, 60, 30, 12, 6, 2
        KeyRepeat = 2;

        # 120, 94, 68, 35, 25, 15
        InitialKeyRepeat = 15;
      };

      dock = {
        autohide = false;
        show-recents = false;
        launchanim = true;
        mouse-over-hilite-stack = true;
        orientation = "bottom";
        tilesize = 48;
      };
    };

    keyboard = {
      enableKeyMapping = true;
      remapCapsLockToControl = true;
    };
  };

  services.skhd = {
    enable = true;
    skhdConfig = ''
      # Alacritty w/ tmux
      cmd - return : open -a Alacritty --args -e tmux attach
    '';
  };
}
