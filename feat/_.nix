{ lib, tienvu, ... }@arg:

let
  t = tienvu arg "base";
in

{
  options.${t.name}.local = lib.mkOption {
    default = null;
  };
}
