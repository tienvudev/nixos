{ pkgs, mkUtil, ... }@arg:

(mkUtil arg "dev").mkModule {
  deps = [
    "allfmt"
    "git"
  ];

  config = {
    services = {
      podman.enable = true;
    };

    programs = {
      vscode.enable = true;
      vscode.package = pkgs.vscode.fhs;
    };

    home.packages = with pkgs; [
      tree
      devenv
    ];
  };
}
