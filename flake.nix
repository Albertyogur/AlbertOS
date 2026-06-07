{
  description = "Albert's NixOS flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs";

    nixvim.url =  "github:nix-community/nixvim";
    nixvim.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, nixvim, ... }
    @inputs: {
    nixosConfigurations.zenbook-air = nixpkgs.lib.nixosSystem {
      modules = [
        ./configuration.nix
	nixvim.nixosModules.nixvim
	./mods/nixvim.nix
      ];
    };
  };
}
