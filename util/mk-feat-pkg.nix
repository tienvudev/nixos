{ pkgs, ... }@arg:

all: feat:

let
  inputs = map (i: all.${i}) feat.deps;

  data = import feat.path arg;

  cfg = data // {
    name = feat.name;

    runtimeInputs = data.runtimeInputs ++ inputs;
  };

  cfgs = {
    ${feat.name} = pkgs.writeShellApplication cfg;
  };
in

all // cfgs
