{ mkUtil, ... }@arg:

let
  util = mkUtil arg "alacritty";
in

util.extConfig {
  xdg.configFile."alacritty/alacritty.toml" = util.mkSrc ./conf.toml;
}
