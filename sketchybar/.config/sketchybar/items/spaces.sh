#!/bin/bash

SPACE_NUMBERS=("1" "2" "3" "4" "5" "6" "7" "8" "9")

for sid in {1..9}; do
  sketchybar --add space "space.$sid" left\
             --set "space.$sid" space=$sid\
                  icon="${SPACE_NUMBERS[$((sid-1))]}"\
                  icon.font="JetBrainsMono Nerd Font:Bold:14"\
                  label.font="JetBrainsMono Nerd Font Mono:Bold:20"\
                  script="$PLUGIN_DIR/space.sh"\
             --subscribe "space.$sid" space_change windows_on_spaces
done



# Space Separator
sketchybar --add item space_separator left\
           --set space_separator icon="➤"\
                 label.drawing=off\
                 script="$PLUGIN_DIR/space_windows.sh"\
           --subscribe space_separator space_windows_change\
