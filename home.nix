{ config, pkgs, ... }:

{
  home.username = "nixos";
  home.homeDirectory = "/home/nixos";

  home.stateVersion = "24.11";

  home.packages = with pkgs; [
    pnpm
    uv
    git
    zellij
    socat
    whois
    bgpq4
    talosctl
    kubectl
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

    initContent = ''
      eval "$(zellij setup --generate-auto-start zsh)"
    '';
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true; 
    viAlias = true;
    vimAlias = true;

    extraPackages = with pkgs; [
      gcc
      fd
      ripgrep
      #nodePackages.typescript-language-server
      bash-language-server
      vim-language-server
      pyright
      #stylua
      #nixfmt-rfc-style
    ];
    plugins = with pkgs.vimPlugins; [
      vim-nix
      lazy-nvim
    ];

    extraConfig = ''
      set number
      set relativenumber
      set expandtab
      set shiftwidth=2
      set tabstop=2
    '';

  };

  programs.git = {
    enable = true;
    
    settings = {
      safe.directory = "~/.config/nixos";
    };
  };

  programs.zellij = {
    enable = true;
  };

  xdg.configFile."nvim".source = ./nvim; 
  programs.home-manager.enable = true;
}
