file:

let
  mkPath = i: ../module/${i}/${file}.nix;

  dirs = builtins.attrNames (builtins.readDir ../module);

  paths = map mkPath dirs;
in

builtins.filter builtins.pathExists paths
