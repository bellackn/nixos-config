{
  description = "NixOS config flake";

  inputs = {
    darwin.url = "github:lnl7/nix-darwin";
    darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    mac-app-util.url = "github:hraban/mac-app-util";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-24.05";
    nixvim.url = "github:nix-community/nixvim";
    sops-nix.url = "github:Mic92/sops-nix";
  };

  outputs = { self, nixpkgs, nixvim, darwin, mac-app-util, ... }@inputs: {
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
    };

    darwinConfigurations = {

      # MacBook Air M2
      mair = darwin.lib.darwinSystem {
        specialArgs = { inherit inputs; };
        modules = [
          ./hosts/mair/configuration.nix
          inputs.home-manager.darwinModules.home-manager
          inputs.mac-app-util.darwinModules.default
          {
            home-manager.sharedModules = [
              mac-app-util.homeManagerModules.default
              nixvim.homeManagerModules.nixvim
            ];
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
          }
        ];
      };
    };

  };
}
