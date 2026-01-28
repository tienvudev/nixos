{
  lib,
  config,
  inputs,
  ...
}:

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

  progOpt = {
    options.programs.${prog}.enable = lib.mkEnableOption prog;
  };

  progConf = config.programs.${prog} or { enable = false; };

  extConfig = i: lib.mkIf progConf.enable i;

  extModule =
    i:

    let
      deps = i.deps or [ ];

      depMods = map (i: ../home/${i}) deps;

      depOpts = lib.genAttrs deps (_: {
        enable = true;
      });

      depProgs = {
        programs = depOpts;
      };
    in

    {
      imports = depMods ++ (i.imports or [ ]);

      config = extConfig (lib.recursiveUpdate depProgs (i.config or { }));
    };

  mkConfig = i: progOpt // (extModule { config = i; });

  mkModule = i: progOpt // (extModule i);
in

{
  inherit mkSrc;

  inherit extConfig;
  inherit extModule;

  inherit mkConfig;
  inherit mkModule;
}
