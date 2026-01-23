{ util, ... }:

let
  mkIfEnable = util.mkIfEnable "niri";
in

{
  imports = [
    ../zellij
    ../alacritty
  ];

  services.gnome-keyring.enable = mkIfEnable true;

  programs = mkIfEnable {
    jq.enable = true;
  };

  xdg.configFile.niri = mkIfEnable (util.mkSrc ./conf);
  home.file.".local/bin/niri" = mkIfEnable (util.mkSrc ./bin);
}
