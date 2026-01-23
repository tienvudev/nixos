{ pkgs, util, ... }@arg:

{
  programs.zellij.enable = true;

  xdg.configFile."zellij/config.kdl" = util.mkSrc ./conf.kdl;
}
