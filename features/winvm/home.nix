{
  homes.winvm = {
    packages = [
      "self.winvm"
    ];

    services = {
      podman.enable = true;
    };

    file = {
      ".local/bin/winvm" = ./bin;
    };
  };
}
