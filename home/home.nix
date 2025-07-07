{pkgs, ...}: {
  home.username = "n1t3";
  home.homeDirectory = "/home/n1t3";

  home.stateVersion = "25.05"; # Please read the comment before changing.

  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    gimp
    inter
    cntr
    gnome-tweaks
    gnomeExtensions.blur-my-shell
    gnomeExtensions.gsconnect
    gnomeExtensions.user-themes
    kotatogram-desktop

    jetbrains.clion

    iosevka

    corefonts
    vistafonts
  ];

  home.file = {};

  programs.onlyoffice.enable = true;

  programs.vesktop = {
    enable = true;
    settings = {
      discordBranch = "canary";
      tray = false;
      minimizeToTray = false;
    };
  };

  programs.vscode = {
    enable = true;
    #extensions = with pkgs.vscode-extensions; [
    #];
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
    keybindings = {
      "ctrl+shift+f11" = "toggle_fullscreen";
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

  home.sessionVariables.GTK_THEME = "WhiteSur-Dark-red";

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
