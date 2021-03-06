#! /usr/bin/env bash
# This file is tested under Arch Linux 64bit.

DOTFILES_DIR="$( cd $(dirname $0) ; pwd -P )"

create_symlinks () {
  if [ ! -e ~/.vim ]; then
    echo 'Creating symlink ~/.vim ...'
    mkdir $DOTFILES_DIR/vim
    ln -sfn $DOTFILES_DIR/vim ~/.vim
  fi

  if [ ! -e ~/.vimrc ]; then
    echo 'Creating symlink ~/.vimrc ...'
    ln -sfn $DOTFILES_DIR/vimrc ~/.vimrc
  fi
}

setup_vim () {
  echo 'Setting up vim ...'

  create_symlinks

  # Make directories for Vim.
  # Those directories names should match the ones set in vimrc.
  mkdir -p ~/tmp/vim.d/{back,undo,swap}.d

  # Install vim-plug plugin.
  echo 'Installing vim-plug ...'
  curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  echo 'Installing plugins ...'
  vim +PlugInstall +qall
}

setup_xterm () {
  echo 'Setting up xterm ...'
  ln -sfn $DOTFILES_DIR/Xresources ~/.Xresources
  ln -sfn $DOTFILES_DIR/Xresources.d ~/.Xresources.d
}

setup_xinitrc () {
  echo 'Setting up .xinitrc ...'
  mv ~/.xinitrc ~/.xinitrc.orig
  ln -sfn $DOTFILES_DIR/xinitrc ~/.xinitrc

  # Set up wallpapers
  git clone https://github.com/ste99w/material-wallpapers ~/.wallpapers
}

setup_bashrc () {
  echo 'Setting up bashrc ...'
  mv ~/.bashrc ~/.bashrc.orig
  cp /usr/share/git/git-prompt.sh ~/.git-prompt.sh
  echo 'Creating symlink ~/.bashrc ...'
  ln -sfn $DOTFILES_DIR/bashrc ~/.bashrc
}

setup_inputrc () {
  echo 'Setting up inputrc ...'
  mv ~/.inputrc ~/.inputrc.orig &> /dev/null
  echo 'Creating symlink ~/.inputrc ...'
  ln -sfn $DOTFILES_DIR/inputrc ~/.inputrc
}

setup_gitconfig () {
  echo 'Setting up gitconfig ...'
  mv ~/.gitconfig ~/.gitconfig.orig &> /dev/null
  ln -sfn $DOTFILES_DIR/gitconfig ~/.gitconfig
}

setup_ipython () {
  echo 'Setting up ipython config ...'
  hash ipython &> /dev/null
  if [ $? -eq 1 ]; then
    echo 'ipython not found, please install it first, then try again.'
  fi
  if [ -f ~/.ipython/profile_default/ipython_config.py ]; then
    mv ~/.ipython/profile_default/ipython_config.py ~/.ipython/profile_default/ipython_config.py.orig
  fi
  ln -sfn $DOTFILES_DIR/ipython_config.py ~/.ipython/profile_default/ipython_config.py
}

setup_fontconfig () {
  echo 'Setting up fontconfig ...'
  mkdir -p ~/.config/fontconfig/
  ln -sfn $DOTFILES_DIR/fonts.conf ~/.config/fontconfig/fonts.conf
}

setup_i3wm () {
  echo 'Setting up i3wm ...'
  mkdir -p ~/.config/{i3,i3status}
  mv ~/.config/i3/config ~/.config/i3/config.orig &> /dev/null
  echo 'Creating symlink ~/.config/i3/config ...'
  ln -sfn $DOTFILES_DIR/i3config ~/.config/i3/config
  mv ~/.config/i3status/config ~/.config/i3status/config.orig &> /dev/null
  echo 'Creating symlink ~/.config/i3status/config ...'
  ln -sfn $DOTFILES_DIR/i3statusconfig ~/.config/i3status/config
}

setup_others () {
  setup_bashrc
  setup_inputrc
  setup_i3wm
}

setup_all () {
  setup_vim
  setup_xterm
  setup_xinitrc
  setup_gitconfig
  setup_ipython
  setup_fontconfig
  setup_others

  echo ''
  echo 'You may need to logout and then login to make everything take effect!'
}

update_repo () {
  echo 'Updating dotfiles reposity ...'
  cd $DOTFILES_DIR
  git pull origin master
}

show_help () {
  echo 'install.sh: install dotfiles'
  echo 'Options:'
  echo -e "--help\tPrint this usage"
  echo -e "--update\tUpdate dotfiles reposity to the lastest"
  echo -e "--all\tSetup Vim, Xterm, xinitrc, i3wm, bashrc, inputrc, i3 config, and font config"
  echo -e "--vim\tSetup Vim"
  echo -e "--xterm\tSetup Xterm"
  echo -e "--xinitrc\tSetup xinitrc"
  echo -e "--bashrc\tSetup bashrc"
  echo -e "--inputrc\tSetup inputrc"
  echo -e "--gitconfig\tSetup gitconfig"
  echo -e "--ipython\tSetup ipython"
  echo -e "--fontconfig\tSetup fontconfig"
  echo -e "--i3-config\tSetup i3wm config"
}

install () {
  case "$1" in
    --help ) show_help ;;
    --update ) update_repo ;;
    --all ) setup_all ;;
    --vim ) setup_vim ;;
    --xterm ) setup_xterm ;;
    --xinitrc ) setup_xinitrc ;;
    --bashrc ) setup_bashrc ;;
    --inputrc ) setup_inputrc ;;
    --gitconfig ) setup_gitconfig ;;
    --ipython ) setup_ipython ;;
    --fontconfig ) setup_fontconfig ;;
    --i3-config ) setup_i3wm ;;
    '' ) show_help ;;
  esac
}

install $1
