{
  nixos.netbird = {
    config = {pkgs, ...}: {
      services = {
        netbird.enable = true;
      };

      systemd.services.netbird = {
        path = [pkgs.shadow];
      };
    };
  };
}
