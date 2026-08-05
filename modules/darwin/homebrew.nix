_:

# Shared homebrew defaults for all nix-darwin hosts.
{
  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      cleanup = "uninstall";
      upgrade = true;
    };

    # Declared explicitly so `brew bundle --force-cleanup` (from onActivation.cleanup) doesn't
    # try to untap these, which would cascade into uninstalling every cask/formula they contain.
    taps = [
      "homebrew/core"
      "homebrew/cask"
    ];

    brews = [
      "docker"
      "gnupg"
    ];

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
}
