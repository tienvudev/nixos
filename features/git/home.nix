{
  homes.git = {
    programs = {
      git.enable = true;
    };

    programs.git.settings = {
      init.defaultBranch = "main";
      credential.helper = "cache --timeout=86400";
    };
  };
}
