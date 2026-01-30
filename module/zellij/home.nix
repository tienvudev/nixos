{ mkUtil, ... }@arg:

let
  util = mkUtil arg "zellij";
in

util.extConfig {
  xdg.configFile."zellij/config.kdl" = util.mkSrc ./conf.kdl;
}
