#!/usr/bin/env bash
echo "Setting up Ubuntu..."

sudo su
apt update && apt upgrade -yy

# enable partner repositories
sudo add-apt-repository "deb http://archive.canonical.com/ubuntu $(lsb_release -sc) partner"

# install flatpack
add-apt-repository ppa:alexlarsson/flatpak -yy
apt update && sudo apt install flatpak -yy
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo -yy

# install git
apt install git -yy

# install nvim
add-apt-repository ppa:neovim-ppa/stable -yy
apt update -yy
apt install neovim -yy
update-alternatives --install $(which vim) vim $(which nvim) 10

# install vim-plug
curl -fLo ~/.var/app/io.neovim.nvim/data/nvim/site/autoload/plug.vim \
   https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim -yy

# reinstate vim config
git clone https://github.com/KiritchoukC/dotfiles ~/repos
mkdir -p ~/.config/nvim/ && touch ~/.config/nvim/init.vim
"source ~/repos/dotfiles/init.vim" >> ~/.config/nvim/init.vim

# install zsh
apt install zsh -yy
# switch default shell to zsh
chsh -S $(which zsh)
# install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
# reinstante zsh config from git

# install packages
apt install \
   python3-pip \
   cowsay \
   fortune \
   thefuck \
   npm \
   neofetch \
   -yy

# install softwares
flatpak install flathub org.chromium.Chromium
flatpak install flathub org.videolan.VLC
flatpak install flathub com.microsoft.Teams
flatpak install flathub com.wps.Office
flatpak install flathub io.gitlab.o20.word

# install codecs
apt install ubuntu-restricted-extras -yy

 # final notes
echo "Setup complete, don't forget to:"
echo "- Update drivers"
