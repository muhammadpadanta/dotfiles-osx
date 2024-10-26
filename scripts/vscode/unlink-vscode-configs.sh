#!/bin/bash

# Script to unlink VS Code Insiders configurations and restore backups

# Define paths for settings and keybindings
VSCODE_INSIDERS_USER_DIR="$HOME/Library/Application Support/Code - Insiders/User"
VSCODE_INSIDERS_EXT_DIR="$HOME/.vscode-insiders/extensions"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Initialize counters
unlinked_count=0
skipped_count=0

# Helper functions for logging
log() {
    echo -e "${GREEN}[UNLINK]${NC} $1"
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

# Function to find most recent backup
find_latest_backup() {
    local pattern=$1
    ls -d ${pattern}* 2>/dev/null | sort -r | head -n1
}

# Function to restore from backup if exists
restore_from_backup() {
    local dir=$1
    local item=$2
    local backup_path=$(find_latest_backup "${dir}_backup_")

    if [ -n "$backup_path" ] && [ -e "$backup_path/$item" ]; then
        log "Restoring $item from backup"
        cp -R "$backup_path/$item" "$dir/"
        return 0
    else
        info "No backup found for $item"
        return 1
    fi
}

# Function to remove symbolic link
remove_user_link() {
    local item=$1
    local full_path="$VSCODE_INSIDERS_USER_DIR/$item"

    if [ -L "$full_path" ]; then
        log "Removing symbolic link: $item"
        rm "$full_path"
        if restore_from_backup "$VSCODE_INSIDERS_USER_DIR" "$item"; then
            log "Successfully restored backup for $item"
        fi
        ((unlinked_count++))
    elif [ -e "$full_path" ]; then
        info "Skipping $item - not a symbolic link"
        ((skipped_count++))
    else
        info "Skipping $item - does not exist"
        ((skipped_count++))
    fi
}

# Function to check directory existence
check_directories() {
    local has_error=0

    if [ ! -d "$VSCODE_INSIDERS_USER_DIR" ]; then
        warn "VS Code Insiders User directory not found at $VSCODE_INSIDERS_USER_DIR"
        has_error=1
    fi

    if [ ! -d "$VSCODE_INSIDERS_EXT_DIR" ]; then
        warn "VS Code Insiders Extensions directory not found at $VSCODE_INSIDERS_EXT_DIR"
        has_error=1
    fi

    if [ $has_error -eq 1 ]; then
        info "Some directories are missing. This might be normal if VS Code Insiders hasn't been run yet."
        info "Proceeding with available directories..."
        echo
    fi
}

# Main unlink function
main() {
    # Check directories
    check_directories

    # Unlink User settings
    log "Unlinking User settings..."
    local user_items=(
        "settings.json"
        "keybindings.json"
        "snippets"
    )

    for item in "${user_items[@]}"; do
        remove_user_link "$item"
    done

    # Unlink extensions
    log "Unlinking extensions..."
    if [ -L "$VSCODE_INSIDERS_EXT_DIR" ]; then
        log "Removing extensions symbolic link"
        rm "$VSCODE_INSIDERS_EXT_DIR"
        if restore_from_backup "$HOME/.vscode-insiders" "extensions"; then
            log "Successfully restored extensions backup"
        fi
        ((unlinked_count++))
    else
        if [ -d "$VSCODE_INSIDERS_EXT_DIR" ]; then
            info "Extensions directory is not a symbolic link"
        else
            info "Extensions directory does not exist"
        fi
        ((skipped_count++))
    fi

    # Summary
    echo
    log "Unlinking complete!"
    echo -e "${GREEN}Summary:${NC}"
    echo -e "- Unlinked items: $unlinked_count"
    echo -e "- Skipped items: $skipped_count"

    # Check for backups and show paths
    local user_backup_dir=$(find_latest_backup "${VSCODE_INSIDERS_USER_DIR}_backup_")
    local ext_backup_dir=$(find_latest_backup "${VSCODE_INSIDERS_EXT_DIR}_backup_")

    if [ -n "$user_backup_dir" ] || [ -n "$ext_backup_dir" ]; then
        echo
        log "Backup locations:"
        [ -n "$user_backup_dir" ] && info "User settings: $user_backup_dir"
        [ -n "$ext_backup_dir" ] && info "Extensions: $ext_backup_dir"
        info "You can manually restore more files from these backups if needed"
    fi
}

# Confirmation prompt
echo -e "${YELLOW}This will unlink VS Code Insiders configurations from VS Code.${NC}"
echo -e "${YELLOW}It will attempt to restore from backup if available.${NC}"
read -p "Do you want to continue? (y/N) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    main
else
    log "Operation cancelled"
    exit 0
fi

if [ $unlinked_count -eq 0 ]; then
    warn "No configurations were unlinked."
    if [ $skipped_count -gt 0 ]; then
        info "This might be because the configurations were already unlinked or didn't exist."
    fi
else
    log "Successfully unlinked $unlinked_count configuration(s)!"
fi

log "You may need to restart VS Code Insiders for changes to take effect."
