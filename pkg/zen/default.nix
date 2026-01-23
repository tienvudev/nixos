let
  settings = {
    zen.view.compact.show-sidebar-and-toolbar-on-hover = false;
    widget.use-xdg-desktop-portal.file-picker = 1;
  };
in

{ pkgs, inputs, ... }:

{
  imports = [
    inputs.zen-browser.homeModules.twilight
  ];

  programs.zen-browser = {
    enable = true;

    profiles.default.isDefault = true;
    # profiles.default.settings = settings;
  };
}
