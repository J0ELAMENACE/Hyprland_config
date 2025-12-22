#!/bin/bash

# ╦ ╦┌─┐┬  ┬  ┌─┐┌─┐┌─┐┌─┐┬─┐┌─┐  ╔╦╗┌─┐┬ ┬┌┐┌┬  ┌─┐┌─┐┌┬┐┌─┐┬─┐
# ║║║├─┤│  │  ├─┘├─┤├─┘├┤ ├┬┘└─┐   ║║│ │││││││││  │ │├─┤ ││├┤ ├┬┘
# ╚╩╝┴ ┴┴─┘┴─┘┴  ┴ ┴┴  └─┘┴└─└─┘  ═╩╝└─┘└┴┘┘└┘┴─┘└─┘┴ ┴─┴┘└─┘┴└─
# Collection de wallpapers pour Hyprland
# Omarchy + Catppuccin + Nordic + CozyPixels + OneDark

set -e

# Couleurs
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
NC='\033[0m'

WALLPAPER_DIR="$HOME/Pictures/Wallpapers"

print_header() {
    echo -e "\n${PURPLE}══════════════════════════════════════════════════════════${NC}"
    echo -e "${CYAN}  $1${NC}"
    echo -e "${PURPLE}══════════════════════════════════════════════════════════${NC}\n"
}

print_step() {
    echo -e "${GREEN}[+]${NC} $1"
}

print_info() {
    echo -e "${BLUE}[i]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[!]${NC} $1"
}

count_files() {
    local dir=$1
    if [ -d "$dir" ]; then
        find "$dir" -type f \( -iname "*.png" -o -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.webp" \) | wc -l
    else
        echo "0"
    fi
}

# ============================================================
print_header "Wallpaper Downloader - Mega Collection"

echo -e "${CYAN}Collections disponibles:${NC}"
echo "  1. Omarchy Themes (tokyo-night, catppuccin, nord, everforest, gruvbox, kanagawa)"
echo "  2. Catppuccin Wallpapers (orangci collection - 1500+ walls)"
echo "  3. Nordic Wallpapers (nord colorscheme)"
echo "  4. CozyPixels (aesthetic collection multi-themes)"
echo "  5. OneDark Wallpapers"
echo "  6. Catppuccin Archive (white-spaced)"
echo ""
echo "  A. TOUT télécharger (recommandé)"
echo "  Q. Quitter"
echo ""

read -p "Choix [A/1-6/Q]: " choice

# Créer le dossier principal
mkdir -p "$WALLPAPER_DIR"
cd "$WALLPAPER_DIR"

# ============================================================
# Fonction: Omarchy Themes
# ============================================================
download_omarchy() {
    print_header "Téléchargement Omarchy Themes"
    
    local omarchy_dir="$WALLPAPER_DIR/Omarchy"
    mkdir -p "$omarchy_dir"
    cd "$omarchy_dir"
    
    print_step "Clonage du repo Omarchy (sparse checkout pour les backgrounds)..."
    
    if [ -d "omarchy-repo" ]; then
        rm -rf omarchy-repo
    fi
    
    git clone --depth 1 --filter=blob:none --sparse https://github.com/basecamp/omarchy.git omarchy-repo 2>/dev/null || {
        print_warning "Clone complet..."
        git clone --depth 1 https://github.com/basecamp/omarchy.git omarchy-repo
    }
    
    cd omarchy-repo
    git sparse-checkout set themes 2>/dev/null || true
    
    # Extraire les backgrounds de chaque thème
    print_step "Extraction des wallpapers par thème..."
    
    for theme in tokyo-night catppuccin nord everforest gruvbox kanagawa; do
        if [ -d "themes/$theme/backgrounds" ]; then
            mkdir -p "$omarchy_dir/$theme"
            cp -r themes/$theme/backgrounds/* "$omarchy_dir/$theme/" 2>/dev/null || true
            local count=$(count_files "$omarchy_dir/$theme")
            print_info "  $theme: $count wallpapers"
        fi
    done
    
    # Nettoyage
    cd "$omarchy_dir"
    rm -rf omarchy-repo
    
    local total=$(count_files "$omarchy_dir")
    print_step "Omarchy terminé: $total wallpapers"
}

# ============================================================
# Fonction: Catppuccin Mocha (orangci - grande collection)
# ============================================================
download_catppuccin_orangci() {
    print_header "Téléchargement Catppuccin (orangci collection)"
    
    local cat_dir="$WALLPAPER_DIR/Catppuccin-Mocha"
    mkdir -p "$cat_dir"
    cd "$cat_dir"
    
    print_step "Clonage de la collection orangci (1500+ wallpapers)..."
    print_warning "Cette collection est volumineuse, patience..."
    
    if [ -d "walls-repo" ]; then
        rm -rf walls-repo
    fi
    
    git clone --depth 1 https://github.com/orangci/walls-catppuccin-mocha.git walls-repo 2>/dev/null || {
        print_warning "Erreur de clonage, tentative alternative..."
        return 1
    }
    
    # Déplacer les images
    find walls-repo -type f \( -iname "*.png" -o -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.webp" \) -exec mv {} "$cat_dir/" \; 2>/dev/null || true
    
    rm -rf walls-repo
    
    local total=$(count_files "$cat_dir")
    print_step "Catppuccin orangci terminé: $total wallpapers"
}

# ============================================================
# Fonction: Nordic Wallpapers
# ============================================================
download_nordic() {
    print_header "Téléchargement Nordic Wallpapers"
    
    local nordic_dir="$WALLPAPER_DIR/Nordic"
    mkdir -p "$nordic_dir"
    cd "$nordic_dir"
    
    print_step "Clonage de la collection Nordic..."
    
    if [ -d "nordic-repo" ]; then
        rm -rf nordic-repo
    fi
    
    git clone --depth 1 https://github.com/linuxdotexe/nordic-wallpapers.git nordic-repo 2>/dev/null || {
        print_warning "Erreur de clonage Nordic"
        return 1
    }
    
    # Déplacer les images
    find nordic-repo/wallpapers -type f \( -iname "*.png" -o -iname "*.jpg" -o -iname "*.jpeg" \) -exec mv {} "$nordic_dir/" \; 2>/dev/null || true
    
    rm -rf nordic-repo
    
    local total=$(count_files "$nordic_dir")
    print_step "Nordic terminé: $total wallpapers"
}

# ============================================================
# Fonction: CozyPixels (multi-themes)
# ============================================================
download_cozypixels() {
    print_header "Téléchargement CozyPixels Collection"
    
    local cozy_dir="$WALLPAPER_DIR/CozyPixels"
    mkdir -p "$cozy_dir"
    cd "$cozy_dir"
    
    print_step "Clonage de CozyPixels (multi-themes aesthetic)..."
    
    if [ -d "cozy-repo" ]; then
        rm -rf cozy-repo
    fi
    
    git clone --depth 1 https://github.com/SleepyCatHey/CozyPixels.git cozy-repo 2>/dev/null || {
        print_warning "Erreur de clonage CozyPixels"
        return 1
    }
    
    # Garder la structure par catégorie
    for category in Catppuccin Nord Dracula "One Dark" Cozy Minimal; do
        if [ -d "cozy-repo/$category" ]; then
            mkdir -p "$cozy_dir/$category"
            find "cozy-repo/$category" -type f \( -iname "*.png" -o -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.webp" \) -exec cp {} "$cozy_dir/$category/" \; 2>/dev/null || true
            local count=$(count_files "$cozy_dir/$category")
            print_info "  $category: $count wallpapers"
        fi
    done
    
    rm -rf cozy-repo
    
    local total=$(count_files "$cozy_dir")
    print_step "CozyPixels terminé: $total wallpapers"
}

# ============================================================
# Fonction: OneDark Wallpapers
# ============================================================
download_onedark() {
    print_header "Téléchargement OneDark Wallpapers"
    
    local onedark_dir="$WALLPAPER_DIR/OneDark"
    mkdir -p "$onedark_dir"
    cd "$onedark_dir"
    
    print_step "Clonage de la collection OneDark..."
    
    if [ -d "onedark-repo" ]; then
        rm -rf onedark-repo
    fi
    
    git clone --depth 1 https://github.com/Narmis-E/onedark-wallpapers.git onedark-repo 2>/dev/null || {
        print_warning "Erreur de clonage OneDark"
        return 1
    }
    
    # Déplacer les images
    find onedark-repo/wallpapers -type f \( -iname "*.png" -o -iname "*.jpg" -o -iname "*.jpeg" \) -exec mv {} "$onedark_dir/" \; 2>/dev/null || true
    
    rm -rf onedark-repo
    
    local total=$(count_files "$onedark_dir")
    print_step "OneDark terminé: $total wallpapers"
}

# ============================================================
# Fonction: Catppuccin Archive (white-spaced)
# ============================================================
download_catppuccin_archive() {
    print_header "Téléchargement Catppuccin Archive"
    
    local archive_dir="$WALLPAPER_DIR/Catppuccin-Archive"
    mkdir -p "$archive_dir"
    cd "$archive_dir"
    
    print_step "Clonage de l'archive Catppuccin..."
    
    if [ -d "cat-archive-repo" ]; then
        rm -rf cat-archive-repo
    fi
    
    git clone --depth 1 https://github.com/white-spaced/catppuccin-wallpapers.git cat-archive-repo 2>/dev/null || {
        print_warning "Erreur de clonage Catppuccin Archive"
        return 1
    }
    
    # Déplacer les images
    find cat-archive-repo -type f \( -iname "*.png" -o -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.webp" \) -exec mv {} "$archive_dir/" \; 2>/dev/null || true
    
    rm -rf cat-archive-repo
    
    local total=$(count_files "$archive_dir")
    print_step "Catppuccin Archive terminé: $total wallpapers"
}

# ============================================================
# Fonction: Télécharger quelques wallpapers populaires additionnels
# ============================================================
download_extras() {
    print_header "Téléchargement Extras (wallpapers populaires)"
    
    local extras_dir="$WALLPAPER_DIR/Extras"
    mkdir -p "$extras_dir"
    cd "$extras_dir"
    
    print_step "Téléchargement de wallpapers populaires..."
    
    # Catppuccin officiels (quelques-uns)
    curl -sL -o "catppuccin-evening-sky.png" \
        "https://raw.githubusercontent.com/catppuccin/wallpapers/main/landscapes/evening-sky.png" 2>/dev/null || true
    
    curl -sL -o "catppuccin-tropic-sunset.png" \
        "https://raw.githubusercontent.com/catppuccin/wallpapers/main/landscapes/Tropic%20Sunset%20Catppuccin.png" 2>/dev/null || true
    
    curl -sL -o "catppuccin-cat-leaves.png" \
        "https://raw.githubusercontent.com/catppuccin/wallpapers/main/misc/cat-leaves.png" 2>/dev/null || true
    
    local total=$(count_files "$extras_dir")
    print_step "Extras terminé: $total wallpapers"
}

# ============================================================
# Créer un script de changement de wallpaper
# ============================================================
create_wallpaper_script() {
    print_step "Création du script de changement de wallpaper..."
    
    cat > "$HOME/.config/hypr/scripts/wallpaper-select.sh" << 'WALLSCRIPT'
#!/bin/bash
# Sélecteur de wallpaper avec Wofi

WALLPAPER_DIR="$HOME/Pictures/Wallpapers"

# Trouver tous les wallpapers
wallpaper=$(find "$WALLPAPER_DIR" -type f \( -iname "*.png" -o -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.webp" \) | \
    sort | \
    wofi --dmenu --prompt "Wallpaper" --cache-file /dev/null)

if [ -n "$wallpaper" ]; then
    # Mettre à jour hyprpaper
    echo "preload = $wallpaper" > ~/.config/hypr/hyprpaper.conf
    echo "wallpaper = ,$wallpaper" >> ~/.config/hypr/hyprpaper.conf
    echo "splash = false" >> ~/.config/hypr/hyprpaper.conf
    
    # Mettre à jour hyprlock
    sed -i "s|path = .*|path = $wallpaper|g" ~/.config/hypr/hyprlock.conf 2>/dev/null || true
    
    # Recharger hyprpaper
    pkill hyprpaper
    hyprpaper &
    
    notify-send "Wallpaper" "Changé avec succès!" -i preferences-desktop-wallpaper
fi
WALLSCRIPT

    chmod +x "$HOME/.config/hypr/scripts/wallpaper-select.sh"
    
    # Script pour wallpaper aléatoire
    cat > "$HOME/.config/hypr/scripts/wallpaper-random.sh" << 'RANDSCRIPT'
#!/bin/bash
# Wallpaper aléatoire

WALLPAPER_DIR="$HOME/Pictures/Wallpapers"

wallpaper=$(find "$WALLPAPER_DIR" -type f \( -iname "*.png" -o -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.webp" \) | shuf -n 1)

if [ -n "$wallpaper" ]; then
    echo "preload = $wallpaper" > ~/.config/hypr/hyprpaper.conf
    echo "wallpaper = ,$wallpaper" >> ~/.config/hypr/hyprpaper.conf
    echo "splash = false" >> ~/.config/hypr/hyprpaper.conf
    
    sed -i "s|path = .*|path = $wallpaper|g" ~/.config/hypr/hyprlock.conf 2>/dev/null || true
    
    pkill hyprpaper
    hyprpaper &
fi
RANDSCRIPT

    chmod +x "$HOME/.config/hypr/scripts/wallpaper-random.sh"
    
    print_info "Scripts créés:"
    print_info "  ~/.config/hypr/scripts/wallpaper-select.sh (sélection avec Wofi)"
    print_info "  ~/.config/hypr/scripts/wallpaper-random.sh (wallpaper aléatoire)"
    echo ""
    print_info "Ajoute ces keybinds dans ~/.config/hypr/keybinds.conf:"
    echo -e "${CYAN}bind = \$mainMod, W, exec, ~/.config/hypr/scripts/wallpaper-select.sh${NC}"
    echo -e "${CYAN}bind = \$mainMod SHIFT, W, exec, ~/.config/hypr/scripts/wallpaper-random.sh${NC}"
}

# ============================================================
# Exécution selon le choix
# ============================================================

case "$choice" in
    1)
        download_omarchy
        ;;
    2)
        download_catppuccin_orangci
        ;;
    3)
        download_nordic
        ;;
    4)
        download_cozypixels
        ;;
    5)
        download_onedark
        ;;
    6)
        download_catppuccin_archive
        ;;
    [Aa])
        download_omarchy
        download_catppuccin_orangci
        download_nordic
        download_cozypixels
        download_onedark
        download_catppuccin_archive
        download_extras
        ;;
    [Qq])
        echo "Annulé."
        exit 0
        ;;
    *)
        echo "Choix invalide."
        exit 1
        ;;
esac

# Créer les scripts utilitaires
mkdir -p "$HOME/.config/hypr/scripts"
create_wallpaper_script

# ============================================================
# Résumé final
# ============================================================
print_header "Téléchargement terminé !"

echo -e "${CYAN}Résumé des collections:${NC}"
echo ""

for dir in "$WALLPAPER_DIR"/*/; do
    if [ -d "$dir" ]; then
        dirname=$(basename "$dir")
        count=$(count_files "$dir")
        printf "  %-25s %s wallpapers\n" "$dirname:" "$count"
    fi
done

echo ""
total=$(count_files "$WALLPAPER_DIR")
echo -e "${GREEN}Total: $total wallpapers${NC}"
echo ""
echo -e "${CYAN}Emplacement: $WALLPAPER_DIR${NC}"
echo ""
echo -e "${YELLOW}Raccourcis suggérés (ajoute dans keybinds.conf):${NC}"
echo '  bind = $mainMod, W, exec, ~/.config/hypr/scripts/wallpaper-select.sh'
echo '  bind = $mainMod SHIFT, W, exec, ~/.config/hypr/scripts/wallpaper-random.sh'
echo ""
print_step "Profite de tes nouveaux wallpapers ! 🎨"
