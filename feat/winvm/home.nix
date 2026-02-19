{ pkgs, tienvu, ... }@arg:

let
  t = tienvu arg "winvm";
in

t.mkHome {
  services.podman.enable = true;

  home.packages = with pkgs; [
    argc
    freerdp

    # (util.bin ./run.sh)
  ];

  home.file = t.mkBin ./run.sh;
}
