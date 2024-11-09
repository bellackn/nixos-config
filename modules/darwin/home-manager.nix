{ config, pkgs, lib, home-manager, ... }:

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
    users.${user} = { pkgs, config, lib, ... }: {
      home = {
        enableNixpkgsReleaseCheck = false;
        stateVersion = "24.05";
      };

      programs = { } // import ../shared/dotfiles.nix { inherit pkgs; };
    };
  };

  homebrew = {
    # This is a module from nix-darwin
    # Homebrew is *installed* via the flake input nix-homebrew
    enable = true;
    onActivation.upgrade = true;

    casks = pkgs.callPackage ./casks.nix { };

    # These app IDs are from using the mas CLI app
    # mas = mac app store
    # https://github.com/mas-cli/mas
    #
    # $ nix shell nixpkgs#mas
    # $ mas search <app name>
    #
    masApps = {
      "wireguard" = 1451685025;
    };
  };

  # Fully declarative Dock using the latest from Nix Store
  local = {
    dock.enable = true;
    dock.entries = [
      { path = "/Applications/Launchpad.app/"; }
      { path = "/Applications/Calendar.app/"; }
    ];
  };
}
