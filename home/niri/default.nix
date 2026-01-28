{ pkgs, mkUtil, ... }@arg:

let
  util = mkUtil arg "niri";
in

util.mkModule {
  deps = [
    "alacritty"
    "swaylock"
    "zellij"
  ];

  config = {
    services = {
      gnome-keyring.enable = true;
      playerctld.enable = true;
    };

    programs = {
      jq.enable = true;
    };

    home.packages = with pkgs; [
      brightnessctl
      wifitui
      wiremix
      nautilus
    ];

    xdg.configFile.niri = util.mkSrc ./conf;

    home.file.".local/bin/niri" = util.mkSrc ./bin;
  };
}
