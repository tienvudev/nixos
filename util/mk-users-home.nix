{
  inputs,
  hostDir,
  userDir,
  ...
}:

host: stateVersion: users:

let
  inherit (inputs.nixpkgs) lib;
in

lib.mapAttrs (i: _: {
  imports = [
    (userDir + "/_.nix")
    (userDir + "/${i}.nix")
    (hostDir + "/${host}/users/${i}.nix")
  ];

  home.stateVersion = stateVersion;
}) users
