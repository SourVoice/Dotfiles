#!/usr/bin/env bash

dotfiles_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "Creating $olddir for backup of any existing dotfiles in ~ ..."
olddir=~/dotfiles_old
mkdir -p $olddir
echo "done"

echo   "Check and Update vim version.."
vim_version=$(vim --version | grep -oP "Vi IMproved \K[0-9]+")
if (( $vim_version < 9 )); then
  # Update package cache
  sudo add-apt-repository -r ppa:jonathonf/vim
  sudo apt update

  # Install Vim
  sudo apt install vim
fi
echo "done"

echo "Check and Install nodejs for coc.nvim plug..."
if ! command -v node &> /dev/null
then
  # If Node.js is not installed, install it
  echo "Node.js is not installed, install it..."
  curl -sL https://deb.nodesource.com/setup_14.x | sudo -E bash -
  sudo apt-get install -y nodejs
else
  # If Node.js is already installed, check the version
  echo "Node.js is already installed, check the version..."
  CURRENT_NODE_VERSION=($node -v)
  REQUIRED_NODE_VERSION="v14.0.0"
  if [[ "$CURRENT_NODE_VERSION" != "$REQUIRED_NODE_VERSION" ]];
  then
	# If the installed version of Node.js is not the required version, update it
	echo "the installed version of Node.js is not the required version, update it"
	curl -sL https://deb.nodesource.com/setup_14.x | sudo -E bash -
	sudo apt-get install -y nodejs
  fi
fi
echo "done"


# files=$(find . -type f -o -type d)
files=(
	.vim
	vscode
	.bash_profile
	.bash_prompt
	.bashrc
	.gitconfig
	.vimrc
	.tmux.conf
	.zshrc	
	install.sh
)


echo "Create symlinks in the home directory..."
# Create symlinks in the home directory

for file in "${files[@]}"; do
  source_file="$dotfiles_dir/$file"
  dest_file="$HOME/$file"

  echo "Moving any existing dotfiles from ~ to $olddir"
  if [[ -f "$dest_file" || -d "$dest_file" || -L "$dest_file"  ]]; then
	echo "Backing up existing file: $dest_file"
 	mv "$dest_file" $olddir
  fi

  echo "Creating symlink: $source_file -> $dest_file"
  ln -s "$source_file" "$dest_file"
done
echo "done"

echo "Source the new BASH_SOURCE file..."
source $HOME/.bashrc
echo "done"
echo "Dotfiles installation complete."
echo "Now open vim to start initial vim."


