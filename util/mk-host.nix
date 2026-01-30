inputs: host:

let
  mkUtil = import ./mk-mod-util.nix;
in

inputs.nixpkgs.lib.nixosSystem {
  system = "x86_64-linux";

  specialArgs = {
    inherit inputs;
    inherit host;
    inherit mkUtil;
  };

  modules = [ ../host/base/os.nix ];
}
