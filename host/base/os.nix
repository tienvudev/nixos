{
  inputs,
  host,
  ...
}@arg:

let
  users = import ../${host}/user.nix;
in

{
  imports = [
    ../${host}/hardware.nix
    ../${host}/os.nix
    inputs.home-manager.nixosModules.default
  ];

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  networking = {
    hostName = host;
    networkmanager.enable = true;
  };

  programs.git.enable = true;

  nixpkgs.config.allowUnfree = true;

  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];

    trusted-users = [
      "root"
      "@wheel"
    ];
  };

  users.users = import ../../util/mk-user.nix users;

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "backup";

    extraSpecialArgs = {
      inherit inputs;
      inherit host;
    };

    users = import ../../util/mk-home.nix users;
  };

  system.stateVersion = import ../${host}/version.nix;
}
