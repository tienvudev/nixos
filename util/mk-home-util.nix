{
  config,
  nixosConfig,
  lib,
  inputs,
  ...
}:

let
  OWNER = "tienvu";

  REPO = "nixos";

  mkRelative = src: lib.strings.removePrefix inputs.self.outPath (toString src);

  mkLocal = src: "${config.home.homeDirectory}/${REPO}${mkRelative src}";

  mkPath = src: if config.home.username != OWNER then src else mkLocal src;

  mkLink = src: config.lib.file.mkOutOfStoreSymlink (mkPath src);

  mkChild = src: map (i: src + "/${i}") (builtins.attrNames (builtins.readDir src));

  mkSrc = src: {
    source = mkLink src;
    recursive = true;
  };

  ifEnable = prog: nixosConfig.programs.${prog}.enable;

  mkIfEnable = prog: lib.mkIf (ifEnable prog);
in

{
  inherit mkIfEnable;
  inherit mkSrc;
}
