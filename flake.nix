{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.05";
    impermanence.url = "github:nix-community/impermanence";
    agenix.url = "github:ryantm/agenix";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sops-nix = {
      url = "github:mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.nixpkgs-stable.follows = "nixpkgs";
    };
  };

  # what will be produced (i.e. the build)
  outputs = {nixpkgs, ...} @ inputs: {
    nixosConfigurations = {
      anubis = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = inputs;
        modules = [
          ./hosts/anubis
        ];
      };
      neptune = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = inputs;
        modules = [
          ./hosts/neptune
        ];
      };
      zelda = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = inputs;
        modules = [
          ./hosts/zelda
        ];
      };
    };
  };
}


#   outputs = { self, nixpkgs, home-manager, ... }@inputs:
#    let
#      inherit (self) outputs;
#      forEachSystem = nixpkgs.lib.genAttrs [ "x86_64-linux" "aarch64-linux" ];
#      forEachPkgs = f: forEachSystem (sys: f nixpkgs.legacyPackages.${sys});
#
#      mkNixos = modules: nixpkgs.lib.nixosSystem {
#        inherit modules;
#        specialArgs = { inherit inputs outputs; };
#      };
#      mkHome = modules: pkgs: home-manager.lib.homeManagerConfiguration {
#        inherit modules pkgs;
#        extraSpecialArgs = { inherit inputs outputs; };
#      };
#    in
#    {
#      nixosModules = import ./modules/nixos;
#      homeManagerModules = import ./modules/home-manager;
#      templates = import ./templates;
#
#      overlays = import ./overlays { inherit inputs outputs; };
#
#      packages = forEachPkgs (pkgs: (import ./pkgs { inherit pkgs; }) // {
#        neovim = let
#          homeCfg = mkHome [ ./home/misterio/generic.nix ] pkgs;
#        in pkgs.writeShellScriptBin "nvim" ''
#          ${homeCfg.config.programs.neovim.finalPackage}/bin/nvim \
#          -u ${homeCfg.config.xdg.configFile."nvim/init.lua".source} \
#          "$@"
#        '';
#      });
#      devShells = forEachPkgs (pkgs: import ./shell.nix { inherit pkgs; });
#      formatter = forEachPkgs (pkgs: pkgs.nixpkgs-fmt);
#
#      nixosConfigurations = {
#        anubis = mkNixos [ ./hosts/anubis ];
#        zelda = mkNixos [ ./hosts/zelda ];
#      };
#
#      homeConfigurations = {
#        "misterio@atlas" = mkHome [ ./home/misterio/atlas.nix ] nixpkgs.legacyPackages."x86_64-linux";
#        "misterio@maia" = mkHome [ ./home/misterio/maia.nix ] nixpkgs.legacyPackages."x86_64-linux";
#      };
#    };
#}
