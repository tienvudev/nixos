{
  lib,
  pkgs,
  tienvu,
  ...
}@arg:

let
  t = tienvu arg "zbook16";
in

t.mkHost {
  system.stateVersion = "25.11";

  time.timeZone = "Asia/Ho_Chi_Minh";

  feats.local = true;

  deps = [
    "niri"
    "waydroid"
  ];

  programs = {
    nix-ld.enable = true;
    steam.enable = true;
  };

  services = {
    netbird.enable = true;
    teamviewer.enable = true;
    udisks2.enable = true;
  };

  systemd.services.netbird = {
    path = with pkgs; [ shadow ];
  };

  users = {
    tienvu.sudo = true;
  };
}
