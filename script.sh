#!/bin/bash

# Define the paths
VIMRC_SOURCE="./vimrc.txt"
VIMRC_DEST="$HOME/.vimrc"
VIM_DIR="$HOME/.vim"
COLORS_DIR="$VIM_DIR/colors"
AUTOLOAD_DIR="$VIM_DIR/autoload"
BACKUP_DIR="$VIM_DIR/backup"
PLUG_DIR="$VIM_DIR/plug"
MOLOKAI_URL="https://raw.githubusercontent.com/tomasr/molokai/master/colors/molokai.vim"
MOLOKAI_DEST="$COLORS_DIR/molokai.vim"

# Check if vimrc.txt exists
if [ ! -f "$VIMRC_SOURCE" ]; then
    echo "Error: vimrc.txt not found!"
    exit 1
fi

curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Step 1: Copy the vimrc.txt content to ~/.vimrc
echo "Copying vimrc.txt to ~/.vimrc..."
cp "$VIMRC_SOURCE" "$VIMRC_DEST"

# Step 2: Create necessary directories in ~/.vim
echo "Creating necessary .vim directories..."
mkdir -p "$COLORS_DIR" "$AUTOLOAD_DIR" "$BACKUP_DIR" "$PLUG_DIR"

# Step 3: Download the Molokai colorscheme
echo "Downloading Molokai colorscheme..."
curl -fLo "$MOLOKAI_DEST" "$MOLOKAI_URL"

# Confirm success
if [ $? -eq 0 ]; then
    echo "Molokai colorscheme downloaded to $MOLOKAI_DEST"
else
    echo "Error downloading Molokai colorscheme!"
fi

# Step 4: Install plugins using Vim-Plug
echo "Installing Vim plugins with PlugInstall..."
vim -c "PlugInstall" -c "qa"

# Step 5: Source the .vimrc file
echo "Sourcing .vimrc..."
vim -c "source ~/.vimrc" -c "qa"

echo "Vim setup completed!"
