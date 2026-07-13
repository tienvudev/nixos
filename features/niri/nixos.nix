{
  nixos.niri = {
    imports = [
      "self.bluetui"
    ];

    programs = {
      niri.enable = true;
    };

    services = {
      udisks2.enable = true;
    };
  };
}
