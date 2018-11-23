#!/bin/bash

DOT_PATH=$HOME/.dotfiles
GITHUB_URL=https://github.com/mokuzon/dotfiles.git


get_package_manager() {
  # OSX
  if [ `uname` = "Darwin" ]; then
    if ! type brew >/dev/null 2>&1; then
      /usr/bin/ruby -e "`curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install`"
      brew doctor
    fi
    echo "brew"
  # Linux
  elif [ `uname` = "Linux" ]; then
    # Debian
    if type aptitude >/dev/null 2>&1; then
      echo "aptitude"
    # RHEP
    elif type yum >/dev/null 2>&1; then
        echo "yum"
    else
      echo "Your system is not supported." 1>&2
      exit 1
    fi
  fi
}


init() {
  if [[ $? -eq 0 ]]; then
    PACKAGE_MANAGER=`get_package_manager`
  else
    exit 1
  fi

  # zsh install
  if ! type zsh >/dev/null 2>&1; then
    $PACKAGE_MANAGER install -y zsh
    ZSH_PATH=`which zsh`
    echo $ZSH_PATH >> /etc/shells
    chsh -s $ZSH_PATH
  fi

  # tmux install
  if ! type tmux >/dev/null 2>&1; then
    $PACKAGE_MANAGER install -y tmux
  fi

  # nepvim install
  if ! type vim >/dev/null 2>&1; then
    $PACKAGE_MANAGER install -y neovim/neovim/neovim
  fi

  # git install
  if ! type git >/dev/null 2>&1; then
    $PACKAGE_MANAGER install -y git
  fi

  pull
  return 0
}


pull() {
  if [ -e $DOT_PATH/.git ]; then
    cd $DOT_PATH
    git pull
  else
    git clone --recursive $GITHUB_URL $DOT_PATH
    cd $DOT_PATH
  fi


  for f in .??*
  do
    [[ "$f" == ".git" ]] && continue
    [[ "$f" == ".gitignore" ]] && continue
    [[ "$f" == ".gitmodules" ]] && continue
    [[ "$f" == ".gitconfig" ]] && continue

    ln -snfv $DOT_PATH/$f $HOME/$f
    cp .gitignore ~
  done

  mkdir ~/.config
  ln -snfv ${HOME}/.vim ${HOME}/.config/nvim

  .tmux/tpm/bin/install_plugins
  /bin/bash -c 'nvim -c ":silent! PlugInstall | :qa"'
  exec "${SHELL:-/bin/zsh}"
  zplug install
}


commit() {
  if [ "$1" = "" ]; then
    MESSAGE="update"
  else
    MESSAGE="$1"
  fi
  git add --all
  git commit -m "$MESSAGE"
  return 0
}


push() {
  git push origin master
  return 0
}


usage() {
  return 0
}


main() {
  if [[ "$1" == "init" ]]; then
  	init
    return 0
  elif [[ "$1" == "commit" ]]; then
    commit "$2"
    return 0
  elif [[ "$1" == "push" ]]; then
    push
    return 0
  elif [[ "$1" == "pull" ]]; then
  	pull
    return 0
  else
    usage
    return 0
  fi
}

main $1 "$2"
