#!/bin/sh

source "$CONFIG_DIR/colors.sh"

update() {
  if [ "$SELECTED" = "true" ]; then
    # Animate everything except shadow visibility
    sketchybar --animate tanh 15 --set $NAME \
      background.color=$PURPLE \
      icon.color=$BACKGROUND \
      label.color=$BACKGROUND

    # Disable shadows AFTER animation completes
    sleep 0.15 && sketchybar --set $NAME label.shadow.drawing=off icon.shadow.drawing=off &
  else
    # Delay shadow appearance slightly to sync with color animation
    sleep 0.15 && sketchybar --set $NAME label.shadow.drawing=on icon.shadow.drawing=on label.shadow.distance=3 icon.shadow.distance=3&

    # Animate everything
    sketchybar --animate tanh 15 --set $NAME \
      background.color=$SELECTION \
      icon.color=$FOREGROUND \
      label.color=$FOREGROUND
  fi
}




case "$SENDER" in
  "mouse.clicked") mouse_clicked ;;
  *) update ;;
esac
