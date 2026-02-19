{ inputs, featDir, ... }@top:

arg: name: mods:

data:

let
  inherit (inputs.nixpkgs) lib;

  src = import ./mk-util-use.nix top mods data;

  options.${top.name}.${name} = (src.featopts or { }) // {
    enable = lib.mkEnableOption name;
  };

  cfg = removeAttrs src [
    "imports"
    "options"
    "featopts"
  ];
in

{
  imports = src.imports ++ [ (featDir + "/_.nix") ];

  options = lib.recursiveUpdate (src.options or { }) options;

  config = lib.mkIf arg.config.${top.name}.${name}.enable cfg;
}
