{ mkUtil, ... }@arg:

(mkUtil arg "git").extConfig {
  programs.git.settings = {
    credential.helper = "cache --timeout=86400";
    init.defaultBranch = "main";
  };
}
