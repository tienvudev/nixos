{
  inputs,
  name,
  hostDir,
  ...
}:

arg:

let
  inherit (inputs.nixpkgs) lib;

  names = import ./mk-childs.nix lib hostDir;
in

lib.genAttrs names (
  i:

  lib.nixosSystem {
    system = import "${hostDir}/${i}/system.nix";

    specialArgs = {
      ${name} = arg;
    };

    modules = [
      (hostDir + "/_.nix")
      (hostDir + "/${i}/hardware.nix")
      (hostDir + "/${i}/os.nix")

      inputs.home-manager.nixosModules.default
    ];
  }
)
