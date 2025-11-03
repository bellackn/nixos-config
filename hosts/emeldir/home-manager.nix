{
  config,
  pkgs,
  lib,
  home-manager,
  ...
}:

let
  user = "n.bellack";
in
{
  imports = [
    ../../modules/darwin/dock
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

          packages = (pkgs.callPackage ../../modules/darwin/packages.nix { }) ++ [
            azure-cli
          ];

          sessionVariables = {
            SOPS_AGE_KEY_FILE = "/Users/${user}/.config/sops/age/keys.txt";
            SOPS_FILE = "../../secrets/secrets.yaml";
          };

          file.".gnupg/gpg-agent.conf".text = ''
            pinentry-program ${pkgs.pinentry_mac}/bin/pinentry-mac
          '';

          file.".gradle/gradle.properties".text = ''
            gpr.user=bellackn
            gpr.key=
          '';

          file.".config/sops/age/keys.txt".source = "/Users/${user}/.config/sops/age/keys.txt";
          file.".config/sops/secrets.yaml".source = ../../secrets/secrets.yaml;
        };

        programs = lib.mkMerge [
          (import ../../modules/shared/dotfiles.nix { inherit pkgs; })
          {
            git.settings.user.email = lib.mkForce "n.bellack@hundt-consult.de";
            git.signing.key = lib.mkForce "D06EC812C1C259E6";

          }
        ];
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

    casks = (pkgs.callPackage ../../modules/darwin/casks.nix { }) ++ [ ];

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
    { path = "/Applications/Apps.app/"; }
    { path = "/Applications/KeePassXC.app/"; }
    { path = "/Applications/Microsoft Outlook.app/"; }
    { path = "/Applications/Microsoft Teams.app/"; }
    { path = "/Applications/Vivaldi.app/"; }
    { path = "/Applications/VSCodium.app/"; }
    { path = "/Applications/Spotify.app/"; }
  ];
}
