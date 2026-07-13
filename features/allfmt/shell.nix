{
  shells.allfmt = {
    path = ./bin;

    runtimeInputs = [
      "pkgs.argc"
      "pkgs.csharpier"
      "pkgs.dprint"
      "pkgs.nixfmt"
      "pkgs.oxfmt"
      "pkgs.shfmt"
      "pkgs.tombi"
    ];
  };
}
