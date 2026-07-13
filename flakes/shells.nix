{
  config,
  lib,
  ...
} @ args: let
  inherit (lib) types;

  lib' = import ./_lib.nix args;

  shellsOption = lib.mkOption {
    default = {};

    type = types.lazyAttrsOf (
      types.submodule {
        options.path = lib.mkOption {
          type = types.path;
        };

        options.runtimeInputs = lib.mkOption {
          type = lib'.listOfStrOr types.package;
          default = [];
        };
      }
    );
  };

  mkShell = pkgs: name: shell:
    pkgs.writeShellApplication {
      inherit name;

      text = ''exec "${shell.path}/main.sh" "$@"'';

      runtimeInputs = lib'.mkPackages pkgs shell.runtimeInputs;
    };
in {
  options.shells = shellsOption;

  config.perSystem = {pkgs, ...}: {
    packages = lib.mapAttrs (mkShell pkgs) config.shells;
  };
}
