#!/usr/bin/env bash

# 1. Determine directories
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_CONFIG_DIR="$SCRIPT_DIR/.config"
SYSTEM_CONFIG_DIR="$HOME/.config"

echo "🔧 Dotfiles Installer (Copy Mode)"
echo "---------------------------------"
echo "📂 Repo Source: $REPO_CONFIG_DIR"
echo "🎯 System Dest: $SYSTEM_CONFIG_DIR"
echo ""

# Verify source exists
if [ ! -d "$REPO_CONFIG_DIR" ]; then
    echo "❌ Error: Could not find '.config' folder inside '$SCRIPT_DIR'."
    exit 1
fi

echo "🚀 Starting installation..."
echo ""

# Loop through every folder in the repo's .config directory
for config_path in "$REPO_CONFIG_DIR"/*; do
    config_name="$(basename "$config_path")"
    target_path="$SYSTEM_CONFIG_DIR/$config_name"

    echo "➡️  Processing: $config_name"

    # 1. Handle Backups (Move existing folder to .bak)
    if [ -e "$target_path" ]; then
        # Determine unique backup name (hypr.bak, hypr.bak2, etc.)
        backup_name="$target_path.bak"
        counter=2
        while [ -e "$backup_name" ]; do
            backup_name="$target_path.bak$counter"
            ((counter++))
        done

        echo "   📦 Moving existing config to: $(basename "$backup_name")"
        mv "$target_path" "$backup_name"
    fi

    # 2. Copy the files (cp -r)
    echo "   📝 Copying..."
    cp -r "$config_path" "$target_path"

done

# Fix permissions for scripts after copying
echo ""
echo "🔧 Setting executable permissions..."
find "$SYSTEM_CONFIG_DIR" -name "*.sh" -exec chmod +x {} \; 2>/dev/null

echo ""
echo "✅ Installation complete!"
echo "🔄 Please restart Hyprland or log out/in."
