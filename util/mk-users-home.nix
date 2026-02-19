{ inputs, userDir, ... }:

stateVersion: users:

let
  inherit (inputs.nixpkgs) lib;
in

lib.mapAttrs (i: _: {
  imports = [
    (userDir + "/_.nix")
    (userDir + "/${i}.nix")
  ];

  home.stateVersion = stateVersion;
}) users
