{
  inputs,
  lib,
  ...
}: let
  inherit (lib) types;

  inherit (inputs) self;

  # TYPE

  functionOr = type: types.either type (types.functionTo type);

  listOfStrOr = type: types.listOf (types.either types.str type);

  withArgs = args: v:
    if lib.isFunction v
    then v args
    else v;

  # FUNCTION

  functionArgs = v:
    if lib.isFunction v
    then lib.functionArgs v
    else if lib.isString v
    then {${v} = false;}
    else {};

  setFunctionArgs = v: args:
    if lib.isFunction v
    then # #
      lib.setFunctionArgs v args
    else _: v;

  injectFunctionArgs = mkArgs: value:
    setFunctionArgs
    (i: value (i // (mkArgs i)))
    ((functionArgs mkArgs) // (functionArgs value));

  extendFunctionArgs = sources: target:
    setFunctionArgs
    target
    (lib.mergeAttrsList (map functionArgs ([target] ++ sources)));

  # VALUE

  findFirstAttrByPath = v: default: attrsList: let
    path = lib.splitString "." v;
    item = lib.findFirst (lib.hasAttrByPath path) null attrsList;
  in
    if !lib.isString v
    then v
    else if item == null
    then default
    else lib.getAttrFromPath path item;

  # MODULE

  moduleOptions = {
    enable.by = lib.mkOption {
      type = types.either types.bool types.str;
      default = true;
    };

    enable.default = lib.mkOption {
      type = types.bool;
      default = true;
    };

    options = lib.mkOption {
      type = types.attrs;
      default = {};
    };

    imports = lib.mkOption {
      type = listOfStrOr types.deferredModule;
      default = [];
    };

    packages = lib.mkOption {
      type = types.listOf types.str;
      default = [];
    };

    inputs = lib.mkOption {
      type = functionOr types.attrs;
      default = {};
    };

    programs = lib.mkOption {
      type = functionOr types.attrs;
      default = {};
    };

    services = lib.mkOption {
      type = functionOr types.attrs;
      default = {};
    };

    config = lib.mkOption {
      type = functionOr types.attrs;
      default = {};
    };
  };

  mkFlakesOption = class:
    lib.mkOption {
      type = types.lazyAttrsOf types.deferredModule;
      default = {};
      apply = lib.mapAttrs (k: v: {
        key = "${self.outPath}.${class}.${k}";
        imports = [v];
      });
    };

  mkModulesOption = v:
    lib.mkOption {
      type = types.lazyAttrsOf (types.submodule {options = v // moduleOptions;});
      default = {};
    };

  mkConfigBy = args: v:
    findFirstAttrByPath v false [
      args
      (lib.mapAttrs (_: i: args.config.${i.uuid or ""} or {}) inputs)
      (lib.mapAttrs (_: i: {nixos = args.osConfig.${i.uuid  or ""} or {};}) inputs)
    ];

  mkPackages = pkgs:
    map (i:
      findFirstAttrByPath i (throw "Package [${i}] not found") [
        {inherit pkgs;}
        (lib.mapAttrs (_: i: i.packages.${pkgs.stdenv.hostPlatform.system} or {}) inputs)
      ]);

  mkModule = {
    class,
    options ? {},
    imports ? [],
    config ? {},
  }: name: module:
    extendFunctionArgs
    [
      "config"
      "osConfig"
      "pkgs"
      module.inputs
      module.config
    ]
    (args: let
      enableBy = mkConfigBy args module.enable.by;

      options''.enable = lib.mkOption {
        type = types.bool;
        default = module.enable.default;
      };

      options'.${self.uuid}.${name} = options // module.options // options'';

      imports' = map (i:
        findFirstAttrByPath i (throw "Module [${i}] not found") [
          inputs
          (lib.mapAttrs (_: i: i.${class} or {}) inputs)
        ])
      (imports ++ module.imports);

      args' = rec {
        _configs = lib.mapAttrs (_: i: args.config.${i.uuid or ""} or {}) inputs;
        _config = _configs.self.${name};
      };

      withArgs' = withArgs (args // args');

      pkgsPaths = {
        nixos = ["environment" "systemPackages"];
        homes = ["home" "packages"];
      };

      packages' = mkPackages args.pkgs (withArgs' module.packages);

      inputs' = i: lib.nameValuePair inputs.${i}.uuid;

      config' = lib.mkIf (enableBy && args'._config.enable) (
        lib.mkMerge [
          (withArgs' config)
          (lib.mapAttrs' inputs' (withArgs' module.inputs))
          (lib.setAttrByPath pkgsPaths.${class} packages')
          {programs = withArgs' module.programs;}
          {services = withArgs' module.services;}
          (withArgs' module.config)
        ]
      );
    in {
      options = options';
      imports = imports';
      config = config';
    });
in {
  inherit
    functionOr
    listOfStrOr
    mkFlakesOption
    mkModulesOption
    mkPackages
    mkModule
    ;
}
