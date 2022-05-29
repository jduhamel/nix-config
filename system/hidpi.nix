{ config, lib, pkgs, ... }: {
  hardware.video.hidpi.enable = lib.mkDefault true;
  console.earlySetup = true;
  services.xserver.displayManager.lightdm.greeters.gtk.extraConfig =
    "xft-dpi=221";
}
