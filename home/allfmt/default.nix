{ pkgs, mkUtil, ... }@arg:

let
  util = mkUtil arg "allfmt";
in

util.mkConfig {
  home.packages = [ (import ./pkg.nix pkgs) ];

  xdg.configFile.allfmt = util.mkSrc ./conf;
}
