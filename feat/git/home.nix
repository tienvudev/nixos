{ tienvu, ... }@arg:

let
  t = tienvu arg "git";
in

t.mkHome {
  programs.git.enable = true;

  programs.git.settings = {
    credential.helper = "cache --timeout=86400";
    init.defaultBranch = "main";
  };
}
