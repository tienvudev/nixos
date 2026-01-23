{ host, ... }@arg:

{
  imports = [
    ../pkg/niri
  ];

  home.stateVersion = import ../host/${host}/version.nix;

  _module.args.util = import ../util/mk-home-util.nix arg;
}
