#!/bin/bash
sudo apt purge neovim -y
sudo apt autoremove -y

rm -rf ~/.local/share/nvim

git clone --depth 1 -b stable https://github.com/neovim/neovim
sudo apt-get install ninja-build gettext cmake curl build-essential
cd neovim
make CMAKE_BUILD_TYPE=RelWithDebInfo
cd build
cpack -G DEB
sudo dpkg -i nvim-linux-x86_64.deb

cd ..
cd ..
rm -rf neovim

