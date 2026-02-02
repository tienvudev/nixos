{ pkgs, mkUtil, ... }@arg:

let
  util = mkUtil arg "niri";
in

util.mkConfig {
  programs = {
    ghostty.enable = true;
    jq.enable = true;
    swaylock.enable = true;
  };

  services = {
    gnome-keyring.enable = true;
    playerctld.enable = true;
  };

  home.packages = with pkgs; [
    brightnessctl
    wifitui
    wiremix
    nautilus
  ];

  xdg.configFile.niri = util.mkSrc ./conf;

  home.file.".local/bin/niri" = util.mkSrc ./bin;
}
