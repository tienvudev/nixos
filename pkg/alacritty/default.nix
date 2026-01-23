{ pkgs, util, ... }:

{
  programs.alacritty.enable = true;

  xdg.configFile."alacritty/alacritty.toml" = util.mkSrc ./conf.toml;
}
