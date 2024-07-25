#!/bin/bash

WALLPAPERS_DIR=~/vault/assets/wallpapers

random_wallpaper=$( find "$WALLPAPERS_DIR" | shuf -n 1 )

swaybg -m fill -i "$random_wallpaper"
