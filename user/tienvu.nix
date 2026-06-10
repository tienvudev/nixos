{ pkgs, tienvu, ... }@arg:

let
  t = tienvu arg "tienvu";
in

t.mkUser {
  deps = [ "dev" ];

  programs.git.settings = {
    user.name = "Tien Vu";
    user.email = "git@tienvu.dev";
  };
}
