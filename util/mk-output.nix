inputs: hosts:

{
  nixosConfigurations = inputs.nixpkgs.lib.genAttrs hosts (import ./mk-host.nix inputs);
}
