{
  users.tienvu = {
    imports = [
      "self.base"
      "self.dev"
      "self.niri"
    ];

    programs.git.settings = {
      user.name = "Tien Vu";
      user.email = "git@tienvu.dev";
    };
  };
}
