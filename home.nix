{ config, pkgs, ... }:

{
  home.username = "nixos";
  home.homeDirectory = "/home/nixos";

  home.stateVersion = "24.11";

  home.packages = with pkgs; [
    pnpm
    uv
  ];

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    oh-my-zsh = {
      enable = true;
      theme = "robbyrussell"; 
      plugins = [
        "git"
      ];
    };

    shellAliases = {
      rebuild = "sudo nixos-rebuild switch --flake ~/.config/nixos";
      v = "nvim";
    };
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true; 
    viAlias = true;
    vimAlias = true;

    plugins = with pkgs.vimPlugins; [
      vim-nix
    ];

    extraConfig = ''
      set number
      set relativenumber
      set expandtab
      set shiftwidth=2
      set tabstop=2
    '';
  };

  programs.home-manager.enable = true;
}
