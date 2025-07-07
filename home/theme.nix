{pkgs, ...}: {
  dconf = {
    enable = true;
    settings = {
      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
        accent-color = "red";
      };
      "org/gnome/shell" = {
        disable-user-extensions = false;
        enabled-extensions = with pkgs.gnomeExtensions; [
          blur-my-shell.extensionUuid
          gsconnect.extensionUuid
          user-themes.extensionUuid
        ];
      };
      "org/gnome/shell/extensions/user-theme".name = "WhiteSur-Dark-red";
    };
  };
}
