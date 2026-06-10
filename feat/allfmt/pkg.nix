{ pkgs, ... }:

{
  runtimeInputs = with pkgs; [
    argc
    csharpier
    dprint
    nixfmt
    oxfmt
    shfmt
    tombi
  ];

  text = ''exec "${./bin}/run.sh" "$@"'';
}
