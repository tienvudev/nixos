top:

let
  share = import ./mk-flake-share.nix top;

  nixosConfigurations = import ./mk-hosts.nix top share.modArg;

  out = {
    inherit nixosConfigurations;

    mkFlake = import ./mk-flake.nix;
    mkFlakeShare = import ./mk-flake-share.nix;
  };
in

share // out
