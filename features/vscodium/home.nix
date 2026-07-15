{inputs, ...}: {
  homes.vscodium = {
    imports = [
      "self.allfmt"
    ];

    packages = [
      "pkgs.nixd"
    ];

    programs = {
      vscodium.enable = true;
    };

    file = {
      ".config/VSCodium/User/settings.json" = ./config/settings.json;
      ".config/VSCodium/User/keybindings.json" = ./config/keybindings.json;
    };

    config = {pkgs, ...}: let
      inherit (pkgs.stdenv.hostPlatform) system;
      inherit (inputs.nix-vscode-extensions.extensions.${system}) open-vsx;
    in {
      programs.vscodium.profiles.default.extensions = with open-vsx; [
        jakubkozera.ms-sql-manager
        jkillian.custom-local-formatters
        jnoortheen.nix-ide
      ];
    };
  };
}
