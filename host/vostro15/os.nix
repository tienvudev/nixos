{
  lib,
  pkgs,
  tienvu,
  ...
}@arg:

let
  t = tienvu arg "vostro15";
in

t.mkHost {
  system.stateVersion = "26.05";

  time.timeZone = "Asia/Ho_Chi_Minh";

  feats.local = true;

  deps = [
    "gnome"
    # "niri"
    # "waydroid"
  ];

  programs = {
    # nix-ld.enable = true;
    # steam.enable = true;
  };

  services = {
    netbird.enable = true;
    # teamviewer.enable = true;
    # udisks2.enable = true;
  };

  systemd.services.netbird = {
    path = with pkgs; [ shadow ];
  };

  users = {
    tienvu.sudo = true;
  };
}
