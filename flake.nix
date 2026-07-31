{
  description = "Hyprland on Nixos";

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
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      dms,
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
    in
    {
      nixosConfigurations.boxes = mkSystem ./hosts/boxes/default.nix;
    };
}
