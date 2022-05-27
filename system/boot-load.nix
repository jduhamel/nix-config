{ config, pkgs, ... }:

{

  hardware.enableAllFirmware = true;
  hardware.enableRedistributableFirmware = true;
  nixpkgs.config.allowUnfree = true;

  # Use the GRUB 2 boot loader.
  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    supportedFilesystems = [ "btrfs" ];

    loader = {
      systemd-boot.enable = false; # use grub instead

      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot/efi";
      };

      grub = {
        enable = true;
        efiSupport = true;
        useOSProber = true;
        gfxmodeEfi = "1920x1440x32";
        device = "nodev";
        version = 2;
        # splashImage = ./resources/fallout-grub-theme/background.png;
        font = "${pkgs.hack-font}/share/fonts/hack/Hack-Regular.ttf";
        fontSize = 36;
        theme = pkgs.fetchFromGitHub {
          owner = "shvchk";
          repo = "fallout-grub-theme";
          sha256 = "1mO18CLLySPRNHYMBL3upql5Zp8DaDyJnww7/zALjLI=";
          rev = "7ff2c6e98d904291f9e4e0e1c82261be6df534f0";
        };
      };
    };
  };

  networking.hostName = "dell";

}
