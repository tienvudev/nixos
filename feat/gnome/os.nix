{ pkgs, tienvu, ... }@arg:

let
  t = tienvu arg "gnome";
in

t.mkOs {
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;

  services.gnome = {
    core-apps.enable = false;
    core-developer-tools.enable = false;
    games.enable = false;
  };

  environment.gnome.excludePackages = with pkgs; [
    gnome-tour
    gnome-user-docs
  ];
}
