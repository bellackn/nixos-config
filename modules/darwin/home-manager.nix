{
  config,
  pkgs,
  lib,
  home-manager,
  ...
}:

let
  user = "n2o";
in
{
  imports = [
    ./dock
  ];

  users.users.${user} = {
    name = "${user}";
    home = "/Users/${user}";
    isHidden = false;
    shell = pkgs.zsh;
  };

  home-manager = {
    useGlobalPkgs = true;
    users.${user} =
      {
        pkgs,
        config,
        lib,
        ...
      }:
      {
        home = {
          enableNixpkgsReleaseCheck = false;
          stateVersion = "24.05";

          packages = pkgs.callPackage ./packages.nix { };

          # Set pinentry program
          file.".gnupg/gpg-agent.conf".text = ''
            pinentry-program ${pkgs.pinentry_mac}/bin/pinentry-mac
          '';
        };

        programs = { } // import ../shared/dotfiles.nix { inherit pkgs; };
      };
  };

  homebrew = {
    # This is a module from nix-darwin
    # Homebrew is *installed* via the flake input nix-homebrew
    enable = true;
    onActivation = {
      autoUpdate = true;
      cleanup = "uninstall";
      upgrade = true;
    };

    brews = [
      "gnupg"
    ];

    casks = pkgs.callPackage ./casks.nix { };

    # These app IDs are from using the mas CLI app
    # mas = mac app store
    # https://github.com/mas-cli/mas
    #
    # $ nix shell nixpkgs#mas
    # $ mas search <app name>
    #
    masApps = {
      "ausweisapp" = 948660805;
      "wireguard" = 1451685025;
    };
  };

  # Fully declarative dock using the latest from Nix Store
  local.dock.enable = true;
  local.dock.entries = [
    { path = "/Applications/Launchpad.app/"; }
    { path = "/Applications/Calendar.app/"; }
    { path = "/Applications/Mail.app/"; }
    { path = "/Applications/Proton Mail.app/"; }
    { path = "/Applications/KeePassXC.app/"; }
    { path = "/Applications/Vivaldi.app/"; }
    { path = "/Applications/Signal.app/"; }
    { path = "/Applications/Threema.app/"; }
    { path = "/Applications/Slack.app/"; }
    { path = "/Applications/Alacritty.app/"; }
    { path = "/Applications/VSCodium.app/"; }
    { path = "/Applications/Wireguard.app/"; }
    { path = "/Applications/Spotify.app/"; }
  ];
}
