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

          packages = (pkgs.callPackage ../../modules/darwin/packages.nix { }) ++ [
            azure-cli
            flyway
            gitlab-ci-ls
          ];

          sessionVariables = {
            SOPS_AGE_KEY_FILE = "/Users/${user}/.config/sops/age/keys.txt";
          };

          file.".gnupg/gpg-agent.conf".text = ''
            pinentry-program ${pkgs.pinentry_mac}/bin/pinentry-mac
          '';

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
    backupFileExtension = "hmbak";
  };

  homebrew = {
    # Homebrew is *installed* via the flake input nix-homebrew
    # `enable`, `onActivation`, and `taps` are set in ../../modules/darwin/homebrew.nix

    brews = [
      "dotnet" # The version maintained on homebrew is more compatible with macOS than what nixpkgs currently has
      "infracost"
      # "mssql-tools18" - installed manually since accepting the EULA (HOMEBREW_ACCEPT_EULA=Y) seems not to work via nix
      "powershell"
    ];

    casks = (pkgs.callPackage ../../modules/darwin/casks.nix { }) ++ [
      "bruno"
      "claude"
      "claude-code"
      "linear"
      "microsoft-azure-storage-explorer"
      "mongodb-compass"
      "voicemod"
    ];
  };

  # Fully declarative dock using the latest from Nix Store
  local.dock.enable = true;
  local.dock.entries = [
    { path = "/Applications/Apps.app/"; }
    { path = "/Applications/Calendar.app/"; }
    { path = "/Applications/KeePassXC.app/"; }
    { path = "/Applications/Azure VPN Client.app/"; }
    { path = "/Applications/Microsoft Outlook.app/"; }
    { path = "/Applications/Microsoft Teams.app/"; }
    { path = "/Applications/Linear.app/"; }
    { path = "/Applications/Alacritty.app/"; }
    { path = "/Applications/Vivaldi.app/"; }
    { path = "/Applications/VSCodium.app/"; }
    { path = "/Applications/Spotify.app/"; }
    { path = "/Applications/Signal.app/"; }
    { path = "/Applications/Telegram.app/"; }
  ];
}
