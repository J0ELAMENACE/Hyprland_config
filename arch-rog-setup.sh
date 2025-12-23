#!/bin/bash

# ╔═╗┬─┐┌─┐┬ ┬  ╔═╗┌─┐┌┬┐┬ ┬┌─┐
# ╠═╣├┬┘│  ├─┤  ╚═╗├┤  │ │ │├─┘
# ╩ ╩┴└─└─┘┴ ┴  ╚═╝└─┘ ┴ └─┘┴  
# Script d'installation Arch - ROG Edition

set -e

GREEN='\033[0;32m'
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "${CYAN}"
echo "╔═══════════════════════════════════════════╗"
echo "║     Arch Linux - ROG Setup Script         ║"
echo "╚═══════════════════════════════════════════╝"
echo -e "${NC}"

# ============================================================
# YAY (AUR Helper)
# ============================================================
echo -e "${GREEN}[1/5]${NC} Installation de yay..."

if ! command -v yay &> /dev/null; then
    sudo pacman -S --needed --noconfirm base-devel git
    cd /tmp
    rm -rf yay-bin
    git clone https://aur.archlinux.org/yay-bin.git
    cd yay-bin
    makepkg -si --noconfirm
    cd ~
    echo -e "${GREEN}✓${NC} yay installé"
else
    echo -e "${GREEN}✓${NC} yay déjà installé"
fi

# ============================================================
# ASUS ROG Tools
# ============================================================
echo -e "${GREEN}[2/5]${NC} Installation outils ASUS ROG..."

yay -S --needed --noconfirm \
    asusctl \
    supergfxctl \
    rog-control-center

sudo systemctl enable --now supergfxd 2>/dev/null || true
sudo systemctl enable --now asusd 2>/dev/null || true

echo -e "${GREEN}✓${NC} Outils ASUS ROG installés"

# ============================================================
# Applications (Brave, Discord, Deezer)
# ============================================================
echo -e "${GREEN}[3/5]${NC} Installation applications...""

echo "  → Brave..."
yay -S --needed --noconfirm brave-bin

echo "  → Discord..."
yay -S --needed --noconfirm discord

echo "  → Deezer..."
yay -S --needed --noconfirm deezer

echo -e "${GREEN}✓${NC} Applications installées"

# ============================================================
# Remplacer Dolphin par Nautilus
# ============================================================
echo -e "${GREEN}[4/5]${NC} Remplacement Dolphin → Nautilus...""

# Supprimer Dolphin si installé
sudo pacman -Rns --noconfirm dolphin dolphin-plugins 2>/dev/null || true

# Installer Nautilus
sudo pacman -S --needed --noconfirm nautilus

echo -e "${GREEN}✓${NC} Nautilus installé"

# ============================================================
# Extras utiles
# ============================================================
echo -e "${GREEN}[5/5]${NC} Installation extras...""

sudo pacman -S --needed --noconfirm \
    pipewire \
    pipewire-pulse \
    pipewire-alsa \
    wireplumber \
    pavucontrol \
    bluez \
    bluez-utils \
    blueman \
    network-manager-applet \
    fastfetch \
    btop \
    grim \
    slurp \
    wl-clipboard

sudo systemctl enable --now bluetooth 2>/dev/null || true

echo -e "${GREEN}✓${NC} Extras installés"

# ============================================================
# Fin
# ============================================================
echo ""
echo -e "${CYAN}╔═══════════════════════════════════════════╗${NC}"
echo -e "${CYAN}║          Installation terminée !          ║${NC}"
echo -e "${CYAN}╚═══════════════════════════════════════════╝${NC}"
echo ""
echo -e "${GREEN}Installé:${NC}"
echo "  ✓ ASUS ROG (asusctl, supergfxctl, rog-control-center)"
echo "  ✓ Brave"
echo "  ✓ Discord"
echo "  ✓ Deezer"
echo "  ✓ Nautilus (Dolphin supprimé)"
echo "  ✓ Audio (Pipewire)"
echo "  ✓ Bluetooth"
echo ""
echo -e "${GREEN}C'est bon, tout est installé !${NC}"
