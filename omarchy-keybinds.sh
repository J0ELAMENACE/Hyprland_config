#!/bin/bash

# ╔═╗┌┬┐┌─┐┬─┐┌─┐┬ ┬┬ ┬  ╦╔═┌─┐┬ ┬┌┐ ┬┌┐┌┌┬┐┌─┐
# ║ ║│││├─┤├┬┘│  ├─┤└┬┘  ╠╩╗├┤ └┬┘├┴┐││││ ││└─┐
# ╚═╝┴ ┴┴ ┴┴└─└─┘┴ ┴ ┴   ╩ ╩└─┘ ┴ └─┘┴┘└┘─┴┘└─┘
# Keybinds Hyprland - Style Omarchy

echo "🎮 Application des keybinds Omarchy..."

# Backup
cp ~/.config/hypr/hyprland.conf ~/.config/hypr/hyprland.conf.bak 2>/dev/null

# Créer le fichier keybinds
cat > ~/.config/hypr/keybinds.conf << 'EOF'
# ╔═╗┌┬┐┌─┐┬─┐┌─┐┬ ┬┬ ┬  ╦╔═┌─┐┬ ┬┌┐ ┬┌┐┌┌┬┐┌─┐
# ║ ║│││├─┤├┬┘│  ├─┤└┬┘  ╠╩╗├┤ └┬┘├┴┐││││ ││└─┐
# ╚═╝┴ ┴┴ ┴┴└─└─┘┴ ┴ ┴   ╩ ╩└─┘ ┴ └─┘┴┘└┘─┴┘└─┘
# Keybinds Style Omarchy pour Hyprland

$mainMod = SUPER

# ══════════════════════════════════════════════════════════════
# NAVIGATION
# ══════════════════════════════════════════════════════════════

# Launchers
bind = $mainMod, Space, exec, wofi --show drun
bind = $mainMod ALT, Space, exec, wofi --show run
bind = $mainMod, Escape, exec, wlogout

# Window Management
bind = $mainMod, W, killactive
bind = $mainMod CTRL ALT, Delete, exec, hyprctl dispatch closewindow address:*
bind = $mainMod, T, togglefloating
bind = $mainMod, O, pin
bind = $mainMod, F, fullscreen, 0
bind = $mainMod ALT, F, fullscreen, 1

# Workspaces - Jump
bind = $mainMod, 1, workspace, 1
bind = $mainMod, 2, workspace, 2
bind = $mainMod, 3, workspace, 3
bind = $mainMod, 4, workspace, 4
bind = $mainMod, 5, workspace, 5
bind = $mainMod, 6, workspace, 6
bind = $mainMod, 7, workspace, 7
bind = $mainMod, 8, workspace, 8
bind = $mainMod, 9, workspace, 9

# Workspaces - Navigate
bind = $mainMod, Tab, workspace, e+1
bind = $mainMod SHIFT, Tab, workspace, e-1
bind = $mainMod CTRL, Tab, workspace, previous

# Workspaces - Move window
bind = $mainMod SHIFT, 1, movetoworkspace, 1
bind = $mainMod SHIFT, 2, movetoworkspace, 2
bind = $mainMod SHIFT, 3, movetoworkspace, 3
bind = $mainMod SHIFT, 4, movetoworkspace, 4
bind = $mainMod SHIFT, 5, movetoworkspace, 5
bind = $mainMod SHIFT, 6, movetoworkspace, 6
bind = $mainMod SHIFT, 7, movetoworkspace, 7
bind = $mainMod SHIFT, 8, movetoworkspace, 8
bind = $mainMod SHIFT, 9, movetoworkspace, 9

# Workspaces - Move to monitor
bind = $mainMod SHIFT ALT, left, movecurrentworkspacetomonitor, l
bind = $mainMod SHIFT ALT, right, movecurrentworkspacetomonitor, r
bind = $mainMod SHIFT ALT, up, movecurrentworkspacetomonitor, u
bind = $mainMod SHIFT ALT, down, movecurrentworkspacetomonitor, d

# Scratchpad
bind = $mainMod, S, togglespecialworkspace, scratchpad
bind = $mainMod ALT, S, movetoworkspace, special:scratchpad

# Focus
bind = $mainMod, left, movefocus, l
bind = $mainMod, right, movefocus, r
bind = $mainMod, up, movefocus, u
bind = $mainMod, down, movefocus, d

# Swap windows
bind = $mainMod SHIFT, left, swapwindow, l
bind = $mainMod SHIFT, right, swapwindow, r
bind = $mainMod SHIFT, up, swapwindow, u
bind = $mainMod SHIFT, down, swapwindow, d

# Resize windows
binde = $mainMod, equal, resizeactive, -50 0
binde = $mainMod, minus, resizeactive, 50 0
binde = $mainMod SHIFT, equal, resizeactive, 0 50
binde = $mainMod SHIFT, minus, resizeactive, 0 -50

# Grouping
bind = $mainMod, G, togglegroup
bind = $mainMod ALT, G, moveoutofgroup
bind = $mainMod ALT, Tab, changegroupactive, f
bind = $mainMod ALT, 1, changegroupactive, 0
bind = $mainMod ALT, 2, changegroupactive, 1
bind = $mainMod ALT, 3, changegroupactive, 2
bind = $mainMod ALT, 4, changegroupactive, 3
bind = $mainMod ALT, left, moveintogroup, l
bind = $mainMod ALT, right, moveintogroup, r
bind = $mainMod ALT, up, moveintogroup, u
bind = $mainMod ALT, down, moveintogroup, d
bind = $mainMod CTRL, left, movefocus, l
bind = $mainMod CTRL, right, movefocus, r
bind = $mainMod CTRL, up, movefocus, u
bind = $mainMod CTRL, down, movefocus, d

# Mouse bindings
bindm = $mainMod, mouse:272, movewindow
bindm = $mainMod, mouse:273, resizewindow

# ══════════════════════════════════════════════════════════════
# LAUNCHING APPS
# ══════════════════════════════════════════════════════════════

bind = $mainMod, Return, exec, kitty
bind = $mainMod SHIFT, B, exec, brave
bind = $mainMod SHIFT ALT, B, exec, brave --incognito
bind = $mainMod SHIFT, F, exec, nautilus
bind = $mainMod SHIFT, T, exec, kitty -e btop
bind = $mainMod SHIFT, M, exec, deezer
bind = $mainMod SHIFT, N, exec, kitty -e nvim
bind = $mainMod SHIFT, D, exec, kitty -e lazydocker
bind = $mainMod SHIFT, G, exec, discord

# ══════════════════════════════════════════════════════════════
# CLIPBOARD (Universal)
# ══════════════════════════════════════════════════════════════

bind = $mainMod, C, exec, wl-copy
bind = $mainMod, V, exec, wl-paste
bind = $mainMod CTRL, V, exec, cliphist list | wofi --dmenu | cliphist decode | wl-copy

# ══════════════════════════════════════════════════════════════
# CAPTURE
# ══════════════════════════════════════════════════════════════

# Screenshot with editing
bind = , Print, exec, grim -g "$(slurp)" - | swappy -f -

# Screenshot straight to clipboard
bind = SHIFT, Print, exec, grim -g "$(slurp)" - | wl-copy

# Screenshot full screen to clipboard
bind = CTRL, Print, exec, grim - | wl-copy

# Screen record (toggle)
bind = ALT, Print, exec, pkill wf-recorder || wf-recorder -g "$(slurp)" -f ~/Videos/recording_$(date +%Y%m%d_%H%M%S).mp4

# Color picker
bind = $mainMod, Print, exec, hyprpicker -a

# ══════════════════════════════════════════════════════════════
# NOTIFICATIONS
# ══════════════════════════════════════════════════════════════

bind = $mainMod, comma, exec, makoctl dismiss
bind = $mainMod SHIFT, comma, exec, makoctl dismiss -a
bind = $mainMod CTRL, comma, exec, makoctl mode -t do-not-disturb
bind = $mainMod ALT, comma, exec, makoctl invoke

# ══════════════════════════════════════════════════════════════
# STYLE
# ══════════════════════════════════════════════════════════════

# Next wallpaper
bind = $mainMod CTRL, Space, exec, ~/.config/hypr/scripts/wallpaper-random.sh

# Wallpaper picker
bind = $mainMod CTRL SHIFT, Space, exec, ~/.config/hypr/scripts/wallpaper-select.sh

# Toggle transparency
bind = $mainMod, BackSpace, exec, ~/.config/hypr/scripts/toggle-opacity.sh

# ══════════════════════════════════════════════════════════════
# TOGGLES
# ══════════════════════════════════════════════════════════════

# Toggle idle prevention
bind = $mainMod CTRL, I, exec, pkill hypridle || hypridle

# Toggle top bar (waybar)
bind = $mainMod SHIFT, Space, exec, pkill waybar || waybar

# Switch audio output
bind = $mainMod, XF86AudioMute, exec, pactl set-default-sink $(pactl list short sinks | grep -v $(pactl get-default-sink) | head -1 | cut -f1)

# ══════════════════════════════════════════════════════════════
# MEDIA KEYS
# ══════════════════════════════════════════════════════════════

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

# ROG keys
bind = , XF86Launch1, exec, rog-control-center
bind = , XF86Launch4, exec, asusctl profile -n
EOF

# Créer le script toggle-opacity
mkdir -p ~/.config/hypr/scripts

cat > ~/.config/hypr/scripts/toggle-opacity.sh << 'OPACITY'
#!/bin/bash
# Toggle opacity on focused window

ADDR=$(hyprctl activewindow -j | jq -r '.address')
CURRENT=$(hyprctl activewindow -j | jq -r '.opacity // 1')

if (( $(echo "$CURRENT < 1" | bc -l) )); then
    hyprctl setprop address:$ADDR alpha 1
else
    hyprctl setprop address:$ADDR alpha 0.85
fi
OPACITY
chmod +x ~/.config/hypr/scripts/toggle-opacity.sh

# Créer script wallpaper-random si pas présent
if [ ! -f ~/.config/hypr/scripts/wallpaper-random.sh ]; then
cat > ~/.config/hypr/scripts/wallpaper-random.sh << 'RANDWALL'
#!/bin/bash
WALLPAPER_DIR="$HOME/Pictures/Wallpapers"
wallpaper=$(find "$WALLPAPER_DIR" -type f \( -iname "*.png" -o -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.webp" \) 2>/dev/null | shuf -n 1)
if [ -n "$wallpaper" ]; then
    hyprctl hyprpaper preload "$wallpaper"
    hyprctl hyprpaper wallpaper ",$wallpaper"
fi
RANDWALL
chmod +x ~/.config/hypr/scripts/wallpaper-random.sh
fi

# Créer script wallpaper-select si pas présent
if [ ! -f ~/.config/hypr/scripts/wallpaper-select.sh ]; then
cat > ~/.config/hypr/scripts/wallpaper-select.sh << 'SELWALL'
#!/bin/bash
WALLPAPER_DIR="$HOME/Pictures/Wallpapers"
wallpaper=$(find "$WALLPAPER_DIR" -type f \( -iname "*.png" -o -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.webp" \) 2>/dev/null | wofi --dmenu --prompt "Wallpaper")
if [ -n "$wallpaper" ]; then
    hyprctl hyprpaper preload "$wallpaper"
    hyprctl hyprpaper wallpaper ",$wallpaper"
fi
SELWALL
chmod +x ~/.config/hypr/scripts/wallpaper-select.sh
fi

# Vérifier si keybinds.conf est sourcé dans hyprland.conf
if ! grep -q "source.*keybinds.conf" ~/.config/hypr/hyprland.conf 2>/dev/null; then
    echo "" >> ~/.config/hypr/hyprland.conf
    echo "# Keybinds" >> ~/.config/hypr/hyprland.conf
    echo "source = ~/.config/hypr/keybinds.conf" >> ~/.config/hypr/hyprland.conf
fi

# Reload Hyprland
hyprctl reload 2>/dev/null || true

echo ""
echo "✅ Keybinds Omarchy appliqués !"
echo ""
echo "📋 Raccourcis principaux:"
echo "   Super + Space       → Launcher"
echo "   Super + Return      → Terminal"
echo "   Super + W           → Fermer fenêtre"
echo "   Super + T           → Toggle floating"
echo "   Super + F           → Plein écran"
echo "   Super + Tab         → Workspace suivant"
echo "   Super + 1-9         → Workspaces"
echo "   Super + Shift + B   → Brave"
echo "   Super + Shift + F   → Nautilus"
echo "   Super + Escape      → Menu power"
echo "   Print               → Screenshot"
echo "   Super + Ctrl + Space → Wallpaper suivant"
echo ""
