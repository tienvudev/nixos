nixpkgs:

let
  dirs = builtins.attrNames (builtins.readDir ../module);

  pkgs = builtins.filter (i: builtins.pathExists ../module/${i}/pkg.nix) dirs;
in

nixpkgs.lib.genAttrs pkgs (i: import i nixpkgs)
