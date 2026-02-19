{ tienvu, ... }@arg:

let
  t = tienvu arg "ghostty";
in

t.mkHome {
  programs.ghostty.enable = true;

  xdg.configFile."ghostty/config" = t.mkSrc ./cfg.ini;
}
