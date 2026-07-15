{
  homes.vscode = {
    imports = [
      "self.allfmt_old"
    ];

    programs = {pkgs, ...}: {
      vscode.enable = true;
      vscode.package = pkgs.vscode.fhs;
    };
  };
}
