{ tienvu, ... }@arg:

let
  t = tienvu arg "waydroid";
in

t.mkHome {
  home.packages = [
    t.inputs.waydroid-script.packages.${t.system}.default
  ];
}
