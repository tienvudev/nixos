{ inputs, oses, ... }@top:

name: data:

let
  inherit (inputs.nixpkgs) lib;

  src = import ./mk-util-use.nix top oses data;

  inherit (src.system) stateVersion;

  users = src.users or { };

  networking = src.networking or { };

  cfg = {
    networking = lib.recursiveUpdate networking {
      hostName = name;
    };

    users.users = import ./mk-users-os.nix top users;

    home-manager = {
      backupFileExtension = "backup";

      extraSpecialArgs = {
        ${top.name} = import ./mk-util.nix top;
      };

      users = import ./mk-users-home.nix top stateVersion users;
    };
  };
in

src // cfg
