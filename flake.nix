{
  description = "NixOS desktop configuration";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    dms = {
      url = "github:AvengeMedia/DankMaterialShell/stable";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    helium = {
      url = "github:oxcl/nix-flake-helium-browser";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      dms,
      helium,
      zen-browser,
      ...
    }:
    let
      mkSystem =
        hostModule:
        nixpkgs.lib.nixosSystem {
          modules = [
            hostModule
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                extraSpecialArgs = {
                  inherit helium zen-browser;
                };
                users.lgo = {
                  imports = [
                    dms.homeModules.dank-material-shell
                    ./home.nix
                  ];
                };
                backupFileExtension = "backup";
              };
            }
          ];
        };

      boxesSystem = mkSystem ./hosts/boxes/default.nix;
      lenovoSystem = mkSystem ./hosts/lenovo/default.nix;
    in
    {
      nixosConfigurations.nixos-boxes = boxesSystem;
      nixosConfigurations.lenovo = lenovoSystem;
    };
}
