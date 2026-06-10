{ pkgs, tienvu, ... }@arg:

let
  t = tienvu arg "tienvu";
in

t.mkUser {
  deps = [
    "dev"
    "niri"
    "winvm"
    "zen-browser"
  ];

  feats.local = "nixos";

  programs = {
    firefox.enable = true;
  };

  home.packages = with pkgs; [
    _7zz
    fastfetch
    unrar

    celluloid
    showtime

    blender
    brave
    ente-auth
    rpcs3
    umu-launcher
    cyme
  ];

  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5.addons = [ pkgs.fcitx5-bamboo ];
  };
}
