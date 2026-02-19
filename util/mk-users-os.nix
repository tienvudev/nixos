{ inputs, ... }:

let
  inherit (inputs.nixpkgs) lib;
in

lib.mapAttrs (
  name: user: {
    isNormalUser = true;
    extraGroups = lib.optionals user.sudo [ "wheel" ];
  }
)
