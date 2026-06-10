arg:

{
  networking = {
    networkmanager.enable = true;
  };

  nixpkgs.config.allowUnfree = true;

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # nix.settings.substituters = [ "https://aseipp-nix-cache.global.ssl.fastly.net" ];
}
