{ pkgs, tienvu, ... }@arg:

let
  t = tienvu arg "dev";
in

t.mkHome {
  deps = [
    "allfmt"
    "git"
  ];

  programs = {
    vscode.enable = true;
    vscode.package = pkgs.vscode.fhs;
  };

  services = {
    podman.enable = true;
  };

  home.packages = with pkgs; [
    devbox
  ];
}
