{
  description = "jackdbd's NixOS & Home Manager configuration";

  inputs = {
    # nixpkgs channels
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-23.11";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    
    nixos-hardware = {
      url = "github:NixOS/nixos-hardware/master";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ home-manager, nixos-hardware, nixpkgs, sops-nix, ... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      # homeConfigurations."jack" = home-manager.lib.homeManagerConfiguration {
      #   inherit pkgs;

      #   modules = [
      #     ./machines/x220/configuration.nix
      #     sops-nix.nixosModules.sops
      #   ];
      # };
      nixosConfigurations."x220-nixos" = nixpkgs.lib.nixosSystem {
        modules = [
          # add your model from this list: https://github.com/NixOS/nixos-hardware/blob/master/flake.nix
          nixos-hardware.nixosModules.lenovo-thinkpad-x220
          ./machines/x220/configuration.nix
          sops-nix.nixosModules.sops
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.jack = import ./users/jack.nix;
            # Optionally, use home-manager.extraSpecialArgs to pass
            # arguments to users/jack.nix
          }
        ];
        specialArgs = { inherit inputs; };
        system = system;
    };
  };
}