# Hyprland Config

Scripts d'installation et de configuration d'Hyprland sur Arch Linux.

> **Hardware cible** : ASUS ROG Flow Z13 avec GPU NVIDIA RTX 4050. Les scripts peuvent nécessiter des adaptations pour d'autres configurations.

---

## Prérequis

- Arch Linux (ou dérivé) avec `yay` installé
- Connexion internet active
- Droits sudo

---

## Ordre d'exécution recommandé

```bash
# 1. Installation de base Hyprland
bash install-hyprland.sh

# 2. Configuration de l'environnement ROG
bash arch-rog-setup.sh

# 3. Keybinds Omarchy
bash omarchy-keybinds.sh

# 4. Configs dotfiles
bash setup-configs.sh

# 5. Wallpapers (optionnel)
bash download-wallpapers.sh
```

---

## Scripts

| Script | Description |
|---|---|
| `install-hyprland.sh` | Installation complète d'Hyprland et ses dépendances |
| `arch-rog-setup.sh` | Configuration spécifique ASUS ROG (ventilateur, RGB, GPU) |
| `omarchy-keybinds.sh` | Keybinds inspirés d'Omarchy |
| `setup-configs.sh` | Copie des dotfiles de configuration |
| `download-wallpapers.sh` | Téléchargement de fonds d'écran |

---

## Licence

MIT — voir [LICENSE](./LICENSE).
