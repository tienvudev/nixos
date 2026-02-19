{ tienvu, ... }@arg:

let
  t = tienvu arg "waydroid";
in

t.mkOs {
  virtualisation.waydroid.enable = true;
}
