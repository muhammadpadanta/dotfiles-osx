#!/usr/bin/env bash

# Ensure colors are sourced correctly
if [ -f "$CONFIG_DIR/colors.sh" ]; then
  source "$CONFIG_DIR/colors.sh"
else
  echo "Error: colors.sh not found"
  exit 1
fi

# Get battery percentage
PERCENTAGE="$(pmset -g batt | grep -Eo "[0-9]+%" | cut -d% -f1)"
CHARGING="$(pmset -g batt | grep 'AC Power')"

# Exit if no percentage found
if [ -z "$PERCENTAGE" ]; then
  exit 0
fi

# Assign color and icon based on battery level
if [ "$PERCENTAGE" -ge 90 ]; then
  ICON=""  # Full battery
  COLOR=$GREEN
  BACKGROUND=$SELECTION

elif [ "$PERCENTAGE" -ge 60 ]; then
  ICON=""  # 60-89%
  COLOR=$GREEN
  BACKGROUND=$SELECTION

elif [ "$PERCENTAGE" -ge 30 ]; then
  ICON=""  # 30-59%
  COLOR=$YELLOW
  BACKGROUND=$SELECTION

elif [ "$PERCENTAGE" -ge 10 ]; then
  ICON=""  # 10-29%
  COLOR=$RED
  BACKGROUND=$SELECTION

else
  ICON=""  # Critical
  COLOR=$RED
  BACKGROUND=$RED_BG
fi

# If charging, change icon
if [ -n "$CHARGING" ]; then
  ICON="󱐋"  # Charging icon
fi

# Ensure $NAME is set
if [ -z "$NAME" ]; then
  echo "Error: NAME variable not set."
  exit 1
fi

# Update SketchyBar (icon & label color)
sketchybar --set "$NAME"  label="$ICON  $PERCENTAGE% " "icon.color=$COLOR" "label.color=$COLOR" "background.color=$BACKGROUND"    background.shadow.drawing=on\
  label.shadow.drawing=on\
  label.shadow.distance=2\

