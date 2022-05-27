# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{
  imports =
    [
      <nixos-hardware/dell/xps/13-9380>
      ./hardware-configuration.nix
      ./boot-load.nix
      ./dell-xps.nix
      ./wm/xmonad.nix
    ];
}
