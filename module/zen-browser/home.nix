{
  pkgs,
  inputs,
  mkUtil,
  ...
}@arg:

let
  util = mkUtil arg "zen-browser";

  settings = {
    zen.view.compact.show-sidebar-and-toolbar-on-hover = false;
    widget.use-xdg-desktop-portal.file-picker = 1;
  };
in

util.extModule {
  imports = [
    inputs.zen-browser.homeModules.twilight
  ];

  config = {
    programs.zen-browser = {
      profiles.default.isDefault = true;
      # profiles.default.settings = settings;
    };
  };
}
