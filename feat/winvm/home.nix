{ pkgs, tienvu, ... }@arg:

let
  t = tienvu arg "winvm";
in

t.mkHome {
  services.podman.enable = true;

  home.packages = with pkgs; [
    (t.mkSh ./run.sh)
    argc
    freerdp
  ];

  home.file = t.mkBin ./run.sh;
}
