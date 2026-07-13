{
  nixos.gnome = {
    services = {
      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;
    };

    services.gnome = {
      core-apps.enable = false;
      core-developer-tools.enable = false;
      games.enable = false;
    };

    config = {pkgs, ...}: {
      environment.gnome.excludePackages = with pkgs; [
        gnome-tour
        gnome-user-docs
      ];
    };
  };
}
