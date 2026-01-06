#!/bin/sh
if [ ! -d "$HOME/.config/nvim/.git" ]; then
    # If the directory exists but isn't a git repo, remove it to allow a clean clone.
    # Chezmoi will ensure managed files (like user_configs.lua) are applied/restored.
    rm -rf "$HOME/.config/nvim"
    git clone https://github.com/LazyVim/starter "$HOME/.config/nvim"
fi
