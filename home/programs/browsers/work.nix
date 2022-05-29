{ pkgs, ... }:

let
  firefox = "${pkgs.firefox-unwrapped}/bin/firefox";
in
  pkgs.writeShellScriptBin "work-browser" ''${firefox} -p "demo" -new-tab $1''
