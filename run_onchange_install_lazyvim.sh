#!/bin/sh
if [ ! -d "$HOME/.config/nvim" ]; then
    git clone https://github.com/LazyVim/starter "$HOME/.config/nvim"
fi
