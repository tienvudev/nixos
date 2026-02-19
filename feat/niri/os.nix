{ tienvu, ... }@arg:

let
  t = tienvu arg "niri";
in

t.mkOs {
  programs.niri.enable = true;
}
