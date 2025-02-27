# Until Room Arranger gets accepted at nixpkgs, we can install it like so.
# See https://github.com/NixOS/nixpkgs/pull/384740
final: prev: {
  roomarranger = import /home/n2o/dev/nixpkgs/pkgs/by-name/ro/roomarranger/package.nix {
    inherit (prev)
      stdenv
      fetchurl
      autoPatchelfHook
      qt6
      gtk3
      makeDesktopItem
      lib
      ;
  };
}
