{ inputs, ... }@top:

{ config, ... }@arg:

name:

let
  inherit (inputs.nixpkgs) lib;
  inherit (arg.config.nixpkgs) system;

  pkgs = inputs.nixpkgs.legacyPackages.${system};

  osLocal = arg.nixosConfig.${top.name}.local;
  local = config.${top.name}.local;

  mkRel = path: lib.strings.removePrefix inputs.self.outPath (toString path);

  mkLocal = path: "${config.home.homeDirectory}/${local}${mkRel path}";

  mkPath = path: if osLocal == true && lib.isString local then mkLocal path else path;

  mkLink = path: config.lib.file.mkOutOfStoreSymlink (mkPath path);

  mkSrc = path: {
    source = mkLink path;
    recursive = true;
  };

  mkBin = path: {
    ".local/bin/${name}" = mkSrc path;
  };

  mkSh = path: pkgs.writeShellScriptBin name ''exec "${mkPath path}" "$@"'';
in

{
  inherit mkSrc mkBin mkSh;
}
