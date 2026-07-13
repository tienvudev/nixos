{
  config,
  lib,
  ...
}: {
  options.uuid = lib.mkOption {
    type = lib.types.str;
  };

  config.flake.uuid = config.uuid;
}
