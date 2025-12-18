{
  description = "Wash's nix flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-darwin.url = "github:NixOS/nixpkgs/nixpkgs-25.11-darwin";
    impermanence.url = "github:nix-community/impermanence";
    firefox-addons.url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
    claude-code.url = "github:sadjow/claude-code-nix";
    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    eww = {
      url = "github:elkowar/eww";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    agenix-rekey = {
      url = "github:oddlama/agenix-rekey";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    darwin = {
      url = "github:nix-darwin/nix-darwin/nix-darwin-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {self, darwin, nixpkgs, nixpkgs-unstable, home-manager, claude-code, ... }@inputs:
  let
    inherit (self) outputs;
    lib = nixpkgs.lib // home-manager.lib // darwin.lib;
  in
  {
    inherit lib;
    nixosConfigurations = {
      anubis = lib.nixosSystem {
        specialArgs = { inherit inputs outputs; };
        modules = [
          ./hosts/anubis
        ];
      };
      neptune = lib.nixosSystem {
        specialArgs = { inherit inputs outputs; };
        modules = [
          ./hosts/neptune
        ];
      };
      zelda = lib.nixosSystem {
        specialArgs = { inherit inputs outputs; };
        modules = [
          ./hosts/zelda
        ];
      };
      nixmacVM = lib.nixosSystem {
        specialArgs = { inherit inputs outputs; };
        modules = [
          ./hosts/nixmacVM
        ];
      };
    };
    darwinConfigurations = {
      io = lib.darwinSystem {
        specialArgs = { inherit inputs outputs; };
        modules = [
            ./hosts/io
            {
              nixpkgs.overlays = [ claude-code.overlays.default ];
            }
          ];
      };
      saturn = lib.darwinSystem {
        specialArgs = { inherit inputs outputs; };
        modules = [
          ./hosts/saturn
        ];
      };
    };
  };
}
