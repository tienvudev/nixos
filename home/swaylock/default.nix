{ mkUtil, ... }@arg:

let
  util = mkUtil arg "swaylock";
in

util.extConfig {
  xdg.configFile."swaylock/config" = util.mkSrc ./conf;
}
