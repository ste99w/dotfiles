#! /usr/bin/env bash
# This file is tested under Arch Linux 64bit.

DOTFILES_DIR=${DOTFILES_DIR:-"`dirname $0`/dotfiles"}

create_symlinks () {
  if [ ! -e ~/.vim ]; then
    echo 'Creating symlink ~/.vim ...'
    ln -sfn $DOTFILES_DIR/vim ~/.vim
  fi

  if [ ! -e ~/.vimrc ]; then
    echo 'Creating symlink ~/.vimrc ...'
    ln -sfn $DOTFILES_DIR/vimrc ~/.vimrc
  fi
}

setup_vim () {
  create_symlinks

  # Make directories for Vim.
  # Those directories names should match the ones set in vimrc.
  mkdir -p ~/tmp/vim.d/{back,undo,swap}.d

  echo 'Setting up vim ...'
  # Install Vundle.vim plugin.
  echo 'Installing Vundle.vim ...'
  # The directory Vundle.vim is installed should be the same of the runtime
  # path set in vimrc.
  git clone https://github.com/VundleVim/Vundle.vim ~/.vim/bundle/Vundle.vim
  # Install other plugins.
  vim +PluginInstall +qall

  # Post plugin installation actions.
  # vimproc.vim plugin
  cd ~/.vim/bundle/vimproc.vim/
  make
}

setup_bashrc () {
  echo 'Creating symlink ~/.bashrc ...'
  ln -sfn $DOTFILES_DIR/bashrc ~/.bashrc
}

setup_inputrc() {
  echo 'Creating symlink ~/.inputrc ...'
  ln -sfn $DOTFILES_DIR/inputrc ~/.inputrc
}

setup_i3wm() {
  echo 'Backing up original ~/.config/i3/config to ~/.config/i3/config.orig'
  mv ~/.config/i3/config ~/.config/i3/config.orig
  echo 'Creating symlink ~/.config/i3/config ...'
  ln -sfn $DOTFILES_DIR/i3/config ~/.config/i3/config
  echo 'Backing up original ~/.config/i3status/config to ~/.config/i3status/config.orig'
  mv ~/.config/i3status/config ~/.config/i3status/config.orig
  echo 'Creating symlink ~/.config/i3status/config ...'
  ln -sfn $DOTFILES_DIR/i3status/config ~/.config/i3status/config
}

setup_others () {
  setup_bashrc
  setup_inputrc
  setup_i3wm
}

setup_all () {
  setup_vim
  setup_others
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
  echo -e "--all\tSetup Vim, bashrc, inputrc, i3 config, and font config"
  echo -e "--vim\tSetup Vim"
  echo -e "--bashrc\tSetup bashrc"
  echo -e "--inputrc\tSetup inputrc"
  echo -e "--i3-config\tSetup i3wm config"
}

install () {
  case "$1" in
    --help ) show_help ;;
    --update ) update_repo ;;
    --all ) setup_all ;;
    --vim ) setup_vim ;;
    --bashrc ) setup_bashrc ;;
    --inputrc ) setup_inputrc ;;
    --i3-config ) setup_i3wm ;;
    '' ) show_help ;;
  esac
}

install $1
