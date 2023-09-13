{
  description = "Wash's nix flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-darwin.url = "github:NixOS/nixpkgs/nixpkgs-23.05-darwin";
    impermanence.url = "github:nix-community/impermanence";
    hyprland.url = "github:hyprwm/hyprland";
    hyprwm-contrib.url = "github:hyprwm/contrib";
    firefox-addons.url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
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
      url = "github:nix-community/home-manager/release-23.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    darwin = {
      url = "github:lnl7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
  };

  outputs = {nixpkgs, ...} @inputs:
  with inputs;
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs { inherit system; };
    specialArgs = { inherit self inputs; };
    extraSpecialArgs = specialArgs;
  in
  {
    nixosConfigurations = {
      "anubis" = nixpkgs.lib.nixosSystem {
        inherit system specialArgs;
        modules = [
          ./hosts/anubis
        ];
      };
      "neptune" = nixpkgs.lib.nixosSystem {
        inherit system specialArgs;
        modules = [
          ./hosts/neptune
        ];
      };
      "zelda" = nixpkgs.lib.nixosSystem {
        inherit system specialArgs;
        modules = [
          ./hosts/zelda
        ];
      };
      "nixmacVM" = nixpkgs.lib.nixosSystem {
        system = "aarch64-linux";
        inherit specialArgs;
        modules = [
          ./hosts/nixmacVM
        ];
      };
    };
    darwinConfigurations = {
      "io" = nixpkgs.lib.nixosSystem {
        system = "aarch64-darwin";
        inherit specialArgs;
        modules = [
          ./hosts/io
        ];
      };
    };
  };
}
