{ inputs, featDir, ... }:

file:

let
  inherit (inputs.nixpkgs) lib;

  feats = import ./mk-feats.nix lib featDir file;

  sorteds = lib.toposort (a: b: lib.elem a.name b.deps) feats;
in

assert !(sorteds ? cycle);

sorteds.result
