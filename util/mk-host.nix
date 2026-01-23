inputs: host:

inputs.nixpkgs.lib.nixosSystem {
  system = "x86_64-linux";

  specialArgs = {
    inherit inputs;
    inherit host;
  };

  modules = [ ../host/base/os.nix ];
}
