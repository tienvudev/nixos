{
  inputs,
  name,
  featDir,
  userDir,
  ...
}:

pkgs: oses: homes:

import ./mk-util.nix {
  inherit inputs name;
  inherit featDir userDir;
  inherit pkgs oses homes;
}
