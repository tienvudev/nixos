{
  hosts.zbook16 = {
    stateVersion = "25.11";

    imports = [
      ./_hardware.nix
      "self.base"
      "self.netbird"
      "self.niri"
    ];

    inputs.self.base = {
      timeZone = "Asia/Ho_Chi_Minh";
    };

    programs = {
      nix-ld.enable = true;
      steam.enable = true;
    };

    services = {
      teamviewer.enable = true;
    };

    users.tienvu = {
      extraGroups = ["wheel"];

      imports = [
        "self.winvm"
        "self.zen-browser"
      ];

      packages = [
        "pkgs._7zz"
        "pkgs.fastfetch"
        "pkgs.unrar"
        "pkgs.celluloid"
        "pkgs.showtime"

        "pkgs.blender"
        "pkgs.brave"
        "pkgs.ente-auth"
        # "pkgs.rpcs3"
        "pkgs.umu-launcher"
        "pkgs.cyme"
      ];

      inputs.self = {
        symlink.target = "nixos";
      };

      programs = {
        firefox.enable = true;
      };

      config = {pkgs, ...}: {
        i18n.inputMethod = {
          enable = true;
          type = "fcitx5";
          fcitx5.addons = [pkgs.fcitx5-bamboo];
        };
      };
    };
  };
}
