{
  inputs,
  name,
  featDir,
  hostDir,
  userDir,
  ...
}:

pkgs: oses: homes:

import ./mk-util.nix {
  inherit inputs name;
  inherit featDir hostDir userDir;
  inherit pkgs oses homes;
}
