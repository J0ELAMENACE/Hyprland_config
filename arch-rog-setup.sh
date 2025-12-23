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
echo -e "${GREEN}[1/6]${NC} Installation de yay..."

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
# NVIDIA Drivers
# ============================================================
echo -e "${GREEN}[2/6]${NC} Installation drivers NVIDIA..."

sudo pacman -S --needed --noconfirm \
    nvidia-dkms \
    nvidia-utils \
    lib32-nvidia-utils \
    nvidia-settings \
    linux-headers \
    egl-wayland \
    libva-nvidia-driver

# Config NVIDIA pour Wayland
sudo tee /etc/modprobe.d/nvidia.conf > /dev/null << 'EOF'
options nvidia_drm modeset=1
options nvidia NVreg_PreserveVideoMemoryAllocations=1
EOF

echo -e "${GREEN}✓${NC} Drivers NVIDIA installés"

# ============================================================
# ASUS ROG Tools
# ============================================================
echo -e "${GREEN}[3/6]${NC} Installation outils ASUS ROG..."

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
echo -e "${GREEN}[4/6]${NC} Installation applications..."

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
echo -e "${GREEN}[5/6]${NC} Remplacement Dolphin → Nautilus..."

# Supprimer Dolphin si installé
sudo pacman -Rns --noconfirm dolphin dolphin-plugins 2>/dev/null || true

# Installer Nautilus
sudo pacman -S --needed --noconfirm nautilus

echo -e "${GREEN}✓${NC} Nautilus installé"

# ============================================================
# Extras utiles
# ============================================================
echo -e "${GREEN}[6/6]${NC} Installation extras..."

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
# Régénérer initramfs
# ============================================================
echo -e "${YELLOW}[*]${NC} Régénération initramfs..."
sudo mkinitcpio -P

# ============================================================
# Fin
# ============================================================
echo ""
echo -e "${CYAN}╔═══════════════════════════════════════════╗${NC}"
echo -e "${CYAN}║          Installation terminée !          ║${NC}"
echo -e "${CYAN}╚═══════════════════════════════════════════╝${NC}"
echo ""
echo -e "${GREEN}Installé:${NC}"
echo "  ✓ Drivers NVIDIA"
echo "  ✓ ASUS ROG (asusctl, supergfxctl, rog-control-center)"
echo "  ✓ Brave"
echo "  ✓ Discord"
echo "  ✓ Deezer"
echo "  ✓ Nautilus (Dolphin supprimé)"
echo "  ✓ Audio (Pipewire)"
echo "  ✓ Bluetooth"
echo ""
echo -e "${YELLOW}⚠ Reboot recommandé pour activer les drivers NVIDIA${NC}"
echo ""
read -p "Reboot maintenant ? (y/n) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    sudo reboot
fi
