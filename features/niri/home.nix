{
  homes.niri = {
    enable.by = "self.nixos.niri.enable";

    imports = [
      "self.ghostty"
      "self.swaylock"
    ];

    packages = [
      "pkgs.brightnessctl"
      "pkgs.wifitui"
      "pkgs.wiremix"
      "pkgs.nautilus"
      "pkgs.xwayland-satellite"
      "pkgs.adwaita-icon-theme"
    ];

    programs = {
      jq.enable = true;
    };

    services = {
      gnome-keyring.enable = true;
      playerctld.enable = true;
    };

    file = {
      ".local/bin/niri" = ./bin;
      ".config/niri" = ./config;
    };
  };
}
