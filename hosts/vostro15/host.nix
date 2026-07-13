{
  hosts.vostro15 = {
    stateVersion = "26.05";

    imports = [
      ./_hardware.nix
      "self.base"
      "self.gnome"
      "self.netbird"
    ];

    inputs.self.base = {
      timeZone = "Asia/Ho_Chi_Minh";

      boot.type = "grub";
      boot.device = "/dev/sda";
    };

    users.tienvu = {
      extraGroups = ["wheel"];

      packages = [
        "pkgs.brave"
      ];

      programs = {
        firefox.enable = true;
      };
    };
  };
}
