# TODO: don't expose this to public?
{
  shells.winvm = {
    path = ./bin;

    runtimeInputs = [
      "pkgs.argc"
      "pkgs.freerdp"
    ];
  };
}
