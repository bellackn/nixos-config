{
  description = "General Purpose Configuration for macOS and NixOS";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixvim.url = "github:nix-community/nixvim";
    sops-nix.url = "github:Mic92/sops-nix";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    darwin = {
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-homebrew = {
      url = "github:zhaofengli-wip/nix-homebrew";
    };

    # Taps
    hashicorp-tap = {
      url = "github:hashicorp/homebrew-tap";
      flake = false;
    };
    homebrew-bundle = {
      url = "github:homebrew/homebrew-bundle";
      flake = false;
    };
    homebrew-cask = {
      url = "github:homebrew/homebrew-cask";
      flake = false;
    };
    homebrew-core = {
      url = "github:homebrew/homebrew-core";
      flake = false;
    };
  };

  outputs =
    { self
    , nixpkgs
    , home-manager
    , nixvim
    , sops-nix
    , darwin
    , nix-homebrew
    , hashicorp-tap
    , homebrew-bundle
    , homebrew-cask
    , homebrew-core
    }@inputs:
    let
      user = "n2o";
    in
    {
      darwinConfigurations = {

        # MacBook Air M2
        mair = darwin.lib.darwinSystem {
          system = "aarch64-darwin";
          specialArgs = inputs;
          modules = [
            home-manager.darwinModules.home-manager
            {
              home-manager.sharedModules = [
                nixvim.homeManagerModules.nixvim
              ];
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
            }
            nix-homebrew.darwinModules.nix-homebrew
            {
              nix-homebrew = {
                inherit user;
                enable = true;
                taps = {
                  "hashicorp/tap" = hashicorp-tap;
                  "homebrew/homebrew-bundle" = homebrew-bundle;
                  "homebrew/homebrew-cask" = homebrew-cask;
                  "homebrew/homebrew-core" = homebrew-core;
                };
                mutableTaps = false;
                autoMigrate = true;
              };
            }
            ./hosts/mair
          ];
        };
      };
    };
}
