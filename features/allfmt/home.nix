{
  homes.allfmt = {
    packages = [
      "self.allfmt"
    ];

    file = {
      ".local/bin/allfmt" = ./bin;
    };
  };
}
