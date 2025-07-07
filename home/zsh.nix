_: {
  home.shell.enableZshIntegration = true;
  programs = {
    zsh = {
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
    zoxide = {
      enable = true;
      enableZshIntegration = true;
    };
    eza = {
      enable = true;
      enableZshIntegration = true;
    };
    kitty.shellIntegration.enableZshIntegration = true;
  };
}
