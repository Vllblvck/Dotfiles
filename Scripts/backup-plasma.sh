#!/bin/bash

if [ "$EUID" = 0 ]; then
  echo -e "\n Do not run this script as root!\n";
  exit;
fi

if [ ! -d "$HOME" ]; then
  echo -e "\n Directory $HOME does not exist\n";
  exit;
fi

BACKUP_DIR_PATH="$HOME"/"dotfiles-compressed"
BACKUP_DIR_NAME="plasma-configs"

if [ -n "$1" ]; then
  BACKUP_DIR_NAME="$1"
fi

mkdir -p "$BACKUP_DIR_PATH"/"$BACKUP_DIR_NAME";
mkdir -p "$BACKUP_DIR_PATH"/"$BACKUP_DIR_NAME"/.config;
mkdir -p "$BACKUP_DIR_PATH"/"$BACKUP_DIR_NAME"/.kde;
mkdir -p "$BACKUP_DIR_PATH"/"$BACKUP_DIR_NAME"/.kde4;
mkdir -p "$BACKUP_DIR_PATH"/"$BACKUP_DIR_NAME"/.local/share;

rsync -rltD --ignore-missing-args "$HOME"/.config/auroraerc "$BACKUP_DIR_PATH"/"$BACKUP_DIR_NAME"/.config/;
rsync -rltD --ignore-missing-args "$HOME"/.config/autostart-scripts "$BACKUP_DIR_PATH"/"$BACKUP_DIR_NAME"/.config/;
rsync -rltD --ignore-missing-args "$HOME"/.config/autostart "$BACKUP_DIR_PATH"/"$BACKUP_DIR_NAME"/.config/;
rsync -rltD --ignore-missing-args "$HOME"/.config/breezerc "$BACKUP_DIR_PATH"/"$BACKUP_DIR_NAME"/.config/;
rsync -rltD --ignore-missing-args "$HOME"/.config/dolphinrc "$BACKUP_DIR_PATH"/"$BACKUP_DIR_NAME"/.config/;
rsync -rltD --ignore-missing-args "$HOME"/.config/gtk-3.0 "$BACKUP_DIR_PATH"/"$BACKUP_DIR_NAME"/.config/;
rsync -rltD --ignore-missing-args "$HOME"/.config/katemetainfos "$BACKUP_DIR_PATH"/"$BACKUP_DIR_NAME"/.config/;
rsync -rltD --ignore-missing-args "$HOME"/.config/katerc "$BACKUP_DIR_PATH"/"$BACKUP_DIR_NAME"/.config/;
rsync -rltD --ignore-missing-args "$HOME"/.config/kateschemarc "$BACKUP_DIR_PATH"/"$BACKUP_DIR_NAME"/.config/;
rsync -rltD --ignore-missing-args "$HOME"/.config/katevirc "$BACKUP_DIR_PATH"/"$BACKUP_DIR_NAME"/.config/;
rsync -rltD --ignore-missing-args "$HOME"/.config/kde.org "$BACKUP_DIR_PATH"/"$BACKUP_DIR_NAME"/.config/;
rsync -rltD --ignore-missing-args "$HOME"/.config/kdeconnect "$BACKUP_DIR_PATH"/"$BACKUP_DIR_NAME"/.config/;
rsync -rltD --ignore-missing-args "$HOME"/.config/kdeglobals "$BACKUP_DIR_PATH"/"$BACKUP_DIR_NAME"/.config/;
rsync -rltD --ignore-missing-args "$HOME"/.config/kglobalshortcutsrc "$BACKUP_DIR_PATH"/"$BACKUP_DIR_NAME"/.config/;
rsync -rltD --ignore-missing-args "$HOME"/.config/khotkeysrc "$BACKUP_DIR_PATH"/"$BACKUP_DIR_NAME"/.config/;
rsync -rltD --ignore-missing-args "$HOME"/.config/konsolerc "$BACKUP_DIR_PATH"/"$BACKUP_DIR_NAME"/.config/;
rsync -rltD --ignore-missing-args "$HOME"/.config/kscreenlockerrc "$BACKUP_DIR_PATH"/"$BACKUP_DIR_NAME"/.config/;
rsync -rltD --ignore-missing-args "$HOME"/.config/ksplashrc "$BACKUP_DIR_PATH"/"$BACKUP_DIR_NAME"/.config/;
rsync -rltD --ignore-missing-args "$HOME"/.config/Kvantum "$BACKUP_DIR_PATH"/"$BACKUP_DIR_NAME"/.config/;
rsync -rltD --ignore-missing-args "$HOME"/.config/kwinrc "$BACKUP_DIR_PATH"/"$BACKUP_DIR_NAME"/.config/;
rsync -rltD --ignore-missing-args "$HOME"/.config/kwinrulesrc "$BACKUP_DIR_PATH"/"$BACKUP_DIR_NAME"/.config/;
rsync -rltD --ignore-missing-args "$HOME"/.config/latte "$BACKUP_DIR_PATH"/"$BACKUP_DIR_NAME"/.config/;
rsync -rltD --ignore-missing-args "$HOME"/.config/lattedockrc "$BACKUP_DIR_PATH"/"$BACKUP_DIR_NAME"/.config/;
rsync -rltD --ignore-missing-args "$HOME"/.config/plasma-org.kde.plasma.desktop-appletsrc "$BACKUP_DIR_PATH"/"$BACKUP_DIR_NAME"/.config/;
rsync -rltD --ignore-missing-args "$HOME"/.config/plasma-workspace "$BACKUP_DIR_PATH"/"$BACKUP_DIR_NAME"/.config/;
rsync -rltD --ignore-missing-args "$HOME"/.config/plasma_calendar_holiday_regions "$BACKUP_DIR_PATH"/"$BACKUP_DIR_NAME"/.config/;
rsync -rltD --ignore-missing-args "$HOME"/.config/plasmarc "$BACKUP_DIR_PATH"/"$BACKUP_DIR_NAME"/.config/;
rsync -rltD --ignore-missing-args "$HOME"/.config/plasmashellrc "$BACKUP_DIR_PATH"/"$BACKUP_DIR_NAME"/.config/;
rsync -rltD --ignore-missing-args "$HOME"/.config/powermanagementprofilesrc "$BACKUP_DIR_PATH"/"$BACKUP_DIR_NAME"/.config/;
rsync -rltD --ignore-missing-args "$HOME"/.config/pulse/*.conf "$BACKUP_DIR_PATH"/"$BACKUP_DIR_NAME"/.config/pulse/;
rsync -rltD --ignore-missing-args "$HOME"/.config/qtcurve "$BACKUP_DIR_PATH"/"$BACKUP_DIR_NAME"/.config/;
rsync -rltD --ignore-missing-args "$HOME"/.config/Trolltech.conf "$BACKUP_DIR_PATH"/"$BACKUP_DIR_NAME"/.config/;
rsync -rltD --ignore-missing-args "$HOME"/.gtkrc-2.0 "$BACKUP_DIR_PATH"/"$BACKUP_DIR_NAME"/;
rsync -rltD --ignore-missing-args "$HOME"/.kde "$BACKUP_DIR_PATH"/"$BACKUP_DIR_NAME"/;
rsync -rltD --ignore-missing-args "$HOME"/.kde4 "$BACKUP_DIR_PATH"/"$BACKUP_DIR_NAME"/;
rsync -rltD --ignore-missing-args "$HOME"/.local/share/aurorae "$BACKUP_DIR_PATH"/"$BACKUP_DIR_NAME"/.local/share/;
rsync -rltD --ignore-missing-args "$HOME"/.local/share/color-schemes "$BACKUP_DIR_PATH"/"$BACKUP_DIR_NAME"/.local/share/;
rsync -rltD --ignore-missing-args "$HOME"/.local/share/kate "$BACKUP_DIR_PATH"/"$BACKUP_DIR_NAME"/.local/share/;
rsync -rltD --ignore-missing-args "$HOME"/.local/share/konsole "$BACKUP_DIR_PATH"/"$BACKUP_DIR_NAME"/.local/share/;
rsync -rltD --ignore-missing-args "$HOME"/.local/share/kservices5 "$BACKUP_DIR_PATH"/"$BACKUP_DIR_NAME"/.local/share/;
rsync -rltD --ignore-missing-args "$HOME"/.local/share/kxmlgui5/ "$BACKUP_DIR_PATH"/"$BACKUP_DIR_NAME"/.local/share/;
rsync -rltD --ignore-missing-args "$HOME"/.local/share/plasma "$BACKUP_DIR_PATH"/"$BACKUP_DIR_NAME"/.local/share/;
rsync -rltD --ignore-missing-args "$HOME"/.local/share/plasma_icons "$BACKUP_DIR_PATH"/"$BACKUP_DIR_NAME"/.local/share/;
rsync -rltD --ignore-missing-args "$HOME"/.local/share/icons "$BACKUP_DIR_PATH"/"$BACKUP_DIR_NAME"/.local/share/;
rsync -rltD --ignore-missing-args "$HOME"/.local/share/wallpapers "$BACKUP_DIR_PATH"/"$BACKUP_DIR_NAME"/.local/share/;

tar -C "$BACKUP_DIR_PATH"/"$BACKUP_DIR_NAME" -czvf "$BACKUP_DIR_PATH"/"$BACKUP_DIR_NAME".tar.gz .

rm -rf "$BACKUP_DIR_PATH"/"$BACKUP_DIR_NAME"
