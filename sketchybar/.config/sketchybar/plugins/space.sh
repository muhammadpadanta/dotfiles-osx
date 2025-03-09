#!/bin/sh

source "$CONFIG_DIR/colors.sh"

update() {
  if [ "$SELECTED" = "true" ]; then
    # Animate everything except shadow visibility
    sketchybar --animate tanh 15 --set $NAME \
      background.color=$FOREGROUND  \
      icon.color=$BACKGROUND \
      label.color=$BACKGROUND \

    # Disable shadows AFTER animation completes
    sleep 0.15 && sketchybar --set $NAME label.shadow.drawing=off icon.shadow.drawing=off background.shadow.drawing=off &
  else
    # Delay shadow appearance slightly to sync with color animation
    sleep 0.15 && sketchybar --set $NAME label.shadow.drawing=on icon.shadow.drawing=on label.shadow.distance=3 icon.shadow.distance=3 background.shadow.drawing=off&

    # Animate everything
    sketchybar --animate tanh 15 --set $NAME \
      background.color=$BACKGROUND_2 \
      icon.color=$FOREGROUND \
      label.color=$FOREGROUND
  fi
}




case "$SENDER" in
  "mouse.clicked") mouse_clicked ;;
  *) update ;;
esac
