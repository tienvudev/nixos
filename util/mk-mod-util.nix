{ lib, config, ... }:

prog:

let
  progOpt = {
    options.programs.${prog}.enable = lib.mkEnableOption prog;
  };

  progConf = config.programs.${prog} or { enable = false; };

  extConfig = i: lib.mkIf progConf.enable i;

  extModule =
    i:

    {
      imports = i.imports or [ ];

      config = extConfig (i.config or { });
    };

  mkConfig = i: progOpt // (extModule { config = i; });

  mkModule = i: progOpt // (extModule i);
in

{
  inherit extConfig;
  inherit extModule;

  inherit mkConfig;
  inherit mkModule;
}
