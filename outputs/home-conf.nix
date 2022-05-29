{ system, nixpkgs, nurpkgs, home-manager, ... }:

let
  username = "joe";
  homeDirectory = "/home/${username}";
  configHome = "${homeDirectory}/.config";

  pkgs = import nixpkgs {
    inherit system;

    config.allowUnfree = true;
    config.xdg.configHome = configHome;

    overlays = [
      nurpkgs.overlay
      (import ../overlays/nheko)
      (import ../overlays/ranger)
    ];
  };

  nur = import nurpkgs {
    inherit pkgs;
    nurpkgs = pkgs;
  };

  mkHome = conf: (
    home-manager.lib.homeManagerConfiguration rec {
      inherit pkgs system username homeDirectory;

      stateVersion = "21.03";
      configuration = conf;
    });

  edpConf = import ../display/edp.nix {
    inherit nur pkgs;
    inherit (pkgs) config lib stdenv;
  };

  hdmiConf = import ../display/hdmi.nix {
    inherit nur pkgs;
    inherit (pkgs) config lib stdenv;
  };
in
{
  jduhamel-edp = mkHome edpConf;
  jduhamel-hdmi = mkHome hdmiConf;
}
