{
  host,
  nixosConfig,
  util,
  ...
}@arg:

{
  imports = [
    ../home/niri
    ../home/zen-browser
  ];

  programs.niri.enable = nixosConfig.programs.niri.enable;
  programs.zen-browser.enable = true;

  home.stateVersion = import ../host/${host}/version.nix;
  nixpkgs.config.allowUnfree = true;
}
