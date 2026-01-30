{ ... }:

{
  time.timeZone = "Asia/Ho_Chi_Minh";

  programs = {
    niri.enable = true;
    waydroid.enable = true;
  };

  services = {
    netbird.enable = true;
  };
}
