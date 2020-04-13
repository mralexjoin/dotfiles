#!/bin/sh

script_directory = $(dirname "$SCRIPT")
vim_settings_directory = "$script_directory/vim/settings"
curl -fLo "$vim_settings_directory/plug.vim" \
    --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
echo "source $vim_settings_directory/.vim" > $1"

