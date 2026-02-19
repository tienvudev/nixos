lib: dir: file:

let
  # TODO: common util
  tryImport = path: fallback: if lib.pathExists path then import path else fallback;

  mapFeat = name: {
    name = name;
    path = dir + "/${name}/${file}.nix";
    deps = tryImport "${dir}/${name}/${file}.dep.nix" [ ];
  };

  names = import ./mk-childs.nix lib dir;
in

lib.filter (i: lib.pathExists i.path) (map mapFeat names)
