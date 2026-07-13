{
  homes.dev = {
    imports = [
      "self.allfmt"
      "self.git"
      "self.vscode"
    ];

    packages = [
      "pkgs.devbox"
      "pkgs.mongodb-compass"
    ];

    services = {
      podman.enable = true;
    };
  };
}
