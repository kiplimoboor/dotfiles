#!/bin/bash

sudo apt update -y
sudo apt upgrade -y
sudo apt purge neovim -y
sudo apt autoremove -y

sudo apt install git -y
sudo apt install ninja-build -y
sudo apt install gettext -y
sudo apt install cmake -y
sudo apt install curl -y
sudo apt install build-essential -y
sudo apt install ripgrep -y

rm -rf neovim
rm -rf ~/.local/share/nvim
rm -rf ~/.config/nvim/

git clone --depth 1 -b stable https://github.com/neovim/neovim
cd neovim
make CMAKE_BUILD_TYPE=RelWithDebInfo
cd build
cpack -G DEB
sudo dpkg -i nvim-linux-x86_64.deb

cd ..
cd ..
rm -rf neovim


mkdir -p ~/.config/nvim/
cd ~/.config/nvim/

wget https://github.com/kiplimoboor/dotfiles/raw/refs/heads/main/nvim/init.lua

echo "alias vi=nvim"

source ~/.bashrc
