# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

# NixOS-WSL specific options are documented on the NixOS-WSL repository:
# https://github.com/nix-community/NixOS-WSL

{ config, lib, pkgs, ... }:

{
  imports = [
  ];

  environment.systemPackages = with pkgs; [
    pkgs.devcontainer
  ];

  programs.zsh.enable = true;

  users.users.nixos = {
    isNormalUser = true;
    shell = pkgs.zsh;
    
    extraGroups = [ "docker" "wheel" ];
  };

  wsl.enable = true;
  wsl.defaultUser = "nixos";

  system.stateVersion = "26.05"; 

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  services.tailscale = {
    enable = true;
    useRoutingFeatures = "client"; 
    
    extraSetFlags = [
      "--accept-routes=true"
    ];
  };

  systemd.services.wsl-mnt-guard = {
    serviceConfig = {
      ExecStart = [
        "" # 既存の ExecStart をリセット
        "${pkgs.coreutils}/bin/true"
      ];
    };
  };

  virtualisation.docker.enable = true;
}
