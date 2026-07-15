{
  homes.bash = {
    programs.bash = {
      enable = true;

      historySize = 1000000;
      historyFileSize = 10000000;

      initExtra = ''
        run() {
          nohup "$@" >/dev/null 2>&1 &
        }

        complete -F _command run
      '';
    };
  };
}
