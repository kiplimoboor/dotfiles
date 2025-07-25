#!/bin/bash
sudo apt purge neovim
sudo apt autoremove
git clone --depth 1 -b stable https://github.com/neovim/neovim
cd neovim
make CMAKE_BUILD_TYPE=RelWithDebInfo
cd build
cpack -G DEB
sudo dpkg -i nvim-linux-x86_64.deb

cd ..
cd ..
rm -rf neovim

rm -rf ~/.config/nvim/
mkdir ~/.config/nvim
cd ~/.config/nvim/

git clone --depth 1 -b master https://github.com/nvim-lua/kickstart.nvim
cd kickstart.nvim
rm -rf .git* *.md
mv * ..
cd ..
rm -rf kickstart.nvim
