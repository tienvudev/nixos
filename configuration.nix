{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking = {
    hostName = "zbook16";
    networkmanager.enable = true;
  };

  time.timeZone = "Asia/Ho_Chi_Minh";

  services = {
    displayManager.ly.enable = true;
    playerctld.enable = true;
  };

  programs.niri.enable = true;

  users.users.tienvu = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    packages = with pkgs; [
      ghostty
      vscode
      vscodium
      nautilus
      firefox

      nixfmt
      kdlfmt

      # system
      wiremix
      wifitui
      brightnessctl

      # util
      jq
    ];
  };

  # i18n.inputMethod = {
  #   enable = true;
  #   type = "fcitx5";
  #   fcitx5.addons = with pkgs; [
  #     fcitx5-bamboo
  #   ];
  # };

  # programs.firefox.enable = true;
  programs.git = {
    enable = true;
  };

  nixpkgs = {
    config.allowUnfree = true;
  };

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  system.stateVersion = "25.11";
}
