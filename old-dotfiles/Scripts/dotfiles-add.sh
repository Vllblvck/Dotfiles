#!/bin/bash

dotfiles=(
    "Scripts/"
    "Pictures/wallpapers/"
    ".moc/"
    ".xmonad/"
    ".gtkrc-2.0"
    ".stalonetrayrc"
    ".xprofile"
    ".zshrc"
    ".config/alacritty/"
    ".config/calcurse/"
    ".config/cheat/"
    ".config/dunstrc"
    ".config/gtk-3.0/"
    ".config/nvim/"
    ".config/picom.conf"
    ".config/qutebrowser/"
    ".config/ranger"
    ".config/xmobar/"
)

git="/usr/bin/git --git-dir=$HOME/Projects/DotFiles/ --work-tree=$HOME"

for file in "${dotfiles[@]}"; do
    $git add "$file"
done
