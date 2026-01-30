{ mkUtil, ... }@arg:

(mkUtil arg "waydroid").mkConfig {
  virtualisation.waydroid.enable = true;
}
