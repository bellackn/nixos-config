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
    ../../modules/darwin/dock
    ../../modules/darwin/homebrew.nix
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
        home = with pkgs; {
          enableNixpkgsReleaseCheck = false;
          stateVersion = "24.05";

          sessionPath = [ "$HOME/.local/bin" ];

          packages = (pkgs.callPackage ../../modules/darwin/packages.nix { }) ++ [ ];

          # Set pinentry program
          file.".gnupg/gpg-agent.conf".text = ''
            pinentry-program ${pkgs.pinentry_mac}/bin/pinentry-mac
          '';
        };

        programs = lib.mkMerge [
          (import ../../modules/shared/dotfiles.nix { inherit pkgs; })
          { }
        ];
      };
    backupFileExtension = "hmbak";
  };

  homebrew = {
    # Homebrew is *installed* via the flake input nix-homebrew
    # `enable`, `onActivation`, and `taps` are set in ../../modules/darwin/homebrew.nix

    casks = (pkgs.callPackage ../../modules/darwin/casks.nix { }) ++ [
      "balenaetcher"
      "cyberduck"
      "slack"
      "threema"
      "vlc"
    ];

    # These app IDs are from using the mas CLI app
    # mas = mac app store
    # https://github.com/mas-cli/mas
    #
    # $ nix shell nixpkgs#mas
    # $ mas search <app name>
    #
    masApps = {
      "word" = 462054704;
    };
  };

  # Fully declarative dock using the latest from Nix Store
  local.dock.enable = true;
  local.dock.entries = [
    { path = "/Applications/Apps.app/"; }
    { path = "/Applications/KeePassXC.app/"; }
    { path = "/Applications/Calendar.app/"; }
    { path = "/Applications/Mail.app/"; }
    { path = "/Applications/Vivaldi.app/"; }
    { path = "/Applications/Signal.app/"; }
    { path = "/Applications/Telegram.app/"; }
    { path = "/Applications/Threema.app/"; }
    { path = "/Applications/Alacritty.app/"; }
    { path = "/Applications/VSCodium.app/"; }
    { path = "/Applications/Spotify.app/"; }
  ];
}
