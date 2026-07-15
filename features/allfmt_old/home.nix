{
  homes.allfmt_old = {
    packages = [
      "self.allfmt_old"
    ];

    file = {
      ".local/bin/allfmt_old" = ./bin;
    };
  };
}
