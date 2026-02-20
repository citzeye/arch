#!/bin/bash

THEME_NAME="Bibata-Modern-Ice"
SOURCE_DIR="$(pwd)/$THEME_NAME"
TARGET_DIR="$HOME/.icons/$THEME_NAME"
TARGET_DEFAULT="$HOME/.icons/default"

if [ ! -d "$SOURCE_DIR" ]; then
    exit 1
fi

if [ "$1" == "install" ]; then
    mkdir -p "$HOME/.icons"
    rm -rf "$TARGET_DIR"
    cp -r "$SOURCE_DIR" "$TARGET_DIR"
    
    mkdir -p "$TARGET_DEFAULT"
    echo "[Icon Theme]" > "$TARGET_DEFAULT/index.theme"
    echo "Inherits=$THEME_NAME" >> "$TARGET_DEFAULT/index.theme"
else
    mkdir -p "$HOME/.icons"
    rm -rf "$TARGET_DIR"
    ln -s "$SOURCE_DIR" "$TARGET_DIR"
fi
