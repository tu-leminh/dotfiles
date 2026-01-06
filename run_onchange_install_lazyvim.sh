#!/bin/sh
if [ ! -d "$HOME/.config/nvim/.git" ]; then
  rm -rf "$HOME/.config/nvim"
  git clone https://github.com/LazyVim/starter "$HOME/.config/nvim"
fi
