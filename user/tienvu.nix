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

  programs.git.settings = {
    user.name = "Tien Vu";
    user.email = "git@tienvu.dev";
  };

  home.packages = with pkgs; [
    brave
    ente-auth
    rpcs3
    neofetch
  ];

  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5.addons = [ pkgs.fcitx5-bamboo ];
  };
}
