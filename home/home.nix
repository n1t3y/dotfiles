{
  config,
  pkgs,
  ...
}: {
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "n1t3";
  home.homeDirectory = "/home/n1t3";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "25.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.

  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    gimp
    libreoffice-qt
    inter
    cntr
    gnome-tweaks
    gnomeExtensions.blur-my-shell
    gnomeExtensions.gsconnect
    gnomeExtensions.user-themes
    kotatogram-desktop
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/n1t3/etc/profile.d/hm-session-vars.sh
  #

  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
    ];
  };

  programs.git = {
    enable = true;
    userName = "n1t3";
    userEmail = "n1t3@n1t3.dev";
    lfs.enable = true;
  };

  programs.nvf = {
    enable = true;
    defaultEditor = true;
    settings = {
      vim = {
        options = {
          shiftwidth = 2;
        };
        autocomplete = {
          blink-cmp = {
            enable = true;
            friendly-snippets.enable = true;
          };
        };
        theme = {
          enable = true;
          name = "gruvbox";
          style = "dark";
          transparent = true;
        };
        viAlias = true;
        vimAlias = true;

        lsp = {
          enable = true;
          formatOnSave = true;
        };
        languages = {
          enableExtraDiagnostics = true;
          enableFormat = true;
          enableTreesitter = true;
          clang = {
            enable = true;
            dap.enable = true;
            lsp.enable = true;
            treesitter.enable = true;
          };
          nix = {
            enable = true;
            extraDiagnostics.enable = true;
            format.enable = true;
            lsp.enable = true;
            lsp.server = "nixd";
            treesitter.enable = true;
          };
        };
      };
    };
  };

  programs.kitty = {
    enable = true;
    font = {
      name = "IosevkaTermSlab NF";
      package = pkgs.nerd-fonts.iosevka-term-slab;
      size = 12;
    };
    enableGitIntegration = true;
    settings = {
      cursor_shape = "beam";
      cursor_blink_interval = 0;
      cursor_trail = 1;
      cursor_trail_decay = "0.1 0.2";
      window_margin_width = "2 4";
      window_padding_width = "2 4";
      linux_display_server = "x11";
      background_opacity = "0.95";
      dynamic_background_opacity = "yes";

      selection_foreground = "#ebdbb2";
      selection_background = "#d65d0e";
      background = "#282828";
      foreground = "#ebdbb2";
      color1 = "#cc241d";
      color2 = "#98971a";
      color3 = "#d79921";
      color4 = "#458588";
      color5 = "#b16286";
      color6 = "#689d6a";
      color7 = "#a89984";
      color8 = "#928374";
      color9 = "#fb4934";
      color10 = "#b8bb26";
      color11 = "#fabd2f";
      color12 = "#83a598";
      color13 = "#d3869b";
      color14 = "#8ec07c";
      color15 = "#fbf1c7";
      cursor = "#bdae93";
      cursor_text_color = "#665c54";
      url_color = "#458588";
    };
  };

  dconf = {
    enable = true;
    settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";
    settings."org/gnome/desktop/interface".accent-color = "red";
    settings."org/gnome/shell" = {
      disable-user-extensions = false;
      enabled-extensions = with pkgs.gnomeExtensions; [
        blur-my-shell.extensionUuid
        gsconnect.extensionUuid
        user-themes.extensionUuid
      ];
    };
    settings."org/gnome/shell/extensions/user-theme".name = "WhiteSur-Dark-red";
  };

  gtk = {
    enable = true;

    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme.override {
        color = "red";
      };
    };

    cursorTheme = {
      name = "Quintom_Ink";
      package = pkgs.quintom-cursor-theme;
    };

    theme = {
      name = "WhiteSur-Dark-red";
      package = pkgs.callPackage ./whitesur.nix {
        darkerColor = true;
        nautilusStyle = "glassy";
        themeVariants = ["red"];
        libAdwaita = true;
      };
    };

    gtk3.extraConfig = {
      Settings = ''
        gtk-application-prefer-dark-theme=1
      '';
    };

    gtk4.extraConfig = {
      Settings = ''
        gtk-application-prefer-dark-theme=1
      '';
    };
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableVteIntegration = true;
    autosuggestion.enable = true;
    oh-my-zsh = {
      enable = true;
      theme = "robbyrussell";
    };
    syntaxHighlighting.enable = true;
    dotDir = ".config/zsh";
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };
  programs.kitty.shellIntegration.enableZshIntegration = true;
  programs.eza = {
    enable = true;
    enableZshIntegration = true;
  };
  home.shell.enableZshIntegration = true;

  home.sessionVariables.GTK_THEME = "WhiteSur-Dark-red";

  programs.librewolf = {
    enable = true;
    settings = {
      "app.normandy.api_url" = "";
      "app.normandy.enabled" = false;
      "app.shield.optoutstudies.enabled" = false;
      "app.update.auto" = false;
      "apz.overscroll.enabled" = true;
      "beacon.enabled" = false;
      "breakpad.reportURL" = "";
      "browser.aboutConfig.showWarning" = false;
      "browser.aboutwelcome.enabled" = false;
      "browser.bookmarks.openInTabClosesMenu" = false;
      "browser.cache.disk.enable" = false;
      "browser.compactmode.show" = true;
      "browser.contentanalysis.default_result" = 0;
      "browser.contentanalysis.enabled" = false;
      "browser.contentblocking.category" = "strict";
      "browser.crashReports.unsubmittedCheck.autoSubmit2" = false;
      "browser.crashReports.unsubmittedCheck.enabled" = false;
      "browser.discovery.enabled" = false;
      "browser.download.always_ask_before_handling_new_types" = true;
      "browser.download.alwaysOpenPanel" = false;
      "browser.download.manager.addToRecentDocs" = false;
      "browser.download.open_pdf_attachments_inline" = true;
      "browser.download.start_downloads_in_tmp_dir" = true;
      "browser.download.useDownloadDir" = true;
      "browser.firefox-view.feature-tour" = "{\"screen\":\"\" =\"complete\":true}";
      "browser.fixup.alternate.enabled" = false;
      "browser.formfill.enable" = false;
      "browser.helperApps.deleteTempFileOnExit" = true;
      "browser.link.open_newwindow" = 3;
      "browser.link.open_newwindow.restriction" = 0;
      "browser.menu.showViewImageInfo" = true;
      "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.addons" = false;
      "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.features" = false;
      "browser.newtabpage.activity-stream.default.sites" = "";
      "browser.newtabpage.activity-stream.feeds.discoverystreamfeed" = false;
      "browser.newtabpage.activity-stream.feeds.section.topstories" = false;
      "browser.newtabpage.activity-stream.feeds.snippets" = false;
      "browser.newtabpage.activity-stream.feeds.telemetry" = false;
      "browser.newtabpage.activity-stream.feeds.topsites" = false;
      "browser.newtabpage.activity-stream.section.highlights.includePocket" = false;
      "browser.newtabpage.activity-stream.showSponsored" = false;
      "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
      "browser.newtabpage.activity-stream.showWeather" = false;
      "browser.newtabpage.activity-stream.telemetry" = false;
      "browser.newtabpage.enabled" = true;
      "browser.ping-centre.telemetry" = false;
      "browser.places.speculativeConnect.enabled" = false;
      "browser.preferences.moreFromMozilla" = false;
      "browser.privatebrowsing.forceMediaMemoryCache" = true;
      "browser.privatebrowsing.resetPBM.enabled" = true;
      "browser.privatebrowsing.vpnpromourl" = "";
      "browser.privateWindowSeparation.enabled" = false;
      "browser.profiles.enabled" = true;
      "browser.region.network.url" = "";
      "browser.region.update.enabled" = false;
      "browser.safebrowsing.allowOverride" = false;
      "browser.safebrowsing.blockedURIs.enabled" = false;
      "browser.safebrowsing.downloads.enabled" = false;
      "browser.safebrowsing.downloads.remote.block_potentially_unwanted" = false;
      "browser.safebrowsing.downloads.remote.block_uncommon" = false;
      "browser.safebrowsing.downloads.remote.enabled" = false;
      "browser.safebrowsing.downloads.remote.url" = "";
      "browser.safebrowsing.malware.enabled" = false;
      "browser.safebrowsing.phishing.enabled" = false;
      "browser.safebrowsing.provider.google4.dataSharingURL" = "";
      "browser.safebrowsing.provider.google4.gethashURL" = "";
      "browser.safebrowsing.provider.google4.updateURL" = "";
      "browser.safebrowsing.provider.google.gethashURL" = "";
      "browser.safebrowsing.provider.google.updateURL" = "";
      "browser.search.separatePrivateDefault" = true;
      "browser.search.separatePrivateDefault.ui.enabled" = true;
      "browser.search.suggest.enabled" = true;
      "browser.search.update" = false;
      "browser.send_pings" = false;
      "browser.sessionhistory.max_total_viewers" = 4;
      "browser.sessionstore.interval" = 60000;
      "browser.sessionstore.privacy_level" = 2;
      "browser.shell.checkDefaultBrowser" = false;
      "browser.shopping.experience2023.enabled" = false;
      "browser.startup.homepage" = "about:home";
      "browser.startup.homepage_override.mstone" = "ignore";
      "browser.startup.page" = 1;
      "browser.tabs.crashReporting.sendReport" = false;
      "browser.tabs.searchclipboardfor.middleclick" = false;
      "browser.uitour.enabled" = false;
      "browser.uitour.url" = "";
      "browser.urlbar.addons.featureGate" = false;
      "browser.urlbar.fakespot.featureGate" = false;
      "browser.urlbar.groupLabels.enabled" = false;
      "browser.urlbar.mdn.featureGate" = false;
      "browser.urlbar.pocket.featureGate" = false;
      "browser.urlbar.quicksuggest.enabled" = true;
      "browser.urlbar.quicksuggest.scenario" = "history";
      "browser.urlbar.recentsearches.featureGate" = false;
      "browser.urlbar.showSearchTerms.enabled" = false;
      "browser.urlbar.speculativeConnect.enabled" = false;
      "browser.urlbar.suggest.quicksuggest.nonsponsored" = true;
      "browser.urlbar.suggest.quicksuggest.sponsored" = false;
      "browser.urlbar.suggest.searches" = true;
      "browser.urlbar.suggest.topsites" = false;
      "browser.urlbar.trending.featureGate" = false;
      "browser.urlbar.trimHttps" = true;
      "browser.urlbar.trimURLs" = false;
      "browser.urlbar.unitConversion.enabled" = true;
      "browser.urlbar.untrimOnUserInteraction.featureGate" = true;
      "browser.urlbar.update2.engineAliasRefresh" = true;
      "browser.urlbar.weather.featureGate" = false;
      "browser.urlbar.yelp.featureGate" = false;
      "browser.xul.error_pages.expert_bad_cert" = true;
      "captivedetect.canonicalURL" = "";
      "content.notify.interval" = 100000;
      "datareporting.healthreport.uploadEnabled" = false;
      "datareporting.policy.dataSubmissionEnabled" = false;
      "datareporting.usage.uploadEnabled" = false;
      "devtools.debugger.remote-enabled" = false;
      "dom.disable_window_move_resize" = true;
      "dom.security.https_only_mode_error_page_user_suggestions" = true;
      "dom.security.https_only_mode_send_http_background_request" = false;
      "dom.security.https_only_mode" = true;
      "dom.text_fragments.create_text_fragment.enabled" = true;
      "editor.truncate_user_pastes" = false;
      "extensions.autoDisableScopes" = 15;
      "extensions.blocklist.enabled" = true;
      "extensions.enabledScopes" = 5;
      "extensions.formautofill.addresses.enabled" = false;
      "extensions.formautofill.available" = "off";
      "extensions.formautofill.creditCards.available" = false;
      "extensions.formautofill.creditCards.enabled" = false;
      "extensions.formautofill.heuristics.enabled" = false;
      "extensions.getAddons.cache.enabled" = false;
      "extensions.getAddons.showPane" = false;
      "extensions.htmlaboutaddons.recommendations.enabled" = false;
      "extensions.pocket.enabled" = false;
      "extensions.postDownloadThirdPartyPrompt" = false;
      "extensions.quarantinedDomains.enabled" = true;
      "extensions.webcompat.enable_shims" = true;
      "extensions.webcompat-reporter.enabled" = false;
      "findbar.highlightAll" = true;
      "full-screen-api.transition-duration.enter" = "0 0";
      "full-screen-api.transition-duration.leave" = "0 0";
      "full-screen-api.warning.timeout" = 0;
      "general.smoothScroll.msdPhysics.enabled" = false;
      "general.smoothScroll" = true;
      "geo.provider.network.url" = "https://location.services.mozilla.com/v1/geolocate?key=%MOZILLA_API_KEY%";
      "geo.provider.use_geoclue" = false;
      "geo.provider.use_gpsd" = false;
      "gfx.canvas.accelerated.cache-size" = 512;
      "gfx.content.skia-font-cache-size" = 20;
      "identity.fxaccounts.enabled" = false;
      "image.mem.decode_bytes_at_a_time" = 32768;
      "intl.accept_languages" = "en-US";
      "javascript.use_us_english_locale" = true;
      "layout.css.grid-template-masonry-value.enabled" = true;
      "layout.word_select.eat_space_to_next_word" = false;
      "media.cache_readahead_limit" = 7200;
      "media.cache_resume_threshold" = 3600;
      "media.memory_cache_max_size" = 65536;
      "media.peerconnection.ice.default_address_only" = true;
      "media.peerconnection.ice.proxy_only_if_behind_proxy" = true;
      "mousewheel.default.delta_multiplier_y" = 275;
      "network.auth.subresource-http-auth-allow" = 1;
      "network.captive-portal-service.enabled" = false;
      "network.connectivity-service.enabled" = false;
      "network.dnsCacheExpiration" = 3600;
      "network.dns.disableIPv6" = true;
      "network.dns.disablePrefetchFromHTTPS" = true;
      "network.dns.disablePrefetch" = true;
      "network.file.disable_unc_paths" = true;
      "network.gio.supported-protocols" = "";
      "network.http.max-connections" = 1800;
      "network.http.max-persistent-connections-per-server" = 10;
      "network.http.max-urgent-start-excessive-connections-per-host" = 5;
      "network.http.pacing.requests.enabled" = false;
      "network.http.referer.spoofSource" = false;
      "network.http.referer.XOriginTrimmingPolicy" = 2;
      "network.http.speculative-parallel-limit" = 0;
      "network.IDN_show_punycode" = true;
      "network.predictor.enabled" = false;
      "network.predictor.enable-prefetch" = false;
      "network.prefetch-next" = false;
      "network.proxy.socks_remote_dns" = true;
      "network.ssl_tokens_cache_capacity" = 10240;
      "network.trr.custom_uri" = "https://wikimedia-dns.org/dns-query";
      "network.trr.mode" = 3;
      "network.trr.uri" = "https://wikimedia-dns.org/dns-query";
      "pdfjs.disabled" = false;
      "pdfjs.enableScripting" = false;
      "permissions.default.desktop-notification" = 2;
      "permissions.default.geo" = 2;
      "permissions.default.shortcuts" = 2;
      "permissions.manager.defaultsUrl" = "";
      "privacy.clearHistory.browsingHistoryAndDownloads" = true;
      "privacy.clearHistory.cache" = true;
      "privacy.clearHistory.cookiesAndStorage" = false;
      "privacy.clearHistory.formdata" = true;
      "privacy.clearHistory.historyFormDataAndDownloads" = true;
      "privacy.clearOnShutdown_v2.browsingHistoryAndDownloads" = true;
      "privacy.clearOnShutdown_v2.cache" = true;
      "privacy.clearOnShutdown_v2.cookiesAndStorage" = true;
      "privacy.clearOnShutdown_v2.downloads" = true;
      "privacy.clearOnShutdown_v2.formdata" = true;
      "privacy.clearOnShutdown_v2.historyFormDataAndDownloads" = true;
      "privacy.clearSiteData.browsingHistoryAndDownloads" = true;
      "privacy.clearSiteData.cache" = true;
      "privacy.clearSiteData.cookiesAndStorage" = false;
      "privacy.clearSiteData.formdata" = true;
      "privacy.clearSiteData.historyFormDataAndDownloads" = true;
      "privacy.firstparty.isolate" = false;
      "privacy.globalprivacycontrol.enabled" = true;
      "privacy.history.custom" = true;
      "privacy.resistFingerprinting.block_mozAddonManager" = true;
      "privacy.sanitize.sanitizeOnShutdown" = true;
      "privacy.sanitize.timeSpan" = 0;
      "privacy.spoof_english" = 1;
      "privacy.userContext.enabled" = true;
      "privacy.userContext.ui.enabled" = true;
      "privacy.window.maxInnerHeight" = 900;
      "privacy.window.maxInnerWidth" = 1600;
      "security.cert_pinning.enforcement_level" = 2;
      "security.dialog_enable_delay" = 1000;
      "security.mixed_content.block_display_content" = true;
      "security.OCSP.enabled" = 1;
      "security.OCSP.require" = true;
      "security.pki.crlite_mode" = 2;
      "security.remote_settings.crlite_filters.enabled" = true;
      "security.ssl.require_safe_negotiation" = true;
      "security.ssl.treat_unsafe_negotiation_as_broken" = true;
      "security.tls.enable_0rtt_data" = false;
      "security.tls.version.enable-deprecated" = false;
      "signon.autofillForms" = false;
      "signon.formlessCapture.enabled" = false;
      "signon.privateBrowsingCapture.enabled" = false;
      "signon.rememberSignons" = false;
      "toolkit.coverage.endpoint.base" = "";
      "toolkit.coverage.opt-out" = true;
      "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
      "toolkit.telemetry.archive.enabled" = false;
      "toolkit.telemetry.bhrPing.enabled" = false;
      "toolkit.telemetry.coverage.opt-out" = true;
      "toolkit.telemetry.enabled" = false;
      "toolkit.telemetry.firstShutdownPing.enabled" = false;
      "toolkit.telemetry.newProfilePing.enabled" = false;
      "toolkit.telemetry.server" = "data:,";
      "toolkit.telemetry.shutdownPingSender.enabled" = false;
      "toolkit.telemetry.unified" = false;
      "toolkit.telemetry.updatePing.enabled" = false;
      "urlclassifier.features.socialtracking.skipURLs" = "";
      "urlclassifier.trackingSkipURLs" = "";

      "browser.bookmarks.addedImportButton" = true;
      "browser.engagement.sidebar-button.has-used" = true;
      "browser.toolbars.bookmarks.visibility" = "never";
      "browser.toolbarbuttons.introduced.sidebar-button" = true;
      "browser.uidensity" = 1;
      "browser.uiCustomization.horizontalTabsBackup" = "{\"placements\":{\"widget-overflow-fixed-list\":[],\"unified-extensions-area\":[],\"nav-bar\":[\"sidebar-button\",\"back-button\",\"forward-button\",\"stop-reload-button\",\"customizableui-special-spring1\",\"vertical-spacer\",\"urlbar-container\",\"customizableui-special-spring2\",\"save-to-pocket-button\",\"downloads-button\",\"fxa-toolbar-menu-button\",\"reset-pbm-toolbar-button\",\"ublock0_raymondhill_net-browser-action\",\"unified-extensions-button\"],\"toolbar-menubar\":[\"menubar-items\"],\"TabsToolbar\":[\"tabbrowser-tabs\",\"new-tab-button\",\"alltabs-button\"],\"vertical-tabs\":[],\"PersonalToolbar\":[\"import-button\",\"personal-bookmarks\"]},\"seen\":[\"reset-pbm-toolbar-button\",\"ublock0_raymondhill_net-browser-action\",\"developer-button\"],\"dirtyAreaCache\":[\"unified-extensions-area\",\"nav-bar\",\"vertical-tabs\",\"PersonalToolbar\"],\"currentVersion\":22,\"newElementCount\":2}";
      "browser.uiCustomization.horizontalTabstrip" = "[\"tabbrowser-tabs\",\"new-tab-button\"]";
      "browser.uiCustomization.navBarWhenVerticalTabs" = "[\"back-button\",\"forward-button\",\"stop-reload-button\",\"vertical-spacer\",\"customizableui-special-spring4\",\"urlbar-container\",\"save-to-pocket-button\",\"customizableui-special-spring5\",\"downloads-button\",\"fxa-toolbar-menu-button\",\"reset-pbm-toolbar-button\",\"ublock0_raymondhill_net-browser-action\",\"unified-extensions-button\"]";
      "browser.uiCustomization.state" = "{\"placements\":{\"widget-overflow-fixed-list\":[],\"unified-extensions-area\":[],\"nav-bar\":[\"sidebar-button\",\"back-button\",\"forward-button\",\"stop-reload-button\",\"vertical-spacer\",\"customizableui-special-spring4\",\"urlbar-container\",\"save-to-pocket-button\",\"customizableui-special-spring5\",\"downloads-button\",\"fxa-toolbar-menu-button\",\"reset-pbm-toolbar-button\",\"ublock0_raymondhill_net-browser-action\",\"unified-extensions-button\"],\"toolbar-menubar\":[\"menubar-items\"],\"TabsToolbar\":[],\"vertical-tabs\":[\"tabbrowser-tabs\"],\"PersonalToolbar\":[\"import-button\",\"personal-bookmarks\"]},\"seen\":[\"reset-pbm-toolbar-button\",\"ublock0_raymondhill_net-browser-action\",\"developer-button\"],\"dirtyAreaCache\":[\"unified-extensions-area\",\"nav-bar\",\"vertical-tabs\",\"PersonalToolbar\",\"TabsToolbar\",\"toolbar-menubar\"],\"currentVersion\":22,\"newElementCount\":6}";
      "sidebar.backupState" = "{\"panelOpen\":false,\"launcherWidth\":0,\"launcherExpanded\":false,\"launcherVisible\":false}";
      "sidebar.new-sidebar.has-used" = true;
      "sidebar.revamp" = true;
      "sidebar.verticalTabs" = true;

      "browser.policies.runOncePerModification.extensionsInstall" = "[\"https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi\"]";
    };
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
