{
  config,
  lib,
  ...
} @ args: let
  lib' = import ./_lib.nix args;

  modulesOption = lib'.mkModulesOption {};

  mkModule = lib'.mkModule {class = "homes";};
in {
  options.users = modulesOption;

  config.flake.homes = lib.mapAttrs mkModule (
    lib.mapAttrs'
    (i: lib.nameValuePair "user:${i}")
    config.users
  );
}
