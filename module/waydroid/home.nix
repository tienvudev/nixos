{
  pkgs,
  inputs,
  mkUtil,
  ...
}@arg:

let
  util = mkUtil arg "waydroid";
in

util.mkConfig {
  home.packages = [
    inputs.waydroid-script.packages.${util.system}.default
  ];
}
