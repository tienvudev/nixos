{ lib, tienvu, ... }@arg:

let
  t = tienvu arg "zbook16";
in

t.mkHost {
  system.stateVersion = "25.11";

  time.timeZone = "Asia/Ho_Chi_Minh";

  deps = [
    "niri"
    "waydroid"
  ];

  feats.local = true;

  services = {
    netbird.enable = true;
  };

  users = {
    tienvu.sudo = true;
  };
}
