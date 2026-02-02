{ mkUtil, ... }@arg:

let
  util = mkUtil arg "ghostty";
in

util.extConfig {
  xdg.configFile."ghostty/config" = util.mkSrc ./conf.ini;
}
