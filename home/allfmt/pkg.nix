pkgs:

pkgs.writeShellApplication {
  name = "allfmt";

  runtimeInputs = with pkgs; [
    argc
    nixfmt
    oxfmt
    shfmt
    tombi
    treefmt
  ];

  text = "exec \"${./conf/run.sh}\" \"$@\"";
}
