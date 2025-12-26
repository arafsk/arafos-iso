#!/usr/bin/env bash

bash xdg-user-dirs-update
bash xdg-user-dirs-gtk-update

## Start Compositing Manager
#exec picom & --config ~/.config/picom/picom-cachyos.conf &

## Launch Polybar or Tint2
#bash ~/.config/themes/launch-bar.sh

## Thunar Daemon
exec thunar --daemon &

## User Friendly Network Menu
nm-applet --indicator &

# sxhkd
# (re)load sxhkd for keybinds
if hash sxhkd >/dev/null 2>&1; then
	pkill sxhkd
	sleep 0.5
	sxhkd -c "$HOME/.config/sxhkd/sxhkdrc" &
fi

## User Friendly Bluetooth Menu
#blueman-applet &

## Monitor Layout
bash ~/.screenlayout/xrandr.sh
