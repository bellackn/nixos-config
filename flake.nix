{
  description = "NixOS config flake";

  inputs = {
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixvim.url = "github:nix-community/nixvim";
    sops-nix.url = "github:Mic92/sops-nix";
  };

  outputs = { self, nixpkgs, nixvim, ... }@inputs: {
    nixosConfigurations = {

      # Lenovo T14s
      barahir = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        modules = [
          ./hosts/barahir/configuration.nix
          inputs.home-manager.nixosModules.default
          inputs.home-manager.nixosModules.home-manager
          {
            home-manager.sharedModules = [
              nixvim.homeManagerModules.nixvim
            ];
          }
          inputs.sops-nix.nixosModules.sops
        ];
      };

      # To add more configs:
      # workmachine = nixpkgs.lib.nixosSystem { ... }

    };
  };
}
