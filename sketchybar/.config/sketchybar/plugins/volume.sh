#!/bin/bash

VOLUME=$(osascript -e "output volume of (get volume settings)")
MUTED=$(osascript -e "output muted of (get volume settings)")

# Define Nerd Font icons for different volume levels
if [[ "$MUTED" == "true" || "$VOLUME" -eq 0 ]]; then
  ICON="󰝟"  # Muted
elif [[ "$VOLUME" -lt 30 ]]; then
  ICON="󰕿"  # Low volume
elif [[ "$VOLUME" -lt 70 ]]; then
  ICON="󰖀"  # Medium volume
else
  ICON="󰕾"  # High volume
fi

# Update SketchyBar item with new icon and volume percentage
sketchybar --set "$NAME" label="$ICON $VOLUME%"
