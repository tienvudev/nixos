lib: dir:

lib.filter (i: !lib.hasPrefix "_" i) (lib.attrNames (lib.readDir dir))
