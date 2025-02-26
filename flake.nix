{
  description = "Wash's nix flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-darwin.url = "github:NixOS/nixpkgs/nixpkgs-24.11-darwin";
    impermanence.url = "github:nix-community/impermanence";
    firefox-addons.url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
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
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    darwin = {
      url = "github:lnl7/nix-darwin/nix-darwin-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {self, darwin, nixpkgs, nixpkgs-unstable, home-manager, ... }@inputs:
  let
    inherit (self) outputs;
    lib = nixpkgs.lib // home-manager.lib // darwin.lib;
#    systems = [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ];

#    forEachSystem = f: lib.genAttrs systems (sys: f pkgsFor.${sys});
#    pkgsFor = nixpkgs.legacyPackages;
    
#    unstableFor = nixpkgs-unstable.legacyPackages;
#    forEachUnstable = f: lib.genAttrs systems (sys: f unstableFor.${sys});
  in
#  let
#    system = "x86_64-linux";
#    pkgs = import nixpkgs { inherit system; };
#    unstable = import nixpkgs-unstable { inherit system; };
#    specialArgs = { inherit self inputs unstable; };
#    extraSpecialArgs = specialArgs;
#  in
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
        ];
      };
      saturn = lib.darwinSystem {
        system = "x86_64-darwin";
        specialArgs = { inherit inputs outputs; };
        modules = [
          ./hosts/io
        ];
      };
    };
  };
}
