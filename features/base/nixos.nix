{lib, ...}: let
  inherit (lib) types;
in {
  nixos.base = {
    options = {
      system = lib.mkOption {
        type = types.str;
        default = "x86_64-linux";
      };

      timeZone = lib.mkOption {
        type = types.str;
      };

      boot.type = lib.mkOption {
        type = types.str;
        default = "systemd";
      };

      boot.device = lib.mkOption {
        type = types.str;
        default = "nodev";
      };
    };

    config = {_config, ...}: {
      nixpkgs.hostPlatform = _config.system;

      nixpkgs.config.allowUnfree = true;

      time.timeZone = _config.timeZone;

      boot.loader = lib.mkMerge [
        (lib.mkIf (_config.boot.type == "systemd") {
          efi.canTouchEfiVariables = true;
          systemd-boot.enable = true;
        })

        (lib.mkIf (_config.boot.type == "grub") {
          grub = {
            enable = true;
            useOSProber = true;
            device = _config.boot.device;
          };
        })
      ];

      networking.networkmanager.enable = true;

      nix.settings.experimental-features = [
        "nix-command"
        "flakes"
      ];
    };
  };
}
