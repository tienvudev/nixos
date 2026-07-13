{
  self,
  config,
  lib,
  ...
} @ args: let
  inherit (lib) types;

  lib' = import ./_lib.nix args;

  modulesOption = lib'.mkModulesOption {
    file = lib.mkOption {
      type = types.lazyAttrsOf (types.path);
      default = {};
    };
  };

  mkModule = i: home:
    lib'.mkModule {
      class = "homes";

      options.symlinks = lib.mapAttrs (i: _:
        lib.mkOption {
          type = types.str;
          default = "";
        })
      home.file;

      imports = ["self.symlink"];

      config = {
        config,
        _config,
        _configs,
        ...
      }: {
        home.file =
          lib.mapAttrs (
            k: v: let
              inherit (config.home) homeDirectory;

              symlink = _config.symlinks.${k};
              symlink' = _configs.self.symlink.target;

              symPath =
                if symlink != ""
                then "${homeDirectory}/${symlink}"
                else if symlink' != ""
                then "${homeDirectory}/${symlink'}${lib.removePrefix self.outPath (toString v)}"
                else v;
            in {
              source = config.lib.file.mkOutOfStoreSymlink symPath;
              recursive = true;
            }
          )
          home.file;
      };
    }
    i
    home;
in {
  options.homes = modulesOption;

  options.flake.homes = lib'.mkFlakesOption "homes";

  config.flake.homes = lib.mapAttrs mkModule config.homes;
}
