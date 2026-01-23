builtins.mapAttrs (
  user: sudo: {
    imports = [
      ../home/base.nix
      ../home/${user}.nix
    ];
  }
)
