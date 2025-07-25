#!/bin/bash
sudo apt purge neovim -y
sudo apt autoremove -y

rm -rf neovim
rm -rf ~/.local/share/nvim
rm -rf ~/.config/nvim/

sudo apt install ninja-build -y
sudo apt install gettext -y
sudo apt install cmake -y
sudo apt install curl -y
sudo apt install build-essential -y
sudo apt install ripgrep -y

git clone --depth 1 -b stable https://github.com/neovim/neovim
cd neovim
make CMAKE_BUILD_TYPE=RelWithDebInfo
cd build
cpack -G DEB
sudo dpkg -i nvim-linux-x86_64.deb

cd ..
cd ..
rm -rf neovim

