#!/bin/bash
set -e

# Default to hostname if SPRITE_NAME not set
SPRITE_NAME=${SPRITE_NAME:-$(hostname)}
EMAIL="nyx+${SPRITE_NAME}@blank-slate.io"

echo "👾 Initializing Sprite: $SPRITE_NAME"

# 1. Configure Git Identity
if [ -z "$(git config --global user.name)" ]; then
    echo "   -> Setting Git Name: $SPRITE_NAME"
    git config --global user.name "$SPRITE_NAME"
fi

if [ -z "$(git config --global user.email)" ]; then
    echo "   -> Setting Git Email: $EMAIL"
    git config --global user.email "$EMAIL"
fi

# 2. Grant Git access to the mounted volume
echo "   -> Granting Git access to /workspace"
git config --global --add safe.directory /workspace

# 3. Generate SSH Key (if missing)
KEY_PATH="$HOME/.ssh/id_ed25519"
if [ ! -f "$KEY_PATH" ]; then
    echo "   -> Forging new SSH Key for $EMAIL..."
    mkdir -p "$HOME/.ssh"
    ssh-keygen -t ed25519 -C "$EMAIL" -f "$KEY_PATH" -N ""
    
    echo ""
    echo "--- [ PUBLIC KEY FOR GITHUB ] ---"
    cat "${KEY_PATH}.pub"
    echo "---------------------------------"
    echo ""
else
    echo "   -> SSH Key already exists."
fi

# 3. Hand over control to the main command
exec "$@"
