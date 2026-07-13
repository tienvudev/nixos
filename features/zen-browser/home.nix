{
  inputs,
  lib,
  ...
}: {
  homes.zen-browser = {
    imports = [
      inputs.zen-browser.homeModules.twilight
    ];

    packages = [
      "pkgs.dejsonlz4"
    ];

    programs.zen-browser = let
      iconPrefix = "chrome://browser/skin/zen-icons/selectable/";

      containers = map (i:
        lib.listToAttrs (lib.zipListsWith lib.nameValuePair ["name" "icon" "color"] i)) [
        ["tienvu" "fingerprint" "orange"]
        ["work" "briefcase" "blue"]
        ["nisims-api" "circle" "blue"]
        ["nisims-account" "circle" "turquoise"]
        ["nisims-assessment" "circle" "green"]
        ["nisims-npdi" "circle" "pink"]
        ["nisims-provider" "circle" "purple"]
      ];

      pins = map (i:
        lib.listToAttrs (lib.zipListsWith lib.nameValuePair ["id" "name" "container" "url"] i)) [
        ["61427811-0401-4ad6-b76f-1885d89e8d16" "purelymail" null "https://inbox.purelymail.com/"]
        ["a00c0ccb-37cf-45a1-8f00-b8ca3847d6eb" "enteauth" null "https://auth.ente.io/"]
        ["c24b1c13-e782-423b-9097-36710a5a1929" "aliasvault" null "https://app.aliasvault.net/"]
        ["b8d0be38-97f6-4697-9e3f-dfc32d03ed64" "discord" null "https://discord.com/channels/@me"]
        ["d1d07674-2f60-4b8a-8d8a-9b59139817e9" "chatgpt" null "https://chatgpt.com/"]
        ["4e86a567-d223-40c0-9516-8c1f33bf5f1b" "accgen" "tienvu" "https://svelte.dev/playground/ae942d6a8c674b9dad8aae68304b91ae?version=5.47.1#H4sIAAAAAAAAA4VU24rbMBD9FSGWxaG5Q6Hx2ilLC2WhD4U-bpZGseSNWl1caZzEGP97R75kk2XbPkTYZ87MmTkjp6aGaUFjypRk_sBKBXRMc6mEp_FjTaEqQjQAiPfc-6KY-oNQELAd8-ItPLMGhAEsQxOfOVnAemM2IHVhHRDHDH8wQHJnNdnQ8Gr1RBrY0DukIRHzPZD7bw8kRcIeoPDxbBaUqqku81waxXZ-mlndgtOf3poNDZmEvMOMj5ktDaSLDttAwG7DOKlmSlyhRwn7H750oU4KrhSXdW5zJ36XwmRV6pgT5_6UACI0kwr7u_HAQESYRkd3Q1Dyv0W43b0VCr-8NBlIa1qDPmOcRFqaMdHsNCJ113PnjCk1Ful9fCF1lcAJwHnI9qZGXrOdFox_B-YgWo5xpvkg2Qy6zFcmI2f1Z2GEa9VfqTrhUZUdmcTdCcj2EW5oEO0oj8HGpzMLM9rdRKPeuIFXVX3_Yczo_XxMVqvrSlpfMhZjslheEzh_RVh-GAjd2e6gvR5OFIplwW6cP3hwdh2GLaJZkk_BfrVH4T7htY5GzU1dVXhojQfnzbZP6Ta4Xaza-KQlTC4Y6Gsye7n1JuHy0F7_ZFcCoMHWZEpmv9J6cLpZf-mfklnHWXd2JdIUZbCRcWtURQ5MlSKt26YbMlv_gyP5fwg4RsdIZn2DJvFQKdEmITQs_yg57GOynDuhBwukR0ermORKnHosPE5yZY8xyawqtenxZ1bEZDHkdua0Mvg_AeIENA5fXfOEbzjVURpO45wpL5o_0mSeSaAEAAA"]
        ["05a7b9e1-3aed-41b9-b547-25311762db81" "zalo" "tienvu" "https://chat.zalo.me/"]
        ["b7ae5ab6-0902-4620-be61-30cc5bf5a68b" "outlook" "work" "https://outlook.cloud.microsoft/"]
        ["61dce300-7055-4ce5-ae66-a57e77534a3a" "teams" "work" "https://teams.cloud.microsoft/"]
      ];

      spaces = map (i:
        lib.listToAttrs (lib.zipListsWith lib.nameValuePair ["id" "name" "container" "icon"] i)) [
        ["c045f642-205c-4488-8534-0854a0c77817" "anon" null "grid-2x2"]
        ["65174b32-21f2-4a85-a99e-d0f0b397c05e" "tienvu" "tienvu" "terminal"]
        ["0161ac37-95b2-4f61-8ec8-f11dd081bff7" "work" "work" "briefcase"]
        ["b91dd09d-a5c3-47f6-a94a-013fa83efbd7" "nisims" null "code"]
      ];

      withOrder = name: value:
        lib.listToAttrs (
          lib.imap0 (k: v: {
            name = v.name;
            value = removeAttrs (v // {${name} = k + 1;}) ["name"];
          })
          value
        );

      containers' = withOrder "id" containers;

      withContainer = i:
        lib.mapAttrs (_: i:
          if i.container == null
          then i
          else i // {container = containers'.${i.container}.id;})
        (withOrder "position" i);

      withIcon = i:
        lib.mapAttrs
        (_: i: i // {icon = "${iconPrefix}${i.icon}.svg";})
        (withContainer i);

      withEssential = i:
        lib.mapAttrs
        (_: i: i // {isEssential = true;})
        (withContainer i);

      spaces' = withIcon spaces;

      pins' = withEssential pins;
    in {
      enable = true;
      setAsDefaultBrowser = true;

      profiles.default.id = 0;
      profiles.default.isDefault = true;
      profiles.default.containersForce = true;
      profiles.default.spacesForce = true;

      profiles.default.containers = containers';
      profiles.default.spaces = spaces';
      profiles.default.pins = pins';

      profiles.default.settings = {
        # https://docs.zen-browser.app/guides/live-editing
        "devtools.debugger.remote-enabled" = true;
        "devtools.chrome.enabled" = true;
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;

        "browser.link.open_newwindow.restriction" = 0;
        "browser.sessionstore.restore_pinned_tabs_on_demand" = false;

        "extensions.formautofill.creditCards.enabled" = false;
        "signon.rememberSignons" = false;
        "widget.use-xdg-desktop-portal.file-picker" = 1;

        "zen.glance.enabled" = false;
        "zen.theme.content-element-separation" = 0;
        "zen.urlbar.behavior" = "float";

        "zen.view.compact.show-sidebar-and-toolbar-on-hover" = false;
        "zen.view.show-newtab-button-top" = false;

        "zen.workspaces.hide-default-container-indicator" = false;
        "zen.workspaces.separate-essentials" = false;

        "services.sync.engine.addons" = false;
        "services.sync.engine.addresses" = false;
        "services.sync.engine.bookmarks" = true;
        "services.sync.engine.creditcards" = false;
        "services.sync.engine.history" = true;
        "services.sync.engine.passwords" = false;
        "services.sync.engine.prefs" = false;
        "services.sync.engine.tabs" = false;
        "services.sync.engine.workspaces" = false;
      };
    };

    file = {
      ".config/zen/default/chrome/userChrome.css" = ./userChrome.css;
    };
  };
}
