{ pkgs, ... }:

{
  imports = [
    ../pkg/zen
  ];

  services = {
    playerctld.enable = true;
    podman.enable = true;
  };

  programs = {
    swaylock.enable = true;

    git.enable = true;s
    firefox.enable = true;
    vscode.enable = true;
  };

  home.packages = with pkgs; [
    brightnessctl
    tree
    wifitui
    wiremix

    brave
    nautilus
    ente-auth

    devenv
    nixfmt
  ];

  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5.addons = [ pkgs.fcitx5-bamboo ];
  };

  programs.git.settings = {
    user.name = "Tien Vu";
    user.email = "git@tienvu.dev";

    init.defaultBranch = "main";
  };
}
