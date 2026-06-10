{ pkgs, tienvu, ... }@arg:

let
  t = tienvu arg "tienvu";
in

t.mkUser {
  deps = [ "dev" ];

  feats.local = "nixos";

  programs = {
    firefox.enable = true;
  };

  home.packages = with pkgs; [
    brave
  ];
}
