{ config, pkgs, ... }:

{
  # ユーザー環境の基本情報
  # ※ "nixos" を自身のユーザー名に変更してください
  home.username = "nixos";
  home.homeDirectory = "/home/nixos";

  # 初回導入時の Home Manager バージョン（基本的に固定）
  home.stateVersion = "24.11";

  # ユーザー単位で使う CLI ツール
  home.packages = with pkgs; [
    pnpm
    uv
  ];

  # --- Zsh & Oh My Zsh の設定 ---
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    oh-my-zsh = {
      enable = true;
      theme = "robbyrussell"; # お好みのテーマ
      plugins = [
        "git"
      ];
    };

    # エイリアスが必要な場合はここに追加
    shellAliases = {
      rebuild = "sudo nixos-rebuild switch --flake ~/.config/nixos";
      v = "nvim";
    };
  };

  # --- Neovim の設定 ---
  programs.neovim = {
    enable = true;
    defaultEditor = true; # $EDITOR を nvim に設定
    viAlias = true;
    vimAlias = true;

    # プラグインの管理（例）
    plugins = with pkgs.vimPlugins; [
      vim-nix # Nix 言語のハイライト
    ];

    # init.lua / init.vim の初期設定を直書きする場合
    extraConfig = ''
      set number
      set relativenumber
      set expandtab
      set shiftwidth=2
      set tabstop=2
    '';
  };

  # Home Manager 自体の管理を有効化
  programs.home-manager.enable = true;
}
