#!/bin/bash

# ╔═╗┬ ┬┌─┐┬─┐┬  ┌─┐┌┐┌┌┬┐  ╦┌┐┌┌─┐┌┬┐┌─┐┬  ┬  ┌─┐┬─┐
# ╠═╣│ │├─┘├┬┘│  ├─┤│││ ││  ║│││└─┐ │ ├─┤│  │  ├┤ ├┬┘
# ╩ ╩└─┘┴  ┴└─┴─┘┴ ┴┘└┘─┴┘  ╩┘└┘└─┘ ┴ ┴ ┴┴─┘┴─┘└─┘┴└─
# Script d'installation Hyprland pour EndeavourOS
# Optimisé pour ASUS ROG Flow avec RTX 4050

set -e

# Couleurs
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
NC='\033[0m'

print_header() {
    echo -e "\n${PURPLE}══════════════════════════════════════════════════════════${NC}"
    echo -e "${CYAN}  $1${NC}"
    echo -e "${PURPLE}══════════════════════════════════════════════════════════${NC}\n"
}

print_step() {
    echo -e "${GREEN}[+]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[!]${NC} $1"
}

print_error() {
    echo -e "${RED}[✗]${NC} $1"
}

# Vérification root
if [ "$EUID" -eq 0 ]; then
    print_error "Ne pas exécuter en root ! Utilise ton user normal."
    exit 1
fi

print_header "Installation Hyprland - ROG Flow Edition"

echo -e "${CYAN}Ce script va installer:${NC}"
echo "  • Drivers NVIDIA + ASUS tools"
echo "  • Hyprland + Waybar + Wofi"
echo "  • Kitty terminal"
echo "  • Brave browser + Deezer"
echo "  • Thème Catppuccin complet"
echo "  • SDDM avec thème Catppuccin"
echo "  • Tous les utilitaires nécessaires"
echo ""
read -p "Continuer ? (y/n) " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    exit 1
fi

# ============================================================
# ÉTAPE 1: Mise à jour système
# ============================================================
print_header "Étape 1/8 - Mise à jour système"

print_step "Mise à jour des paquets..."
sudo pacman -Syu --noconfirm

print_step "Installation des outils de base..."
sudo pacman -S --needed --noconfirm base-devel git wget curl unzip zip

# ============================================================
# ÉTAPE 2: Installation yay
# ============================================================
print_header "Étape 2/8 - Installation de yay (AUR helper)"

if ! command -v yay &> /dev/null; then
    print_step "Installation de yay..."
    cd /tmp
    rm -rf yay-bin
    git clone https://aur.archlinux.org/yay-bin.git
    cd yay-bin
    makepkg -si --noconfirm
    cd ~
else
    print_step "yay déjà installé ✓"
fi

# ============================================================
# ÉTAPE 3: Drivers NVIDIA + ASUS
# ============================================================
print_header "Étape 3/8 - Drivers NVIDIA & Outils ASUS"

print_step "Installation drivers NVIDIA..."
sudo pacman -S --needed --noconfirm \
    nvidia-dkms \
    nvidia-utils \
    lib32-nvidia-utils \
    nvidia-settings \
    linux-headers \
    egl-wayland \
    libva-nvidia-driver

print_step "Installation outils ASUS ROG..."
yay -S --needed --noconfirm \
    asusctl \
    supergfxctl \
    rog-control-center

print_step "Activation des services ASUS..."
sudo systemctl enable --now supergfxd 2>/dev/null || true
sudo systemctl enable --now asusd 2>/dev/null || true

print_step "Configuration NVIDIA pour Wayland..."
sudo tee /etc/modprobe.d/nvidia.conf > /dev/null << 'EOF'
options nvidia_drm modeset=1
options nvidia NVreg_PreserveVideoMemoryAllocations=1
EOF

print_step "Régénération initramfs..."
sudo mkinitcpio -P

# ============================================================
# ÉTAPE 4: Hyprland et composants
# ============================================================
print_header "Étape 4/8 - Hyprland & Composants"

print_step "Installation Hyprland et dépendances..."
sudo pacman -S --needed --noconfirm \
    hyprland \
    xdg-desktop-portal-hyprland \
    xdg-desktop-portal-gtk \
    polkit-kde-agent \
    qt5-wayland \
    qt6-wayland

print_step "Installation Waybar..."
sudo pacman -S --needed --noconfirm \
    waybar \
    otf-font-awesome

print_step "Installation Wofi & Wlogout..."
sudo pacman -S --needed --noconfirm wofi
yay -S --needed --noconfirm wlogout

print_step "Installation Kitty..."
sudo pacman -S --needed --noconfirm kitty

print_step "Installation utilitaires Hypr..."
sudo pacman -S --needed --noconfirm \
    hyprpaper \
    hyprlock \
    hypridle \
    hyprpicker

print_step "Installation gestionnaire de fichiers..."
sudo pacman -S --needed --noconfirm \
    thunar \
    thunar-archive-plugin \
    thunar-volman \
    tumbler \
    gvfs \
    gvfs-mtp

# ============================================================
# ÉTAPE 5: Audio, Réseau, Bluetooth
# ============================================================
print_header "Étape 5/8 - Audio, Réseau, Bluetooth"

print_step "Installation Pipewire..."
sudo pacman -S --needed --noconfirm \
    pipewire \
    pipewire-pulse \
    pipewire-alsa \
    wireplumber \
    pavucontrol

print_step "Installation Network Manager..."
sudo pacman -S --needed --noconfirm \
    networkmanager \
    network-manager-applet

print_step "Installation Bluetooth..."
sudo pacman -S --needed --noconfirm \
    bluez \
    bluez-utils \
    blueman

sudo systemctl enable --now bluetooth 2>/dev/null || true

print_step "Installation notifications..."
sudo pacman -S --needed --noconfirm \
    mako \
    libnotify

# ============================================================
# ÉTAPE 6: Utilitaires
# ============================================================
print_header "Étape 6/8 - Utilitaires"

print_step "Installation screenshots & clipboard..."
sudo pacman -S --needed --noconfirm \
    grim \
    slurp \
    swappy \
    wl-clipboard \
    cliphist

print_step "Installation contrôle luminosité..."
sudo pacman -S --needed --noconfirm brightnessctl

print_step "Installation fonts..."
sudo pacman -S --needed --noconfirm \
    ttf-jetbrains-mono-nerd \
    ttf-firacode-nerd \
    noto-fonts \
    noto-fonts-emoji \
    ttf-font-awesome

print_step "Installation outils divers..."
sudo pacman -S --needed --noconfirm \
    fastfetch \
    btop \
    htop \
    nvtop \
    playerctl \
    xorg-xwayland \
    wf-recorder

# ============================================================
# ÉTAPE 7: Thèmes
# ============================================================
print_header "Étape 7/8 - Thèmes Catppuccin"

print_step "Installation thème GTK Catppuccin..."
yay -S --needed --noconfirm catppuccin-gtk-theme-mocha

print_step "Installation icônes Papirus..."
sudo pacman -S --needed --noconfirm papirus-icon-theme

print_step "Installation curseurs Catppuccin..."
yay -S --needed --noconfirm catppuccin-cursors-mocha

print_step "Installation Qt theming..."
sudo pacman -S --needed --noconfirm qt5ct qt6ct kvantum
yay -S --needed --noconfirm kvantum-theme-catppuccin-git || true

# ============================================================
# ÉTAPE 8: Display Manager (SDDM avec thème)
# ============================================================
print_header "Étape 8/8 - Display Manager (SDDM)"

print_step "Installation SDDM..."
sudo pacman -S --needed --noconfirm sddm qt5-graphicaleffects qt5-quickcontrols2 qt5-svg

print_step "Installation thème SDDM Catppuccin..."
yay -S --needed --noconfirm sddm-theme-catppuccin

# Configuration SDDM
print_step "Configuration du thème SDDM..."
sudo mkdir -p /etc/sddm.conf.d
sudo tee /etc/sddm.conf.d/theme.conf > /dev/null << 'SDDMEOF'
[Theme]
Current=catppuccin-mocha
CursorTheme=catppuccin-mocha-dark-cursors
CursorSize=24

[General]
InputMethod=

[Users]
MaximumUid=60513
MinimumUid=1000
SDDMEOF

print_step "Activation SDDM..."
sudo systemctl enable sddm

# ============================================================
# ÉTAPE 9: Applications
# ============================================================
print_header "Étape 9 - Applications (Brave, Deezer)"

print_step "Installation Brave..."
yay -S --needed --noconfirm brave-bin

print_step "Installation Deezer..."
yay -S --needed --noconfirm deezer

# ============================================================
# FIN
# ============================================================
print_header "Installation des paquets terminée !"

echo -e "${GREEN}✓${NC} Tous les paquets sont installés"
echo ""
echo -e "${YELLOW}Prochaines étapes:${NC}"
echo "  1. Exécute ${CYAN}./setup-configs.sh${NC} pour créer les fichiers de config"
echo "  2. Reboot ton système"
echo "  3. SDDM se lancera et tu pourras choisir Hyprland"
echo ""
print_warning "Un reboot est nécessaire pour activer les drivers NVIDIA !"
echo ""
read -p "Lancer le script de configuration maintenant ? (y/n) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    chmod +x ~/setup-configs.sh 2>/dev/null || true
    ~/setup-configs.sh
fi
