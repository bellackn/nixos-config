{
  description = "NixOS config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, ... }@inputs: {
    nixosConfigurations = {

      # Lenovo T14s
      barahir = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        modules = [
          ./hosts/barahir/configuration.nix
          inputs.home-manager.nixosModules.default
        ];
      };

      # To add more configs:
      # workmachine = nixpkgs.lib.nixosSystem { ... }

    };
  };
}
