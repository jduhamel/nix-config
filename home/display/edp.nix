# Configuration for the eDP display of the Tongfang laptop (default: HDMI-1)
{ config, lib, pkgs, stdenv,  ... }:

let
  hdmiOn = false;

  base = pkgs.callPackage ../home.nix { inherit config lib pkgs stdenv; };

  browser = pkgs.callPackage ../programs/browsers/firefox.nix {
    inherit config pkgs hdmiOn;
  };

  laptopBar = pkgs.callPackage ../services/polybar/bar.nix {
    font0 = 20;
    font1 = 24;
    font2 = 38;
    font3 = 36;
    font4 = 10;
    font5 = 20;
  };

  spotify = import ../programs/spotify/default.nix {
    inherit pkgs hdmiOn;
  };

  statusBar = import ../services/polybar/default.nix {
    inherit config pkgs;
    mainBar = laptopBar;
    openCalendar = "";
  };

  terminal = import ../programs/kitty/default.nix {  inherit config pkgs; };

  wm = import ../programs/xmonad/default.nix {
    inherit config pkgs lib hdmiOn ;
  };
in
{
  imports = [
    ../home.nix
    statusBar
    terminal
    wm
  ];

  programs.firefox = browser.programs.firefox;

  home.packages = base.home.packages ++ [ spotify ];
}
