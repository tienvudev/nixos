{ pkgs, tienvu, ... }@arg:

let
  t = tienvu arg "bluetui";
in

t.mkOs {
  hardware.bluetooth.enable = true;

  environment.systemPackages = with pkgs; [
    bluetui
  ];
}
