# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Oslo";
   
  # Hyprland
  programs.hyprland ={
     enable = true;
     withUWSM = true;
     xwayland.enable = true;
  };

  environment.sessionVariables.NIXOS_OZONE_WL = "1";
  
  # Steam
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;      # Åpner porter for Remote Play
    dedicatedServer.openFirewall = true; # Åpner porter for evt. dedicated servers
    localNetworkGameTransfers.openFirewall = true; # Rask spilloverføring mellom egne enheter på nettverket
  };

  hardware.graphics = {
    enable = true;
    enable32Bit = true;   # Kreves for Steam/Proton (mange spill er 32-bit)
  };

  # Nvidia 
  services.xserver.videoDrivers = [ "nvidia" ];
  
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    open = true;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  # Login manager
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;

  # Alias NixOS
  programs.bash.shellAliases = {
    nixconf = "sudo nano /etc/nixos/configuration.nix";
    nixconfig = "sudo nano /etc/nixos/configuration.nix";
    nixbuild = "sudo nixos-rebuild switch";
    config = "sudo nano /etc/nixos/configuration.nix";
    update = "sudo nixos-rebuild switch";
    build = "sudo nixos-rebuild switch";
  };

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "no";
    variant = "";
  };

  # Configure console keymap
  console.keyMap = "no";

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users."victor" = {
    isNormalUser = true;
    description = "Victor Skinderviken";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };

  # Audio with Pipewire
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    wireplumber.enable = true;
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # Need
    vim                    # Text Editor
    neovim                 # Text Editor +
    kitty                  # Main Terminal
    fastfetch              # OS-release
    firefox                # Browser
    git                    # Git
    xdg-user-dirs          # User directories. Run the following in terminal after clean install: xdg-user-dirs-update 
    vscode                 # Visual studio code

    # Hyprland packages
    waybar                 # Statusbar
    hyprpaper              # Wallpaper 
    hyprlock               # Lock
    hypridle               # Idle monitor
    cava                   # Music visualizer
    hyprshot               # Screenshot tool
    mako                   # Notifications
    rofi                   # Search 
    playerctl              # Media control in waybar
    hyprpolkitagent        # Agent
    thunar                 # File manager
    thunar-volman          # Automatic mount USB to Thunar
    thunar-archive-plugin  # Right click ability
    gvfs                   # Virtual filesystem
    pavucontrol            # Graphical volume control    
    wlogout                # Logout
    libnotify              # Notifications    
    networkmanagerapplet   # Networkmanager with GUI

    # Tools
    wl-clipboard           # Clipboard
    brightnessctl          # Brightness control
    jq                     # JSON-parsing
    psmisc                 # Killall command
    obsidian               # Documents

    # Fonts
    jetbrains-mono         # Jetbrains IDE font
    bibata-cursors         # Cursor
  ];
 
  services.gvfs.enable = true; # Actuvates gvfs
  fonts.fontconfig.enable = true;

  fonts.packages = with pkgs; [
    nerd-fonts.symbols-only
    noto-fonts-color-emoji
  ];

  environment.sessionVariables = {
    XCURSOR_THEME = "Bibata-Modern-Classic";
    XCURSOR_SIZE = "24";
  };

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
  system.stateVersion = "26.05"; # Did you read the comment?

}
