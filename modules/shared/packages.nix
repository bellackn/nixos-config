{ pkgs, ... }:

with pkgs; [
  # General
  gnupg

  # CLI
  fzf
  just

  # Dev
  nixpkgs-fmt
]
