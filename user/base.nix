{
  host,
  nixosConfig,
  util,
  ...
}@arg:

{
  imports = import ../util/mk-mod-import.nix "home";

  programs = {
    niri.enable = nixosConfig.programs.niri.enable;
    waydroid.enable = nixosConfig.programs.waydroid.enable;
    zen-browser.enable = true;
  };

  home.stateVersion = import ../host/${host}/version.nix;
  nixpkgs.config.allowUnfree = true;
}
