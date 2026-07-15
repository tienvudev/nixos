{
  homes.zed-editor = {
    imports = [
      "self.allfmt"
    ];

    packages = [
      "pkgs.nixd"
    ];

    programs = {
      zed-editor.enable = true;
    };

    file = {
      ".config/zed" = ./config;
    };
  };
}
