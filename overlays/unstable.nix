# Exposes nixpkgs-unstable as `pkgs.unstable`, sharing the system and config
# (e.g. allowUnfree) of the main package set.
nixpkgs-unstable: final: prev: {
  unstable = import nixpkgs-unstable {
    inherit (final.stdenv.hostPlatform) system;
    config = final.config;
  };
}
