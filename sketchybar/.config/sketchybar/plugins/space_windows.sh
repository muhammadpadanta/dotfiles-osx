#!/bin/sh

# Fetch all spaces and windows
SPACES_JSON=$(yabai -m query --spaces)
WINDOWS_JSON=$(yabai -m query --windows)

# Define app icons using Nerd Font characters
get_icon_for_app() {
  case "$1" in
    "Finder") echo "󰀶 " ;;
    "App Store") echo " " ;;
    "Activity Monitor") echo " " ;;
    "Proton Pass") echo " " ;;
    "System Settings") echo " " ;;
    "System Information") echo "󰋼 " ;;
    "Passwords") echo " " ;;
    "Calendar") echo " " ;;
    "Reminders") echo " " ;;
    "Notes") echo " " ;;
    "Photos") echo " " ;;
    "Maps") echo " " ;;
    "Mail") echo " " ;;
    "GitHub Desktop") echo " " ;;
    "IINA") echo " " ;;
    "QuickTime Player") echo " " ;;
    "Preview") echo "󰍉 " ;;
    "Code") echo "󰨞 " ;;
    "Xcode") echo " " ;;
    "Code - Insiders") echo "󰨞 " ;;
    "iTerm2") echo " " ;;
    "Terminal") echo " " ;;
    "Safari") echo " " ;;
    "Firefox") echo " " ;;
    "Arc") echo " " ;;
    "Microsoft Word") echo " " ;;
    "Microsoft Excel") echo " " ;;
    "Microsoft PowerPoint") echo "󱎐 " ;;
    "Discord") echo " " ;;
    "Slack") echo " " ;;
    "zoom.us") echo " " ;;
    "Honkai: Star Rail") echo "󰊴 " ;;
    "Genshin Impact") echo "󰊴 " ;;
    "Steam") echo " " ;;
    "Steam Helper") echo " " ;;
    "java") echo "󰍳 " ;;
    "Minecraft Launcher") echo "󰍳 " ;;
    "Terraria") echo "󰢷 " ;;
    "PlayCover") echo "󰊴 " ;;
    "Spotify") echo " " ;;
    "Music") echo " " ;;
    "Android Studio") echo "󰀴 " ;;
    "Notion") echo " " ;;
    "Obsidian") echo " " ;;
    "Figma") echo " " ;;
    "Resolve") echo "󰌁 " ;;
    "osu!") echo "󰊴 " ;;
    "Insomnia") echo " ";;
    "Ragnarok M: Classic") echo "󰊴 " ;;
    "Ghostty") echo "󰊠 ";;

    *) echo " " ;;  # Default icon
  esac
}

# Extract space indices
echo "Fetching open apps in each space..."
echo "$SPACES_JSON" | jq -r '.[].index' | while read -r sid; do
  echo "---- Space $sid ----"

  WINDOWS=$(echo "$WINDOWS_JSON" | jq -r --argjson sid "$sid" '.[] | select(.space == $sid) | .app' | sort | uniq)
  echo "Apps in space $sid: $WINDOWS"

  ICONS=""
  while IFS= read -r APP; do
    echo "Checking app: '$APP'"

    # Handle potential empty values
    if [ -z "$APP" ]; then
      echo "⚠️ Skipping empty app name!"
      continue
    fi

    APP_ICON=$(get_icon_for_app "$APP")
    echo "Matched icon: '$APP_ICON' for app: '$APP'"

    if [ -n "$APP_ICON" ] && [ "$APP_ICON" != " " ]; then
      ICONS+="$APP_ICON"
    fi
  done <<< "$WINDOWS"

  # **💡 Adjust padding dynamically**
if [ -z "$ICONS" ]; then
  ICONS=" "  # Prevent SketchyBar from keeping old icons
  FINAL_PADDING=5  # Default padding when empty
else
  BASE_PADDING=4   # Consistent base padding when icons exist
  FINAL_PADDING=$BASE_PADDING  # Keep this constant to avoid sudden jumps
fi

sketchybar --animate tanh 15 --set "space.$sid" \
  label="$ICONS" \
  label.padding_left=$FINAL_PADDING \
  icon.padding_left=10 \
  icon.padding_right=5
done
