#!/bin/bash

# Autostart applications

## Status bar
pkill -x waybar
waybar -c $HOME/.config/sway/waybar/config.jsonc -s $HOME/.config/sway/waybar/style.css &
