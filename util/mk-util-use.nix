{ inputs, name, ... }:

mods: data:

let
  inherit (inputs.nixpkgs) lib;

  deps = data.deps or [ ];

  imports = map (i: mods.${i}) deps;

  enables = lib.genAttrs deps (_: {
    enable = true;
  });

  cfg = removeAttrs data [
    "deps"
    "feats"
  ];

  out = {
    imports = (data.imports or [ ]) ++ imports;

    ${name} = lib.recursiveUpdate (data.feats or { }) enables;
  };
in

cfg // out
