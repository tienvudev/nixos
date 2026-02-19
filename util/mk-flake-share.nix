{
  inputs,
  name,
  featDir,
  ...
}@top:

let
  inherit (inputs.nixpkgs) lib;

  mkNodes = import ./mk-feat-nodes.nix top;
  mkMods = import ./mk-feat-mods.nix top;
  mkPkgs = import ./mk-feat-pkgs.nix top;

  packages = mkPkgs (mkNodes "pkg");
  nixosModules = mkMods "os";
  homeModules = mkMods "home";

  modArg = import ./mk-flake-arg.nix top packages nixosModules homeModules;
in

{
  inherit packages nixosModules homeModules;
  inherit modArg;
}
