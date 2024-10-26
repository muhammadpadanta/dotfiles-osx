#!/bin/bash

# Script to link VS Code and VS Code Insiders configurations

# Define paths for settings and keybindings
VSCODE_USER_DIR="$HOME/Library/Application Support/Code/User"
VSCODE_INSIDERS_USER_DIR="$HOME/Library/Application Support/Code - Insiders/User"

# Define paths for extensions
VSCODE_EXT_DIR="$HOME/.vscode/extensions"
VSCODE_INSIDERS_EXT_DIR="$HOME/.vscode-insiders/extensions"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Helper function for logging
log() {
    echo -e "${GREEN}[SETUP]${NC} $1"
}

warn() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

# Backup function
backup_config() {
    local dir=$1
    local backup_dir="${dir}_backup_$(date +%Y%m%d_%H%M%S)"

    if [ -d "$dir" ]; then
        log "Backing up $dir to $backup_dir"
        mv "$dir" "$backup_dir"
    fi
}

# Create symbolic links
link_configs() {
    local source_dir=$1
    local target_dir=$2
    local item=$3

    if [ -e "$source_dir/$item" ]; then
        if [ -e "$target_dir/$item" ]; then
            warn "Existing $item found in target directory, backing up..."
            backup_config "$target_dir/$item"
        fi
        log "Linking $item"
        ln -sf "$source_dir/$item" "$target_dir/$item"
    else
        info "Skipping $item - source file/directory doesn't exist"
    fi
}

# Check if source directory exists
check_source_dir() {
    if [ ! -d "$VSCODE_USER_DIR" ]; then
        error "VS Code User directory not found at $VSCODE_USER_DIR"
        error "Please make sure VS Code (stable) is installed and has been run at least once"
        exit 1
    fi
}

# Main setup
main() {
    # Initialize counters
    local linked_count=0
    local skipped_count=0

    # Check source directory
    check_source_dir

    # Create necessary directories
    mkdir -p "$VSCODE_INSIDERS_USER_DIR"
    mkdir -p "$VSCODE_INSIDERS_EXT_DIR"

    # Link User settings
    log "Linking User settings..."
    local user_items=(
        "settings.json"
        "keybindings.json"
        "snippets"
    )

    for item in "${user_items[@]}"; do
        if [ -e "$VSCODE_USER_DIR/$item" ]; then
            link_configs "$VSCODE_USER_DIR" "$VSCODE_INSIDERS_USER_DIR" "$item"
            ((linked_count++))
        else
            info "Skipping $item - not found in VS Code configuration"
            ((skipped_count++))
        fi
    done

    # Link extensions directory
    log "Linking extensions..."
    if [ -d "$VSCODE_INSIDERS_EXT_DIR" ]; then
        warn "Existing extensions directory found, backing up..."
        backup_config "$VSCODE_INSIDERS_EXT_DIR"
    fi

    if [ -d "$VSCODE_EXT_DIR" ]; then
        log "Linking extensions directory"
        ln -sf "$VSCODE_EXT_DIR" "$VSCODE_INSIDERS_EXT_DIR"
        ((linked_count++))
    else
        info "Extensions directory not found at $VSCODE_EXT_DIR"
        ((skipped_count++))
    fi

    # Summary
    echo
    log "Linking complete!"
    echo -e "${GREEN}Summary:${NC}"
    echo -e "- Linked items: $linked_count"
    echo -e "- Skipped items: $skipped_count"

    # Store the skipped count for the final message
    export SKIPPED_COUNT=$skipped_count
}

# Run the script
main

log "VS Code and VS Code Insiders configurations are now linked!"
log "Note: You may need to restart VS Code Insiders for changes to take effect."

# Additional information - fixed the comparison
if [ "$SKIPPED_COUNT" -gt 0 ] 2>/dev/null; then
    echo
    info "Some items were skipped because they don't exist in your VS Code configuration."
    info "This is normal if you haven't customized all settings yet."
    info "When you create these files in VS Code, run this script again to link them."
fi


