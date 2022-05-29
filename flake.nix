{
  description = "jduhamel's nixos config";
    nixConfig.substituters = [
    "https://cache.nixos.org"
    "https://jduhamel-nixos.cachix.org"
    "https://nix-community.cachix.org"
    "https://pre-commit-hooks.cachix.org"
  ];
  nixConfig.trusted-public-keys = [
    "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
    "jduhamel-nixos.cachix.org-1:jwXnlnlOileKAFwgn/jddIc43hyy+D32nFtodwvbsyU="
    "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    "pre-commit-hooks.cachix.org-1:Pkk3Panw5AW24TOv6kz3PvLhlH8puAsJTBbOPmBo7Rc="
  ];

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";

    nixos-hardware.url = github:NixOS/nixos-hardware/master;

    nurpkgs = {
      url = github:nix-community/NUR;
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = github:nix-community/home-manager;
      inputs.nixpkgs.follows = "nixpkgs";
    };

    impermanence.url = "github:nix-community/impermanence";

    pre-commit-hooks = {
      url = "github:cachix/pre-commit-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "utils";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    ragenix = {
      url = "github:yaxitech/ragenix";
      inputs.flake-utils.follows = "utils";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nur.url = "nur";
    emacs-overlay.url = "github:nix-community/emacs-overlay";
    templates.url = "github:NixOS/templates";
  };

  outputs = inputs @ { self, nixpkgs, ... }@inputs:
    let
      system = "x86_64-linux";
    in
    {
      homeConfigurations = (
        import ./outputs/home-conf.nix {
          inherit system nixpkgs nurpkgs home-manager tex2nix;
        }
      );

       modules = [
        nixos-hardware.nixosModules.dell-xps-13-9380
     ];

    nixosConfigurations = (
        import ./outputs/nixos-conf.nix {
          inherit (nixpkgs) lib;
          inherit inputs system;
        }
      );

      devShell.${system} = (
        import ./outputs/installation.nix {
          inherit system nixpkgs;
        }
      );
    };
}
