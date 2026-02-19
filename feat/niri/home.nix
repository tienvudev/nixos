{ pkgs, tienvu, ... }@arg:

let
  t = tienvu arg "niri";
in

t.mkHome {
  deps = [
    "ghostty"
    "swaylock"
  ];

  programs = {
    jq.enable = true;
  };

  services = {
    easyeffects.enable = true;
    gnome-keyring.enable = true;
    playerctld.enable = true;
  };

  home.packages = with pkgs; [
    brightnessctl
    wifitui
    wiremix
    nautilus
  ];

  xdg.configFile.niri = t.mkSrc ./cfg;

  home.file = t.mkBin ./bin;
}
