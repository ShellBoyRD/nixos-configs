# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Set your time zone.
  time.timeZone = "Canada/Toronto";

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.enp2s0.useDHCP = true;
  networking.interfaces.wlp0s20u10.useDHCP = true;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
    i18n.defaultLocale = "en_US.UTF-8";
    console = {
      font = "Lat2-Terminus16";
      keyMap = "us";
    };

  # Enable Desktop Environments. 

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # GNOME Configuration
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  

  environment.gnome.excludePackages = [
  pkgs.epiphany
  pkgs.gnome.cheese
  pkgs.gnome.gnome-music
  pkgs.gnome.gedit
  pkgs.gnome.totem
  pkgs.gnome.tali
  pkgs.gnome.iagno
  pkgs.gnome.hitori
  pkgs.gnome.atomix
  pkgs.gnome-tour
  pkgs.gnome.geary
  ];

  services.udev.packages = with pkgs; [
  gnome3.gnome-settings-daemon
  ];
  
  # Other Desktop Environments
  services.xserver.desktopManager.lxqt.enable = true; 
  services.xserver.desktopManager.mate.enable = true;
  # services.xserver.desktopManager.xfce.enable = true;  
  
  # Polkit
  security.polkit.enable = true; 

  # Configure keymap in X11
  services.xserver.layout = "us";
  services.xserver.xkbOptions = "eurosign:e";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users."mv" = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
   };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  # awesome
    awesome
    nitrogen
    rofi
  # cli-tools 
    git
    dash
    zsh
    fish
    aria2
    wget
    lshw
    foot
    lshw
    speedtest-cli
    btop
    fzf
    docker
    kubectl
  # GNOME-extensions
  gnomeExtensions.appindicator
  gnomeExtensions.dash-to-dock
  # text/code editors
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    emacs
    vscode
  # web
    firefox
    bitwarden
  
  # gnome accesories
    polkit_gnome
    arc-theme
    guake
    gnome-themes-extra
    gnome.gnome-tweaks
    
  # music
    audacious
    
  # office
    libreoffice-fresh
    ];
  
  # enable shells
  programs.zsh.enable = true;
  programs.fish.enable = true;
  
  # set default shell
  users.defaultUserShell = pkgs.fish;

  # change /bin/sh to dash
  environment.binsh = "${pkgs.dash}/bin/dash";
  
  # allow packages with non-free license
    nixpkgs.config.allowUnfree = true; 

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "21.11"; # Did you read the comment?

}

