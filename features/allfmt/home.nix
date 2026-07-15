{
  homes.allfmt = {
    packages = [
      "pkgs.treefmt"
      "self.allfmt"
    ];

    file = {
      ".local/bin/allfmt" = ./bin;
      ".treefmt.toml" = ./config/treefmt.toml;
    };
  };
}
