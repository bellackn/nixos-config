{ pkgs, ... }:

with pkgs; [
  # General

  # CLI
  fzf
  just

  # Dev
  nixpkgs-fmt
]
