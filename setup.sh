#!/bin/bash

set -e

echo "========================="
echo "Install basic packages"
echo "========================="
sudo apt install -y libevent-dev ncurses-dev build-essential bison pkg-config curl zsh git minicom ibus-hangul libbz2-dev tree nodejs npm libssl-dev libreadline-dev libsqlite3-dev zlib1g-dev liblzma-dev tk-dev libffi-dev tree
wget https://github.com/sharkdp/bat/releases/download/v0.24.0/bat_0.24.0_amd64.deb && sudo dpkg -i bat_0.24.0_amd64.deb
curl -LO https://github.com/BurntSushi/ripgrep/releases/download/14.1.0/ripgrep_14.1.0-1_amd64.deb && sudo dpkg -i ripgrep_14.1.0-1_amd64.deb
ln -s ./.gitconfig ~/.gitconfig

echo "========================="
echo "Download ohmyzsh"
echo "========================="
sh -c "$(curl -fssl https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

echo "========================="
echo "Setup fzf"
echo "========================="
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install
ln -s ./.zshrc ~/.zshrc

echo "========================="
echo "Download neovim"
echo "========================="
wget https://github.com/neovim/neovim/releases/download/v0.10.3/nvim-linux64.tar.gz
tar xvzf nvim-linux64.tar.gz
sudo mv nvim-linux64/bin/* /usr/bin
sudo mv nvim-linux64/lib/* /usr/lib
sudo mv nvim-linux64/share/* /usr/share
rm -rf nvim-linux64

echo "========================="
echo "Setup NvChad"
echo "========================="
git clone -b v2.5 https://github.com/NvChad/NvChad ~/.config/nvim --depth 1 && nvim

echo "========================="
echo "Download NerdFonts"
echo "========================="
mkdir fonts
pushd fonts
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/JetBrainsMono.zip
unzip JetBrainsMono.zip
sudo cp *.ttf /usr/local/share/fonts
sudo fc-cache -fv
echo "Change terminal font to JetBrainsMono"
popd

echo "========================="
echo "Setup tmux"
echo "========================="
wget https://github.com/tmux/tmux/releases/download/3.5/tmux-3.5.tar.gz
tar -zxf tmux-*.tar.gz
cd tmux-*/
./configure
make && sudo make install
tmux -V
cp -r tmux ~/.config
rm -rf tmux-*

echo "========================="
echo "Setup Pyenv"
echo "========================="
curl https://pyenv.run | bash
echo 'export PYENV_ROOT="$HOME/.pyenv"\
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"\
eval "$(pyenv init - bash)"' >> ~/.zshrc
echo 'eval "$(pyenv virtualenv-init -)"' >> ~/.zshrc
source ~/.zshrc
pyenv install 3.10.16
pyenv global 3.10.16
pip install git+https://github.com/jeffkaufman/icdiff.git

echo "========================="
echo "Setup custom shell script"
echo "========================="
mkdir -p ~/.local/bin
echo "#!/bin/bash
nohup nautilus $1 > /dev/null 2>&1 & disown" > ~/.local/bin/open
chmod +x ~/.local/bin/open

