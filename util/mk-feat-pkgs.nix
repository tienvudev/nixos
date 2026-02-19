{ inputs, systems, ... }:

feats:

let
  inherit (inputs.nixpkgs) lib legacyPackages;
in

lib.genAttrs systems (
  system:

  lib.foldl' (import ./mk-feat-pkg.nix {
    inherit inputs system;

    pkgs = legacyPackages.${system};
  }) { } feats
)
