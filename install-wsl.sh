#!/bin/bash
set -o pipefail
set -eux
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
PROGRESS_FILE="$HOME/.install-wsl-progress"
if test -f "$PROGRESS_FILE"; then
  echo "progress file exists, skipping creation"
else
  echo 0 > "$PROGRESS_FILE"
fi

# install packages
if [ "`cat $PROGRESS_FILE`" -lt "1" ]; then
  if [ $(awk -F= '/^NAME/{print $2}' /etc/os-release) == '"Ubuntu"' ]; then
    sudo apt update
    sudo apt upgrade -y
    sudo apt install -y git python-is-python3 tmux python3 python3-dev build-essential vim python3-virtualenv curl wget zsh
  fi
  echo 1 > "$PROGRESS_FILE"
fi

if [ "`cat $PROGRESS_FILE`" -lt "2" ]; then
  # oh my zsh
  sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  # install plugins
  zsh -c 'set -a && . $HOME/.zshrc && git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions'
  zsh -c 'set -a && . $HOME/.zshrc && git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k'
  
  # clean .zshrc since using own
  if test -f "$HOME/.zshrc"; then rm $HOME/.zshrc; fi
  echo 2 > "$PROGRESS_FILE"
fi

if [ "`cat $PROGRESS_FILE`" -lt "3" ]; then
  # link rc files
  for FILE in .vimrc .zshrc .ideavimrc .latexmkrc .gitconfig .p10k.zsh; do
    TARGET_PATH="$HOME/$FILE"
    if test -f "$TARGET_PATH"; then
      echo "$TARGET_PATH exists, skipping"
    else
      ln -s "$SCRIPT_DIR/$FILE" "$TARGET_PATH"
    fi
  done
  # copy vim snippets and dicts
  cp -r "$SCRIPT_DIR/.vim" "$HOME/.vim"
  echo 3 > "$PROGRESS_FILE"
fi
if [ "`cat $PROGRESS_FILE`" -lt "4" ]; then
  # change shell
  chsh -s $(which zsh)
  echo 4 > "$PROGRESS_FILE"
fi

# install MODERN tmux config
if [ "`cat $PROGRESS_FILE`" -lt "5" ]; then
  git submodule update --init
  TARGET_PATH="$HOME/.tmux.conf"
  if test -f "$TARGET_PATH"; then
    echo "$TARGET_PATH exists, skipping"
  else
    ln -s "$SCRIPT_DIR/.tmux/.tmux.conf" "$TARGET_PATH"
  fi
  echo 5 > "$PROGRESS_FILE"
fi

# if [ -z ${NO_GENIE+x} ]; then
#     # install genie
#     systemctl set-default multi-user.target
#     sudo apt install lsb-release
#     sudo wget -O /etc/apt/trusted.gpg.d/wsl-transdebian.gpg https://arkane-systems.github.io/wsl-transdebian/apt/wsl-transdebian.gpg

#     sudo chmod a+r /etc/apt/trusted.gpg.d/wsl-transdebian.gpg

#     sudo cat << EOF > /etc/apt/sources.list.d/wsl-transdebian.list
# deb https://arkane-systems.github.io/wsl-transdebian/apt/ $(sudo lsb_release -cs) main
# deb-src https://arkane-systems.github.io/wsl-transdebian/apt/ $(sudo lsb_release -cs) main
# EOF

#     sudo apt update
#     sudo apt install genie
#     # HACKS
#     sudo e2label /dev/sdb cloudimg-rootfs
#     sudo ssh-keygen -A
#     sudo systemctl disable multipathd
# cat << EOF > /etc/systemd/network/10-eth0.network
# [Match]
# Name=eth0

# [Link]
# Unmanaged=yes

# [Network]
# DHCP=no

# [DHCP]
# UseDNS=false
# EOF
# fi
