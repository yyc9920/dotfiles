#!/bin/bash

set -e

echo "Install basic packages"
sudo apt install -y libevent-dev ncurses-dev build-essential bison pkg-config curl zsh git minicom ibus-hangul libbz2-dev tree nodejs npm

echo "Download ohmyzsh"
sh -c "$(curl -fssl https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

echo "Download neovim"
wget https://github.com/neovim/neovim/releases/download/v0.10.3/nvim-linux64.tar.gz
tar xvzf nvim-linux64.tar.gz
sudo cp -r nvim-linux64/bin/* /usr/bin
sudo cp -r nvim-linux64/lib/* /usr/lib
sudo cp -r nvim-linux64/share/* /usr/share

echo "Setup NvChad"
git clone -b v2.5 https://github.com/NvChad/NvChad ~/.config/nvim --depth 1 && nvim

echo "Download NerdFonts"
mkdir fonts
pushd fonts
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/JetBrainsMono.zip
unzip JetBrainsMono.zip
sudo cp *.ttf /usr/local/share/fonts
sudo fc-cache -fv
echo "Change terminal font to JetBrainsMono"
popd

echo "Setup tmux"
wget https://github.com/tmux/tmux/releases/download/3.5/tmux-3.5.tar.gz
tar -zxf tmux-*.tar.gz
cd tmux-*/
./configure
make && sudo make install
tmux -V
cp -r tmux ~/.config
