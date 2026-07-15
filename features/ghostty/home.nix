{
  homes.ghostty = {
    imports = [
      "self.bash"
    ];

    programs.ghostty = {
      enable = true;
    };

    programs.bash.initExtra = ''
      PS1='\[\033[1;32m\][\[\e]0;\u@\h: \w\a\]\u@\h:\w]\n\$\[\033[0m\] '
    '';

    file = {
      ".config/ghostty/config" = ./config.ini;
    };
  };
}
