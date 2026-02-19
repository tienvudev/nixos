{ tienvu, ... }@arg:

let
  t = tienvu arg "swaylock";
in

t.mkHome {
  programs.swaylock.enable = true;

  xdg.configFile."swaylock/config" = t.mkSrc ./cfg.ini;
}
