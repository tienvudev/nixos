builtins.mapAttrs (
  user: sudo: {
    imports = [
      ../user/base.nix
      ../user/${user}.nix
    ];
  }
)
