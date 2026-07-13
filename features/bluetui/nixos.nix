{
  nixos.bluetui = {
    packages = [
      "pkgs.bluetui"
    ];

    config.hardware = {
      bluetooth.enable = true;
    };
  };
}
