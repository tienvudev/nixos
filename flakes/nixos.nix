{
  config,
  lib,
  ...
} @ args: let
  lib' = import ./_lib.nix args;

  modulesOption = lib'.mkModulesOption {};

  mkModule = lib'.mkModule {class = "nixos";};
in {
  options.nixos = modulesOption;

  options.flake.nixos = lib'.mkFlakesOption "nixos";

  config.flake.nixos = lib.mapAttrs mkModule config.nixos;
}
