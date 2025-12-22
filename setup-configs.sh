#!/bin/bash

# ╔═╗┌─┐┌┐┌┌─┐┬┌─┐  ╔═╗┌─┐┌┬┐┬ ┬┌─┐
# ║  │ ││││├┤ ││ ┬  ╚═╗├┤  │ │ │├─┘
# ╚═╝└─┘┘└┘└  ┴└─┘  ╚═╝└─┘ ┴ └─┘┴  
# Script de configuration Hyprland

set -e

# Couleurs
GREEN='\033[0;32m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m'

print_header() {
    echo -e "\n${PURPLE}══════════════════════════════════════════════════════════${NC}"
    echo -e "${CYAN}  $1${NC}"
    echo -e "${PURPLE}══════════════════════════════════════════════════════════${NC}\n"
}

print_step() {
    echo -e "${GREEN}[+]${NC} $1"
}

print_header "Configuration des fichiers"

# ============================================================
# Création des dossiers
# ============================================================
print_step "Création des dossiers de configuration..."
mkdir -p ~/.config/{hypr,kitty,waybar,wofi,wlogout,mako,gtk-3.0,gtk-4.0}
mkdir -p ~/.config/hypr/scripts
mkdir -p ~/Pictures/{Wallpapers,Screenshots}

# ============================================================
# HYPRLAND - env.conf
# ============================================================
print_step "Configuration Hyprland - Variables d'environnement..."
cat > ~/.config/hypr/env.conf << 'EOF'
# NVIDIA Configuration
env = LIBVA_DRIVER_NAME,nvidia
env = XDG_SESSION_TYPE,wayland
env = GBM_BACKEND,nvidia-drm
env = __GLX_VENDOR_LIBRARY_NAME,nvidia
env = NVD_BACKEND,direct

# Cursor
env = WLR_NO_HARDWARE_CURSORS,1
env = XCURSOR_SIZE,24
env = XCURSOR_THEME,catppuccin-mocha-dark-cursors

# Qt/GTK
env = QT_QPA_PLATFORM,wayland
env = QT_QPA_PLATFORMTHEME,qt5ct
env = QT_WAYLAND_DISABLE_WINDOWDECORATION,1
env = GDK_BACKEND,wayland,x11
env = SDL_VIDEODRIVER,wayland
env = CLUTTER_BACKEND,wayland

# XDG
env = XDG_CURRENT_DESKTOP,Hyprland
env = XDG_SESSION_DESKTOP,Hyprland

# Theme
env = GTK_THEME,catppuccin-mocha-mauve-standard+default
EOF

# ============================================================
# HYPRLAND - hyprland.conf
# ============================================================
print_step "Configuration Hyprland - Config principale..."
cat > ~/.config/hypr/hyprland.conf << 'EOF'
# ╦ ╦╦ ╦╔═╗╦═╗╦  ╔═╗╔╗╔╔╦╗
# ╠═╣╚╦╝╠═╝╠╦╝║  ╠═╣║║║ ║║
# ╩ ╩ ╩ ╩  ╩╚═╩═╝╩ ╩╝╚╝═╩╝

source = ~/.config/hypr/env.conf
source = ~/.config/hypr/keybinds.conf
source = ~/.config/hypr/windowrules.conf
source = ~/.config/hypr/autostart.conf

# Monitor (auto-detect)
monitor = ,preferred,auto,1

# General
general {
    gaps_in = 5
    gaps_out = 10
    border_size = 2
    col.active_border = rgba(cba6f7ee) rgba(89b4faee) 45deg
    col.inactive_border = rgba(45475aaa)
    layout = dwindle
    allow_tearing = false
}

# Decoration
decoration {
    rounding = 12
    
    blur {
        enabled = true
        size = 8
        passes = 3
        new_optimizations = true
        xray = true
        ignore_opacity = true
    }
    
    shadow {
        enabled = true
        range = 20
        render_power = 3
        color = rgba(1a1a1aee)
    }
}

# Animations
animations {
    enabled = true
    
    bezier = wind, 0.05, 0.9, 0.1, 1.05
    bezier = winIn, 0.1, 1.1, 0.1, 1.1
    bezier = winOut, 0.3, -0.3, 0, 1
    bezier = liner, 1, 1, 1, 1
    
    animation = windows, 1, 6, wind, slide
    animation = windowsIn, 1, 6, winIn, slide
    animation = windowsOut, 1, 5, winOut, slide
    animation = windowsMove, 1, 5, wind, slide
    animation = border, 1, 1, liner
    animation = borderangle, 1, 30, liner, loop
    animation = fade, 1, 10, default
    animation = workspaces, 1, 5, wind
}

# Layout (style Omarchy)
dwindle {
    pseudotile = true
    preserve_split = true
    force_split = 0          # 0 = split suit la souris (comme Omarchy)
    smart_split = true       # Split intelligent basé sur l'espace disponible
    smart_resizing = true    # Resize intelligent
}

master {
    new_status = master
}

# Misc
misc {
    force_default_wallpaper = 0
    disable_hyprland_logo = true
    disable_splash_rendering = true
    mouse_move_enables_dpms = true
    key_press_enables_dpms = true
    animate_manual_resizes = true
    animate_mouse_windowdragging = true
}

# Input
input {
    kb_layout = fr
    kb_options = caps:escape
    follow_mouse = 1
    sensitivity = 0
    
    touchpad {
        natural_scroll = true
        tap-to-click = true
        drag_lock = true
    }
    
    touchdevice {
        enabled = true
    }
}

# Gestures (pour le ROG Flow en mode tablette)
gestures {
    workspace_swipe = true
    workspace_swipe_fingers = 3
    workspace_swipe_touch = true
}

# NVIDIA specific
render {
    explicit_sync = 2
    explicit_sync_kms = 1
    direct_scanout = false
}

cursor {
    no_hardware_cursors = true
}
EOF

# ============================================================
# HYPRLAND - keybinds.conf
# ============================================================
print_step "Configuration Hyprland - Keybinds..."
cat > ~/.config/hypr/keybinds.conf << 'EOF'
# ╦╔═┌─┐┬ ┬┌┐ ┬┌┐┌┌┬┐┌─┐
# ╠╩╗├┤ └┬┘├┴┐││││ ││└─┐
# ╩ ╩└─┘ ┴ └─┘┴┘└┘─┴┘└─┘

$mainMod = SUPER

# Apps
bind = $mainMod, Return, exec, kitty
bind = $mainMod, E, exec, thunar
bind = $mainMod, B, exec, brave
bind = $mainMod, D, exec, wofi --show drun
bind = $mainMod SHIFT, D, exec, wofi --show run

# Windows
bind = $mainMod, Q, killactive
bind = $mainMod SHIFT, Q, exit
bind = $mainMod, F, fullscreen, 0
bind = $mainMod SHIFT, F, fullscreen, 1
bind = $mainMod, V, togglefloating
bind = $mainMod, P, pseudo
bind = $mainMod, J, togglesplit          # Toggle split horizontal/vertical
bind = $mainMod, G, togglegroup
bind = $mainMod, Tab, changegroupactive

# Preselect split direction (comme Omarchy)
bind = $mainMod CTRL, left, layoutmsg, preselect l
bind = $mainMod CTRL, right, layoutmsg, preselect r
bind = $mainMod CTRL, up, layoutmsg, preselect u
bind = $mainMod CTRL, down, layoutmsg, preselect d

# Focus (arrows)
bind = $mainMod, left, movefocus, l
bind = $mainMod, right, movefocus, r
bind = $mainMod, up, movefocus, u
bind = $mainMod, down, movefocus, d

# Focus (vim keys)
bind = $mainMod, H, movefocus, l
bind = $mainMod, L, movefocus, r
bind = $mainMod, K, movefocus, u
bind = $mainMod SHIFT, J, movefocus, d

# Move windows
bind = $mainMod SHIFT, left, movewindow, l
bind = $mainMod SHIFT, right, movewindow, r
bind = $mainMod SHIFT, up, movewindow, u
bind = $mainMod SHIFT, down, movewindow, d
bind = $mainMod SHIFT, H, movewindow, l
bind = $mainMod SHIFT, L, movewindow, r
bind = $mainMod SHIFT, K, movewindow, u
bind = $mainMod CTRL, J, movewindow, d

# Swap with next/previous window
bind = $mainMod ALT, J, swapnext
bind = $mainMod ALT, K, swapnext, prev

# Resize
binde = $mainMod CTRL, left, resizeactive, -30 0
binde = $mainMod CTRL, right, resizeactive, 30 0
binde = $mainMod CTRL, up, resizeactive, 0 -30
binde = $mainMod CTRL, down, resizeactive, 0 30

# Workspaces
bind = $mainMod, 1, workspace, 1
bind = $mainMod, 2, workspace, 2
bind = $mainMod, 3, workspace, 3
bind = $mainMod, 4, workspace, 4
bind = $mainMod, 5, workspace, 5
bind = $mainMod, 6, workspace, 6
bind = $mainMod, 7, workspace, 7
bind = $mainMod, 8, workspace, 8
bind = $mainMod, 9, workspace, 9
bind = $mainMod, 0, workspace, 10

# Move to workspace
bind = $mainMod SHIFT, 1, movetoworkspace, 1
bind = $mainMod SHIFT, 2, movetoworkspace, 2
bind = $mainMod SHIFT, 3, movetoworkspace, 3
bind = $mainMod SHIFT, 4, movetoworkspace, 4
bind = $mainMod SHIFT, 5, movetoworkspace, 5
bind = $mainMod SHIFT, 6, movetoworkspace, 6
bind = $mainMod SHIFT, 7, movetoworkspace, 7
bind = $mainMod SHIFT, 8, movetoworkspace, 8
bind = $mainMod SHIFT, 9, movetoworkspace, 9
bind = $mainMod SHIFT, 0, movetoworkspace, 10

# Scratchpad
bind = $mainMod, S, togglespecialworkspace, magic
bind = $mainMod SHIFT, S, movetoworkspace, special:magic

# Scroll workspaces
bind = $mainMod, mouse_down, workspace, e+1
bind = $mainMod, mouse_up, workspace, e-1
bind = $mainMod ALT, right, workspace, e+1
bind = $mainMod ALT, left, workspace, e-1

# Mouse
bindm = $mainMod, mouse:272, movewindow
bindm = $mainMod, mouse:273, resizewindow

# Screenshots
bind = , Print, exec, grim - | wl-copy
bind = SHIFT, Print, exec, grim -g "$(slurp)" - | wl-copy
bind = $mainMod, Print, exec, grim -g "$(slurp)" - | swappy -f -
bind = $mainMod SHIFT, Print, exec, grim ~/Pictures/Screenshots/$(date +%Y%m%d_%H%M%S).png

# Lock & Power
bind = $mainMod, Escape, exec, hyprlock
bind = $mainMod SHIFT, Escape, exec, wlogout

# Clipboard
bind = $mainMod, C, exec, cliphist list | wofi --dmenu | cliphist decode | wl-copy

# Color picker
bind = $mainMod SHIFT, C, exec, hyprpicker -a

# Media keys
binde = , XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+
binde = , XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
bind = , XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
bind = , XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle
bind = , XF86AudioPlay, exec, playerctl play-pause
bind = , XF86AudioNext, exec, playerctl next
bind = , XF86AudioPrev, exec, playerctl previous

# Brightness
binde = , XF86MonBrightnessUp, exec, brightnessctl set 5%+
binde = , XF86MonBrightnessDown, exec, brightnessctl set 5%-

# ROG keys (si supportés)
bind = , XF86Launch1, exec, rog-control-center
bind = , XF86Launch4, exec, asusctl profile -n

# Toggle waybar
bind = $mainMod SHIFT, B, exec, pkill waybar || waybar

# Wallpaper
bind = $mainMod, W, exec, ~/.config/hypr/scripts/wallpaper-select.sh
bind = $mainMod SHIFT, W, exec, ~/.config/hypr/scripts/wallpaper-random.sh
EOF

# ============================================================
# HYPRLAND - windowrules.conf
# ============================================================
print_step "Configuration Hyprland - Window rules..."
cat > ~/.config/hypr/windowrules.conf << 'EOF'
# ╦ ╦┬┌┐┌┌┬┐┌─┐┬ ┬  ╦═╗┬ ┬┬  ┌─┐┌─┐
# ║║║││││ │││ ││││  ╠╦╝│ ││  ├┤ └─┐
# ╚╩╝┴┘└┘─┴┘└─┘└┴┘  ╩╚═└─┘┴─┘└─┘└─┘

# Floating
windowrulev2 = float, class:^(pavucontrol)$
windowrulev2 = float, class:^(nm-connection-editor)$
windowrulev2 = float, class:^(blueman-manager)$
windowrulev2 = float, class:^(thunar)$, title:^(File Operation Progress)$
windowrulev2 = float, class:^(org.kde.polkit-kde-authentication-agent-1)$
windowrulev2 = float, title:^(Open File)$
windowrulev2 = float, title:^(Save File)$
windowrulev2 = float, title:^(Picture-in-Picture)$
windowrulev2 = float, class:^(imv)$
windowrulev2 = float, class:^(mpv)$
windowrulev2 = float, class:^(rog-control-center)$

# Sizes
windowrulev2 = size 800 600, class:^(pavucontrol)$
windowrulev2 = size 800 600, class:^(nm-connection-editor)$
windowrulev2 = size 600 400, class:^(blueman-manager)$

# Opacity
windowrulev2 = opacity 0.92 0.88, class:^(kitty)$
windowrulev2 = opacity 0.95 0.90, class:^(thunar)$
windowrulev2 = opacity 0.95 0.90, class:^(Code)$

# Brave PiP
windowrulev2 = float, title:^(Picture-in-Picture)$
windowrulev2 = pin, title:^(Picture-in-Picture)$
windowrulev2 = size 640 360, title:^(Picture-in-Picture)$
windowrulev2 = move 100%-660 100%-380, title:^(Picture-in-Picture)$

# Idle inhibit
windowrulev2 = idleinhibit fullscreen, class:^(brave-browser)$
windowrulev2 = idleinhibit fullscreen, class:^(mpv)$
windowrulev2 = idleinhibit focus, class:^(mpv)$

# Layer rules
layerrule = blur, waybar
layerrule = ignorezero, waybar
layerrule = blur, wofi
layerrule = ignorezero, wofi
layerrule = blur, notifications
layerrule = ignorezero, notifications
EOF

# ============================================================
# HYPRLAND - autostart.conf
# ============================================================
print_step "Configuration Hyprland - Autostart..."
cat > ~/.config/hypr/autostart.conf << 'EOF'
# ╔═╗┬ ┬┌┬┐┌─┐┌─┐┌┬┐┌─┐┬─┐┌┬┐
# ╠═╣│ │ │ │ │└─┐ │ ├─┤├┬┘ │ 
# ╩ ╩└─┘ ┴ └─┘└─┘ ┴ ┴ ┴┴└─ ┴ 

# Core
exec-once = dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
exec-once = systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP

# Polkit
exec-once = /usr/lib/polkit-kde-authentication-agent-1

# Wallpaper
exec-once = hyprpaper

# Bar
exec-once = waybar

# Notifications
exec-once = mako

# Clipboard
exec-once = wl-paste --type text --watch cliphist store
exec-once = wl-paste --type image --watch cliphist store

# Network & Bluetooth
exec-once = nm-applet --indicator
exec-once = blueman-applet

# Idle
exec-once = hypridle

# Cursor theme
exec-once = hyprctl setcursor catppuccin-mocha-dark-cursors 24

# GTK settings
exec-once = gsettings set org.gnome.desktop.interface gtk-theme 'catppuccin-mocha-mauve-standard+default'
exec-once = gsettings set org.gnome.desktop.interface icon-theme 'Papirus-Dark'
exec-once = gsettings set org.gnome.desktop.interface cursor-theme 'catppuccin-mocha-dark-cursors'
exec-once = gsettings set org.gnome.desktop.interface font-name 'Cantarell 11'
EOF

# ============================================================
# HYPRPAPER
# ============================================================
print_step "Configuration Hyprpaper..."
cat > ~/.config/hypr/hyprpaper.conf << 'EOF'
preload = ~/Pictures/Wallpapers/wallpaper.png
wallpaper = ,~/Pictures/Wallpapers/wallpaper.png
splash = false
ipc = off
EOF

# ============================================================
# HYPRLOCK
# ============================================================
print_step "Configuration Hyprlock..."
cat > ~/.config/hypr/hyprlock.conf << 'EOF'
background {
    monitor =
    path = ~/Pictures/Wallpapers/wallpaper.png
    blur_passes = 3
    blur_size = 8
    noise = 0.0117
    contrast = 0.8916
    brightness = 0.8172
    vibrancy = 0.1696
}

input-field {
    monitor =
    size = 250, 50
    outline_thickness = 3
    dots_size = 0.33
    dots_spacing = 0.15
    dots_center = true
    outer_color = rgb(cba6f7)
    inner_color = rgb(1e1e2e)
    font_color = rgb(cdd6f4)
    fade_on_empty = true
    placeholder_text = <i>Password...</i>
    hide_input = false
    rounding = 15
    check_color = rgb(a6e3a1)
    fail_color = rgb(f38ba8)
    position = 0, -20
    halign = center
    valign = center
}

label {
    monitor =
    text = $TIME
    color = rgb(cdd6f4)
    font_size = 90
    font_family = JetBrainsMono Nerd Font Bold
    position = 0, 150
    halign = center
    valign = center
}

label {
    monitor =
    text = cmd[update:1000] echo "$(date +"%A, %d %B")"
    color = rgb(bac2de)
    font_size = 20
    font_family = JetBrainsMono Nerd Font
    position = 0, 50
    halign = center
    valign = center
}
EOF

# ============================================================
# HYPRIDLE
# ============================================================
print_step "Configuration Hypridle..."
cat > ~/.config/hypr/hypridle.conf << 'EOF'
general {
    lock_cmd = pidof hyprlock || hyprlock
    before_sleep_cmd = loginctl lock-session
    after_sleep_cmd = hyprctl dispatch dpms on
}

listener {
    timeout = 300
    on-timeout = brightnessctl -s set 30%
    on-resume = brightnessctl -r
}

listener {
    timeout = 600
    on-timeout = loginctl lock-session
}

listener {
    timeout = 660
    on-timeout = hyprctl dispatch dpms off
    on-resume = hyprctl dispatch dpms on
}

listener {
    timeout = 1800
    on-timeout = systemctl suspend
}
EOF

# ============================================================
# KITTY
# ============================================================
print_step "Configuration Kitty..."
cat > ~/.config/kitty/kitty.conf << 'EOF'
# Font
font_family      JetBrainsMono Nerd Font
bold_font        JetBrainsMono Nerd Font Bold
italic_font      JetBrainsMono Nerd Font Italic
bold_italic_font JetBrainsMono Nerd Font Bold Italic
font_size 12.0

adjust_line_height 110%
disable_ligatures never

# Cursor
cursor_shape beam
cursor_beam_thickness 2
cursor_blink_interval 0.5

# Scrollback
scrollback_lines 10000
wheel_scroll_multiplier 5.0

# Window
remember_window_size no
initial_window_width 1200
initial_window_height 700
window_padding_width 15
hide_window_decorations yes
confirm_os_window_close 0

# Tabs
tab_bar_edge top
tab_bar_style powerline
tab_powerline_style slanted
tab_bar_min_tabs 2

# Catppuccin Mocha
foreground              #CDD6F4
background              #1E1E2E
selection_foreground    #1E1E2E
selection_background    #F5E0DC
cursor                  #F5E0DC
cursor_text_color       #1E1E2E
url_color               #F5E0DC

active_tab_foreground   #11111B
active_tab_background   #CBA6F7
inactive_tab_foreground #CDD6F4
inactive_tab_background #181825

active_border_color     #B4BEFE
inactive_border_color   #6C7086

color0  #45475A
color1  #F38BA8
color2  #A6E3A1
color3  #F9E2AF
color4  #89B4FA
color5  #F5C2E7
color6  #94E2D5
color7  #BAC2DE
color8  #585B70
color9  #F38BA8
color10 #A6E3A1
color11 #F9E2AF
color12 #89B4FA
color13 #F5C2E7
color14 #94E2D5
color15 #A6ADC8

mark1_foreground #1E1E2E
mark1_background #B4BEFE

# Misc
background_opacity 0.92
background_blur 1
enable_audio_bell no

# Keybinds
map ctrl+shift+c copy_to_clipboard
map ctrl+shift+v paste_from_clipboard
map ctrl+shift+t new_tab
map ctrl+shift+q close_tab
map ctrl+shift+right next_tab
map ctrl+shift+left previous_tab
map ctrl+shift+plus change_font_size all +2.0
map ctrl+shift+minus change_font_size all -2.0
EOF

# ============================================================
# WAYBAR CONFIG
# ============================================================
print_step "Configuration Waybar..."
cat > ~/.config/waybar/config.jsonc << 'EOF'
{
    "layer": "top",
    "position": "top",
    "height": 38,
    "spacing": 0,
    "margin-top": 5,
    "margin-left": 10,
    "margin-right": 10,
    
    "modules-left": ["custom/launcher", "hyprland/workspaces", "hyprland/window"],
    "modules-center": ["clock"],
    "modules-right": ["tray", "pulseaudio", "network", "cpu", "memory", "battery", "custom/power"],
    
    "custom/launcher": {
        "format": " ",
        "on-click": "wofi --show drun",
        "tooltip": false
    },
    
    "hyprland/workspaces": {
        "format": "{icon}",
        "format-icons": {
            "1": "󰎤", "2": "󰎧", "3": "󰎪", "4": "󰎭", "5": "󰎱",
            "6": "󰎳", "7": "󰎶", "8": "󰎹", "9": "󰎼", "10": "󰽽",
            "urgent": "", "active": "", "default": ""
        },
        "on-click": "activate",
        "sort-by-number": true
    },
    
    "hyprland/window": {
        "format": "{}",
        "max-length": 40,
        "separate-outputs": true
    },
    
    "clock": {
        "format": "  {:%H:%M}",
        "format-alt": "  {:%A %d %B %Y}",
        "tooltip-format": "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>"
    },
    
    "cpu": {
        "format": "  {usage}%",
        "interval": 2,
        "on-click": "kitty -e btop"
    },
    
    "memory": {
        "format": "  {}%",
        "interval": 2,
        "on-click": "kitty -e btop"
    },
    
    "battery": {
        "states": { "good": 95, "warning": 30, "critical": 15 },
        "format": "{icon}  {capacity}%",
        "format-charging": "  {capacity}%",
        "format-plugged": "  {capacity}%",
        "format-icons": ["", "", "", "", ""]
    },
    
    "network": {
        "format-wifi": "  {signalStrength}%",
        "format-ethernet": "󰈀  {ipaddr}",
        "format-disconnected": "󰖪  ",
        "tooltip-format": "{ifname}: {ipaddr}/{cidr}\n{essid}",
        "on-click": "nm-connection-editor"
    },
    
    "pulseaudio": {
        "format": "{icon}  {volume}%",
        "format-bluetooth": "  {volume}%",
        "format-muted": "  ",
        "format-icons": { "default": ["", "", ""] },
        "on-click": "pavucontrol"
    },
    
    "tray": { "icon-size": 16, "spacing": 10 },
    
    "custom/power": {
        "format": " ",
        "on-click": "wlogout",
        "tooltip": false
    }
}
EOF

# ============================================================
# WAYBAR STYLE
# ============================================================
print_step "Configuration Waybar style..."
cat > ~/.config/waybar/style.css << 'EOF'
@define-color base   #1e1e2e;
@define-color surface0 #313244;
@define-color surface1 #45475a;
@define-color text     #cdd6f4;
@define-color blue     #89b4fa;
@define-color lavender #b4befe;
@define-color sapphire #74c7ec;
@define-color teal     #94e2d5;
@define-color green    #a6e3a1;
@define-color yellow   #f9e2af;
@define-color peach    #fab387;
@define-color red      #f38ba8;
@define-color mauve    #cba6f7;
@define-color pink     #f5c2e7;

* {
    font-family: "JetBrainsMono Nerd Font", "Font Awesome 6 Free";
    font-size: 13px;
    font-weight: bold;
    min-height: 0;
}

window#waybar { background: transparent; }

window#waybar > box {
    background: alpha(@base, 0.85);
    border: 2px solid @surface0;
    border-radius: 15px;
    padding: 0 10px;
}

#workspaces, #clock, #battery, #cpu, #memory, #network, #pulseaudio, #tray, #custom-launcher, #custom-power, #window {
    padding: 0 12px;
    margin: 5px 3px;
    border-radius: 10px;
    background: @surface0;
    color: @text;
}

#workspaces { background: transparent; padding: 0; }
#workspaces button {
    padding: 0 8px;
    margin: 5px 2px;
    border-radius: 10px;
    background: @surface0;
    color: @text;
}
#workspaces button:hover { background: @surface1; }
#workspaces button.active {
    background: linear-gradient(45deg, @blue, @mauve);
    color: @base;
}

#clock {
    background: linear-gradient(45deg, @blue, @lavender);
    color: @base;
}

#battery { background: @green; color: @base; }
#battery.charging { background: @teal; color: @base; }
#battery.warning:not(.charging) { background: @yellow; color: @base; }
#battery.critical:not(.charging) { background: @red; color: @base; }

#cpu { background: @sapphire; color: @base; }
#memory { background: @mauve; color: @base; }
#network { background: @teal; color: @base; }
#network.disconnected { background: @surface1; color: @red; }
#pulseaudio { background: @pink; color: @base; }
#pulseaudio.muted { background: @surface1; color: @text; }

#custom-launcher {
    background: linear-gradient(45deg, @mauve, @pink);
    color: @base;
    font-size: 18px;
    padding: 0 15px;
}

#custom-power {
    background: @red;
    color: @base;
    font-size: 16px;
    padding: 0 12px;
    margin-right: 5px;
}

#window { background: transparent; color: @text; font-weight: normal; }
EOF

# ============================================================
# WOFI
# ============================================================
print_step "Configuration Wofi..."
cat > ~/.config/wofi/config << 'EOF'
width=600
height=400
location=center
show=drun
prompt=Search...
filter_rate=100
allow_markup=true
no_actions=true
halign=fill
orientation=vertical
content_halign=fill
insensitive=true
allow_images=true
image_size=32
gtk_dark=true
layer=overlay
EOF

cat > ~/.config/wofi/style.css << 'EOF'
@define-color base #1e1e2e;
@define-color surface0 #313244;
@define-color surface1 #45475a;
@define-color text #cdd6f4;
@define-color mauve #cba6f7;
@define-color blue #89b4fa;

window {
    background-color: alpha(@base, 0.95);
    border: 2px solid @surface1;
    border-radius: 15px;
    font-family: "JetBrainsMono Nerd Font";
    font-size: 14px;
}

#input {
    background-color: @surface0;
    border: none;
    border-radius: 10px;
    margin: 15px;
    padding: 12px 15px;
    color: @text;
}

#input:focus { border: 2px solid @mauve; }

#inner-box { margin: 0 15px 15px 15px; }

#entry {
    padding: 10px 15px;
    margin: 3px 0;
    border-radius: 10px;
    color: @text;
}

#entry:selected {
    background: linear-gradient(90deg, alpha(@blue, 0.3), alpha(@mauve, 0.3));
    border-left: 3px solid @mauve;
}

#entry:hover { background-color: @surface0; }
EOF

# ============================================================
# WLOGOUT
# ============================================================
print_step "Configuration Wlogout..."
cat > ~/.config/wlogout/layout << 'EOF'
{
    "label" : "lock",
    "action" : "hyprlock",
    "text" : "Lock",
    "keybind" : "l"
}
{
    "label" : "logout",
    "action" : "hyprctl dispatch exit",
    "text" : "Logout",
    "keybind" : "e"
}
{
    "label" : "shutdown",
    "action" : "systemctl poweroff",
    "text" : "Shutdown",
    "keybind" : "s"
}
{
    "label" : "suspend",
    "action" : "systemctl suspend",
    "text" : "Suspend",
    "keybind" : "u"
}
{
    "label" : "reboot",
    "action" : "systemctl reboot",
    "text" : "Reboot",
    "keybind" : "r"
}
EOF

cat > ~/.config/wlogout/style.css << 'EOF'
@define-color base #1e1e2e;
@define-color surface0 #313244;
@define-color text #cdd6f4;
@define-color blue #89b4fa;
@define-color red #f38ba8;
@define-color yellow #f9e2af;
@define-color green #a6e3a1;
@define-color mauve #cba6f7;

* { background-image: none; font-family: "JetBrainsMono Nerd Font"; }
window { background-color: alpha(@base, 0.9); }
button {
    background-color: @surface0;
    border-radius: 20px;
    margin: 10px;
    padding: 20px;
    color: @text;
    border: 2px solid transparent;
}
button:hover { background-color: alpha(@blue, 0.2); border: 2px solid @blue; }
button:focus { background-color: alpha(@mauve, 0.2); border: 2px solid @mauve; }
#lock:hover { border-color: @green; }
#logout:hover { border-color: @yellow; }
#suspend:hover { border-color: @blue; }
#shutdown:hover { border-color: @red; }
#reboot:hover { border-color: @mauve; }
EOF

# ============================================================
# MAKO
# ============================================================
print_step "Configuration Mako..."
cat > ~/.config/mako/config << 'EOF'
font=JetBrainsMono Nerd Font 11
background-color=#1e1e2edd
text-color=#cdd6f4
border-color=#cba6f7
border-size=2
border-radius=10
padding=15
margin=10
width=350
height=150
max-icon-size=48
icon-path=/usr/share/icons/Papirus-Dark

default-timeout=5000
max-visible=5
layer=overlay
anchor=top-right

[urgency=low]
border-color=#a6e3a1
default-timeout=3000

[urgency=normal]
border-color=#89b4fa

[urgency=critical]
border-color=#f38ba8
default-timeout=0
EOF

# ============================================================
# GTK
# ============================================================
print_step "Configuration GTK..."
cat > ~/.config/gtk-3.0/settings.ini << 'EOF'
[Settings]
gtk-theme-name=catppuccin-mocha-mauve-standard+default
gtk-icon-theme-name=Papirus-Dark
gtk-cursor-theme-name=catppuccin-mocha-dark-cursors
gtk-cursor-theme-size=24
gtk-font-name=Cantarell 11
gtk-application-prefer-dark-theme=true
EOF

cp ~/.config/gtk-3.0/settings.ini ~/.config/gtk-4.0/settings.ini

# ============================================================
# Télécharger wallpaper
# ============================================================
print_step "Téléchargement d'un wallpaper Catppuccin..."
curl -sL -o ~/Pictures/Wallpapers/wallpaper.png \
    "https://raw.githubusercontent.com/catppuccin/wallpapers/main/landscapes/evening-sky.png" 2>/dev/null || \
    echo "Wallpaper download failed - you can add your own later"

# ============================================================
# Scripts Wallpaper
# ============================================================
print_step "Création des scripts de wallpaper..."

cat > ~/.config/hypr/scripts/wallpaper-select.sh << 'WALLSCRIPT'
#!/bin/bash
WALLPAPER_DIR="$HOME/Pictures/Wallpapers"
wallpaper=$(find "$WALLPAPER_DIR" -type f \( -iname "*.png" -o -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.webp" \) | sort | wofi --dmenu --prompt "Wallpaper" --cache-file /dev/null)
if [ -n "$wallpaper" ]; then
    echo "preload = $wallpaper" > ~/.config/hypr/hyprpaper.conf
    echo "wallpaper = ,$wallpaper" >> ~/.config/hypr/hyprpaper.conf
    echo "splash = false" >> ~/.config/hypr/hyprpaper.conf
    sed -i "s|path = .*|path = $wallpaper|g" ~/.config/hypr/hyprlock.conf 2>/dev/null || true
    pkill hyprpaper; hyprpaper &
    notify-send "Wallpaper" "Changé!" -i preferences-desktop-wallpaper
fi
WALLSCRIPT
chmod +x ~/.config/hypr/scripts/wallpaper-select.sh

cat > ~/.config/hypr/scripts/wallpaper-random.sh << 'RANDSCRIPT'
#!/bin/bash
WALLPAPER_DIR="$HOME/Pictures/Wallpapers"
wallpaper=$(find "$WALLPAPER_DIR" -type f \( -iname "*.png" -o -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.webp" \) | shuf -n 1)
if [ -n "$wallpaper" ]; then
    echo "preload = $wallpaper" > ~/.config/hypr/hyprpaper.conf
    echo "wallpaper = ,$wallpaper" >> ~/.config/hypr/hyprpaper.conf
    echo "splash = false" >> ~/.config/hypr/hyprpaper.conf
    sed -i "s|path = .*|path = $wallpaper|g" ~/.config/hypr/hyprlock.conf 2>/dev/null || true
    pkill hyprpaper; hyprpaper &
fi
RANDSCRIPT
chmod +x ~/.config/hypr/scripts/wallpaper-random.sh

# ============================================================
# FIN
# ============================================================
print_header "Configuration terminée !"

echo -e "${GREEN}✓${NC} Tous les fichiers de configuration sont en place"
echo ""
echo -e "${CYAN}Raccourcis principaux:${NC}"
echo "  SUPER + Return     → Terminal (Kitty)"
echo "  SUPER + D          → Launcher (Wofi)"
echo "  SUPER + E          → Fichiers (Thunar)"
echo "  SUPER + B          → Brave"
echo "  SUPER + Q          → Fermer fenêtre"
echo "  SUPER + F          → Plein écran"
echo "  SUPER + V          → Floating"
echo "  SUPER + 1-9        → Workspaces"
echo "  SUPER + W          → Choisir wallpaper"
echo "  SUPER + SHIFT + W  → Wallpaper aléatoire"
echo "  SUPER + Escape     → Lock screen"
echo "  SUPER + SHIFT + Escape → Power menu"
echo "  Print              → Screenshot"
echo ""
echo -e "${YELLOW}Pour télécharger plus de wallpapers, exécute:${NC}"
echo "  ./download-wallpapers.sh"
echo ""
echo -e "${YELLOW}Il faut maintenant rebooter !${NC}"
echo ""
read -p "Reboot maintenant ? (y/n) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    sudo reboot
fi
