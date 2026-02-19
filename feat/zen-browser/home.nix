{ tienvu, ... }@arg:

let
  t = tienvu arg "zen-browser";

  settings = {
    zen.view.compact.show-sidebar-and-toolbar-on-hover = false;
    widget.use-xdg-desktop-portal.file-picker = 1;
  };
in

t.mkHome {
  imports = [
    t.inputs.zen-browser.homeModules.twilight
  ];

  programs.zen-browser = {
    profiles.default.isDefault = true;
    # profiles.default.settings = settings;
  };
}
