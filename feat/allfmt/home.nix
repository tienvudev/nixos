{ tienvu, ... }@arg:

let
  t = tienvu arg "allfmt";
in

t.mkHome {
  home.packages = with t.pkgs; [
    allfmt
  ];

  home.file = t.mkBin ./bin;
}
