{
  inputs,
  self,
  config,
  lib,
  ...
} @ args: let
  inherit (lib) types;

  lib' = import ./_lib.nix args;

  modulesOption = lib'.mkModulesOption {
    stateVersion = lib.mkOption {
      type = types.str;
    };

    users = lib'.mkModulesOption {
      isNormalUser = lib.mkOption {
        type = types.bool;
        default = true;
      };

      extraGroups = lib.mkOption {
        type = types.listOf types.str;
        default = [];
      };
    };
  };

  mkHostModule = hostname: host:
    lib'.mkModule {
      class = "nixos";

      imports = [inputs.home-manager.nixosModules.default];

      config = {
        system.stateVersion = host.stateVersion;

        home-manager = {
          useGlobalPkgs = true;
          useUserPackages = true;
          backupFileExtension = "backup";
        };

        users.users =
          lib.mapAttrs (_: i: {inherit (i) isNormalUser extraGroups;})
          host.users;

        home-manager.users =
          lib.mapAttrs (username: _: {
            imports = [
              self.homes."user:${username}" or {}
              self.homes."${hostname}:user:${username}"
            ];

            home.stateVersion = host.stateVersion;
          })
          host.users;
      };
    }
    hostname
    host;

  mkUserModule = lib'.mkModule {
    class = "homes";
    imports = ["self.symlink"];
  };
in {
  options.hosts = modulesOption;

  config.flake.nixos = lib.mapAttrs mkHostModule (
    lib.mapAttrs'
    (i: lib.nameValuePair "host:${i}")
    config.hosts
  );

  config.flake.homes = lib.mapAttrs mkUserModule (
    lib.concatMapAttrs
    (hostname: host:
      lib.mapAttrs'
      (username: lib.nameValuePair "host:${hostname}:user:${username}")
      host.users)
    config.hosts
  );

  config.flake.nixosConfigurations =
    lib.mapAttrs
    (i: _:
      inputs.nixpkgs.lib.nixosSystem {
        modules = [self.nixos."host:${i}"];
      })
    config.hosts;
}
