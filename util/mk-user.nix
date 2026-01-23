builtins.mapAttrs (
  user: sudo: {
    isNormalUser = true;
    extraGroups = if sudo then [ "wheel" ] else [ ];
  }
)
