{
  inputs,
  homes,
  oses,
  ...
}@top:

arg: name:

let
  inherit (inputs.nixpkgs) lib;
  inherit (arg.config.nixpkgs) system;

  pkgs = top.pkgs.${system};

  mkMod = import ./mk-util-mod.nix top arg name;

  mkOs = mkMod oses;
  mkHome = mkMod homes;

  mkHost = import ./mk-util-host.nix top name;
  mkUser = import ./mk-util-use.nix top homes;

  symlink = import ./mk-util-symlink.nix top arg name;

  out = {
    inherit inputs system pkgs;
    inherit oses homes;
    inherit mkOs mkHome;
    inherit mkHost mkUser;

    name = top.name;
  };
in

out // symlink
