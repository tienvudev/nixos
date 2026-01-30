{
  lib,
  config,
  inputs,
  ...
}@arg:

prog:

let
  OWNER = "tienvu";

  REPO = "nixos";

  mkRelative = i: lib.strings.removePrefix inputs.self.outPath (toString i);

  mkLocal = i: "${config.home.homeDirectory}/${REPO}${mkRelative i}";

  mkPath = i: if config.home.username != OWNER then i else mkLocal i;

  mkLink = i: config.lib.file.mkOutOfStoreSymlink (mkPath i);

  mkChild = i: map (j: i + "/${j}") (builtins.attrNames (builtins.readDir i));

  mkSrc = i: {
    source = mkLink i;
    recursive = true;
  };

  system = arg.pkgs.stdenv.hostPlatform.system;

  modUtil = import ./mk-mod-util.nix arg prog;
in

{ inherit mkSrc system; } // modUtil
