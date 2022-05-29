{ pkgs, ... }:

let
  # obtained via `autorandr --fingerprint`
  #
DP-2-1=" 00ffffffffffff004f2e00304e61bc002b170104a50000782aa2d0ac5130b425105054a54b00d1c00101818001010101010101010101641900404100263018883600122221000019000000fd003b471e6d10010a202020202020000000fc004e6f6e2d506e500a2020202020000000fe000a2020202020202020202020200095";
DP-2-2=" 00ffffffffffff0009d1507945540000301d0103804627782e5995af4f42af260f5054a56b80d1c0b300a9c08180810081c00101010122cc0050f0703e8018103500ba892100001a000000ff0054424b30313536323031390a20000000fd00184c1e873c000a202020202020000000fc0042656e5120455733323730550a01fd02034df1515d5e5f6061101f2221200514041312030123090707830100006d030c002000187820006001020367d85dc401788001681a00000101283cfde305e001e40f180000e6060501544c2c565e00a0a0a029502f203500ba892100001abf650050a0402e6008200808ba892100001c0000000000000000000000000000cf";
eDP-1=" 00ffffffffffff004d10ad14000000002a1c0104a51d11780ede50a3544c99260f5054000000010101010101010101010101010101014dd000a0f0703e803020350026a510000018a4a600a0f0703e803020350026a510000018000000fe00305239394b804c513133334431000000000002410328011200000b010a20200041";
  msiOptixId = "00ffffffffffff003669a23d010101011c1d010380462778eef8c5a556509e26115054bfef80714f81c08100814081809500b300a9404dd000a0f0703e8030203500bc862100001e000000fd001e4b1f873c000a202020202020000000fc004d4147333231435552560a2020000000ff0044413241303139323830303430012c020346f153010203040510111213141f2021225d5e5f616023091707830100006d030c001000383c20006003020167d85dc401788003e40f000006e305e301e60607015c5c0004740030f2705a80b0588a00bc862100001e565e00a0a0a0295030203500bc862100001e1b2150a051001e3048883500bc862100001e0000002f";
  tongfangId = "00ffffffffffff004d10c31400000000091d0104a522137807de50a3544c99260f5054000000010101010101010101010101010101011a3680a070381d403020350058c210000018000000fd00303c42420d010a202020202020000000100000000000000000000000000000000000fc004c513135364d314a5730310a20006b";

  notify = "${pkgs.libnotify}/bin/notify-send";
in
{
  programs.autorandr = {
    enable = true;

    hooks = {
      predetect = {};

      preswitch = {};

      postswitch = {
        "notify-xmonad" = ''
          ${notify} -i display "Display profile" "$AUTORANDR_CURRENT_PROFILE"
        '';

        "change-dpi" = ''
          case "$AUTORANDR_CURRENT_PROFILE" in
            away)
              DPI=120
              ;;
            home)
              DPI=96
              ;;
            *)
              ${notify} -i display "Unknown profle: $AUTORANDR_CURRENT_PROFILE"
              exit 1
          esac

          echo "Xft.dpi: $DPI" | ${pkgs.xorg.xrdb}/bin/xrdb -merge
        '';
      };
    };

    profiles = {
      "away" = {
        fingerprint = {
          eDP = eDP-1;
        };

        config = {
          eDP = {
            enable = true;
            crtc = 0;
            primary = true;
            position = "0x0";
            mode = "3840x2160";
            rate = "60.04";
            rotate = "normal";
          };
        };
      };

      "home" = {
        fingerprint = {
          DP-1 = DP-2-1;
          DP-2 = DP-2-2;
          eDP = tongfangId;
        };

        config = {
          DP-1 = {
            enable = true;
            crtc = 0;
            primary = true;
            position = "0x0";
            mode = "3840x2160";
            rate = "60.00";
          };
          DP-2 = {
            enable = true;
            crtc = 0;
            primary = true;
            position = "0x0";
            mode = "3840x2160";
            rate = "60.00";
          };
          eDP = {
            enable = true;
            crtc = 1;
            position = "0x0";
            mode = "3840x2160";
            rate = "60.04";
            rotate = "normal";
          };
        };
      };
    };

  };
}
