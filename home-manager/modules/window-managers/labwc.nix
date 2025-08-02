{
  # config,
  # pkgs,
  lib,
  ...
}: {
  config.programs.waybar = {
    enable = true;

    # https://github.com/Alexays/Waybar/wiki/Configuration
    settings = {
      mainBar = {
        height = 30;
        # mode = "overlay";
        layer = "top";
        position = "top";
      };
    };
  };

  # https://home-manager-options.extranix.com/?query=labwc&release=release-25.05
  config.wayland.windowManager.labwc = {
    enable = true;

    environment =
      lib.mapAttrsToList (name: value: "${name},${toString value}")
      {
        MOZ_ENABLE_WAYLAND = "1"; # Tell Firefox to use Wayland
        NIXOS_OZONE_WL = "1"; # Tell Electron apps to use Wayland
        XDG_CURRENT_DESKTOP = "labwc:wlroots";
        XKB_DEFAULT_LAYOUT = "us";
        # XDG_SESSION_TYPE = "wayland"; # Automatically set, so not needed.
      };

    extraConfig = ''
    '';

    menu = [
      {
        menuId = "client-menu";
        label = "Client Menu";
        icon = "";
        items = [
          {
            label = "Maximize";
            icon = "";
            action = {
              name = "ToggleMaximize";
            };
          }
          {
            label = "Fullscreen";
            action = {
              name = "ToggleFullscreen";
            };
          }
          {
            label = "Always on Top";
            action = {
              name = "ToggleAlwaysOnTop";
            };
          }
          {
            label = "Alacritty";
            action = {
              name = "Execute";
              command = "alacritty";
            };
          }
          {
            label = "Move Left";
            action = {
              name = "SendToDesktop";
              to = "left";
            };
          }
          {
            separator = {};
          }
          {
            label = "Workspace";
            menuId = "workspace";
            icon = "";
            items = [
              {
                label = "Move Left";
                action = {
                  name = "SendToDesktop";
                  to = "left";
                };
              }
            ];
          }
          {
            separator = true;
          }
        ];
      }
    ];

    rc = {
      theme = {
        name = "nord";
        cornerRadius = 8;
        font = {
          "@name" = "FiraCode";
          "@size" = "11";
        };
      };
      keyboard = {
        default = true;
        keybind = [
          #
          {
            "@key" = "W-Return";
            action = {
              "@name" = "Execute";
              "@command" = "foot";
            };
          }
          #
          {
            "@key" = "W-Esc";
            action = {
              "@name" = "Execute";
              "@command" = "loot";
            };
          }
        ];
      };
    };

    systemd.enable = true;

    xwayland.enable = true;
  };

  # Configure a list of packages to be available in your user environment.
  # These are essential programs for a functional LabWC desktop.
  # home.packages = with pkgs; [
  #   # A status bar for Wayland.
  #   waybar
  #   # A launcher for applications.
  #   wofi
  #   # A notification daemon.
  #   dunst
  #   # A good web browser.
  #   firefox
  #   # Tools for screen sharing in Wayland.
  #   wl-clipboard
  #   grim # screenshot utility
  #   slurp # select a region for grim
  # ];

  # Define the autostart script for LabWC.
  # This file is executed when LabWC starts and is used to launch background services.
  # We use 'lib.mkIf' to ensure this block is only included if LabWC is enabled.
  # programs.labwc.config.autostart.text = lib.mkIf config.wayland.windowManager.labwc.enable ''
  #   # Launch a notification daemon.
  #   # The `&` is important to run the program in the background.
  #   ${pkgs.dunst}/bin/dunst &

  #   # Launch a status bar.
  #   ${pkgs.waybar}/bin/waybar &

  #   # Set the GTK theme and icons.
  #   # This ensures your GTK applications have a consistent look.
  #   gsettings set org.gnome.desktop.interface gtk-theme 'Adwaita-dark'
  #   gsettings set org.gnome.desktop.interface icon-theme 'Adwaita'
  # '';

  # Define the rc.xml configuration for keybindings and window rules.
  # This is the core configuration file for LabWC, similar to Openbox.
  # programs.labwc.config.rc.xml.content = ''
  #   <?xml version="1.0" encoding="UTF-8"?>
  #   <labwc_config>
  #     <keyboard>
  #       <chainQuitKey/>
  #       <defaultKeybinds>yes</defaultKeybinds>
  #       <!-- Custom keybindings -->
  #       <keybind key="A-Return">
  #         <action name="Execute">
  #           <command>${pkgs.ghostty}/bin/ghostty</command>
  #         </action>
  #       </keybind>
  #       <keybind key="A-q">
  #         <action name="Exit"/>
  #       </keybind>
  #       <keybind key="A-p">
  #         <action name="Execute">
  #           <command>${pkgs.wofi}/bin/wofi --show drun</command>
  #         </action>
  #       </keybind>
  #       <keybind key="Print">
  #         <action name="Execute">
  #           <command>${pkgs.grim}/bin/grim -g "$(${pkgs.slurp}/bin/slurp)" - | wl-copy</command>
  #         </action>
  #       </keybind>
  #     </keyboard>
  #     <mouse>
  #       <defaultMousebinds>yes</defaultMousebinds>
  #     </mouse>
  #     <menu>
  #       <file>~/.config/labwc/menu.xml</file>
  #     </menu>
  #     <decorations>
  #       <titlebarMaximized>yes</titlebarMaximized>
  #       <borderMaximized>yes</borderMaximized>
  #       <alwaysOnTop>no</alwaysOnTop>
  #       <theme>
  #         <name>Adwaita-dark</name>
  #       </theme>
  #     </decorations>
  #     <themes>
  #       <theme name="Adwaita-dark"/>
  #     </themes>
  #     <windowRules>
  #       <windowRule identifier=".*">
  #         <decorations>client</decorations>
  #         <clientDecoration>yes</clientDecoration>
  #       </windowRule>
  #     </windowRules>
  #   </labwc_config>
  # '';

  # Define the menu.xml configuration for the right-click menu.
  # This provides a basic menu to open applications and exit the session.
  # programs.labwc.config.menu.xml.content = ''
  #   <?xml version="1.0" encoding="UTF-8"?>
  #   <labwc_menu>
  #     <menu id="root-menu" label="LabWC">
  #       <item label="Terminal">
  #         <action name="Execute">
  #           <command>${pkgs.ghostty}/bin/ghostty</command>
  #         </action>
  #       </item>
  #       <item label="Firefox">
  #         <action name="Execute">
  #           <command>${pkgs.firefox}/bin/firefox</command>
  #         </action>
  #       </item>
  #       <item label="Run...">
  #         <action name="Execute">
  #           <command>${pkgs.wofi}/bin/wofi --show run</command>
  #         </action>
  #       </item>
  #       <separator/>
  #       <item label="Exit">
  #         <action name="Exit"/>
  #       </item>
  #     </menu>
  #   </labwc_menu>
  # '';

  # Configure GTK settings for applications that use it.
  # gtk = {
  #   enable = true;
  #   theme = {
  #     name = "Adwaita-dark";
  #     package = pkgs.gnome.adwaita-icon-theme;
  #   };
  #   iconTheme = {
  #     name = "Adwaita";
  #     package = pkgs.gnome.adwaita-icon-theme;
  #   };
  # };
}
