{ inputs, featDir, ... }:

file:

let
  inherit (inputs.nixpkgs) lib;

  feats = import ./mk-feats.nix lib featDir file;
in

lib.listToAttrs (
  map (i: {
    name = i.name;
    value = i.path;
  }) feats
)
