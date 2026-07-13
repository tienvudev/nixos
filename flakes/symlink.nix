{
  self,
  lib,
  ...
}: {
  flake.homes.symlink = {
    options.${self.uuid}.symlink = {
      target = lib.mkOption {
        type = lib.types.str;
        default = "";
      };
    };
  };
}
