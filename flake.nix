{
  description = "Albert's NixOS flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs";

    nixvim.url = "github:nix-community/nixvim";
    nixvim.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    minegrub-theme.url = "github:Lxtharia/minegrub-theme";

    orbbec-gemini335le.url = "path:/home/albert/orbbec-gemini335le";
  };

  outputs =
    {
      nixpkgs,
      nixvim,
      home-manager,
      minegrub-theme,
      orbbec-gemini335le,
      ...
    }:
    {
      nixosConfigurations.zenbook-air = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./configuration.nix
          nixvim.nixosModules.nixvim
          ./mods/nixvim.nix
          minegrub-theme.nixosModules.default
          ./mods/grub.nix
          ./mods/fish.nix
          ./mods/fonts.nix
          ./mods/mirrors.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;

            home-manager.users.albert = import ./mods/home.nix;
          }
          orbbec-gemini335le.nixosModules.orbbec-gemini335le
        ];
      };
    };
}
