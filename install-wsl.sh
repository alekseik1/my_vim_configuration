#!/bin/bash
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

# install packages
if [ $(awk -F= '/^NAME/{print $2}' /etc/os-release) == '"Ubuntu"' ]; then
  sudo apt update
  sudo apt upgrade -y
  sudo apt install -y git python-is-python3 tmux python3 python3-dev build-essential vim python3-virtualenv curl wget zsh
fi

# oh my zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
# install plugins
bash -c 'set -a && . $HOME/.zshrc && git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions'

# clean .zshrc since using own
if test -f "$HOME/.zshrc"; then rm $HOME/.zshrc; fi

# link rc files
for FILE in .vimrc .zshrc .ideavimrc .latexmkrc .gitconfig; do
  TARGET_PATH="$HOME/$FILE"
  if test -f "$TARGET_PATH"; then
    echo "$TARGET_PATH exists, skipping"
  fi
  ln -s "$SCRIPT_DIR/$FILE" "$TARGET_PATH"
done
# change shell
sudo chsh -s $(which zsh) $(whoami)

# copy vim snippets and dicts
cp -r "$SCRIPT_DIR/.vim" "$HOME/.vim"

# install MODERN tmux config
git submodule update --init
TARGET_PATH="$HOME/.tmux.conf"
if test -f "$TARGET_PATH"; then
  echo "$TARGET_PATH exists, skipping"
else
  ln -s "$SCRIPT_DIR/.tmux/.tmux.conf" "$TARGET_PATH"
fi

