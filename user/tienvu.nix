{ pkgs, inputs, ... }:

{
  imports = [
    ../home/dev
  ];

  programs = {
    dev.enable = true;
    firefox.enable = true;
  };

  programs.git.settings = {
    user.name = "Tien Vu";
    user.email = "git@tienvu.dev";
  };

  home.packages = with pkgs; [
    brave
    ente-auth
    devenv
  ];

  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5.addons = [ pkgs.fcitx5-bamboo ];
  };
}
