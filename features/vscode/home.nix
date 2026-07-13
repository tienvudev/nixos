{
  homes.vscode = {
    programs = {pkgs, ...}: {
      vscode.enable = true;
      vscode.package = pkgs.vscode.fhs;
    };
  };
}
