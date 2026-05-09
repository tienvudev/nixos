{ tienvu, ... }@arg:

let
  t = tienvu arg "niri";
in

t.mkOs {
  deps = [
    "bluetui"
  ];

  programs.niri.enable = true;
}
