{ pkgs, ... }:

{
  runtimeInputs = with pkgs; [
    argc
    nixfmt
    oxfmt
    shfmt
    tombi
    treefmt
  ];

  text = ''exec "${./bin/run.sh}" "$@"'';
}
