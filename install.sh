#!/bin/sh

# Vim plugins
script_directory = $(dirname "$SCRIPT")
vim_settings_directory = "$script_directory/vim/settings"
curl -fLo "$vim_settings_directory/plug.vim" \
    --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Vim settings
vim_settings = "$vim_settings_directory/.vim"
echo "source $vim_settings" > ~/.vimrc"

# Neovim settings
neovim_settings_directory = "~/.config/nvim"
mkdir -p "$neovim_settings_directory"
echo "source $vim_settings" > "$neovim_settings_directory/init.vim"
