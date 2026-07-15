{
  homes.dev = {
    imports = [
      "self.bash"
      "self.git"
      # "self.vscode"
      "self.vscodium"
      "self.zed-editor"
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
