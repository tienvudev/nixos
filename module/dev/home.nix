{ pkgs, mkUtil, ... }@arg:

(mkUtil arg "dev").mkConfig {
  programs = {
    allfmt.enable = true;
    git.enable = true;

    vscode.enable = true;
    vscode.package = pkgs.vscode.fhs;
  };

  services = {
    podman.enable = true;
  };

  home.packages = with pkgs; [
    tree
    devenv
  ];
}
