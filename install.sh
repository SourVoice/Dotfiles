#!/usr/bin/env bash

dotfiles_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "Creating $olddir for backup of any existing dotfiles in ~ ..."
olddir=~/dotfiles_old
mkdir -p $olddir
echo -e "\033[32mdone\033[0m"

# Check and install vim
if !command -v vim &> /dev/null; then 
  echo "Install vim..."
  sudo apt install -y vim
  echo -e "\033[32Install vim done.\033[0m"
fi

# Check and install curl
if !command -v curl &> /dev/null; then 
  echo "Install curl..."
  sudo apt install -y curl
  echo -e "\033[32Install curl done.\033[0m"
fi

# Check and install python3
if !command -v curl &> /dev/null; then 
  echo "Install python3..."
  sudo apt install -y python3
  echo -e "\033[32Install python3 done.\033[0m"
fi

echo "Check and Update vim version.."
vim_version=$(vim --version | grep -oP "Vi IMproved \K[0-9]+")
if (( $vim_version < 9 )); then
  # Update package cache
  sudo add-apt-repository -r ppa:jonathonf/vim
  sudo apt update

  # Install Vim
  sudo apt install vim
fi
echo -e "\033[32mdone\033[0m"

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
  if [[ $(echo -e "$CURRENT_NODE_VERSION\n$REQUIRED_NODE_VERSION" | sort -V | head -n1) != "$REQUIRED_NODE_VERSION" ]];
  then
	# If the installed version of Node.js is not the required version, update it
	echo "the installed version of Node.js is not the required version, update it"
	curl -sL https://deb.nodesource.com/setup_20.x | sudo -E bash -
	sudo apt-get install -y nodejs
  fi
fi
echo -e "\033[32mdone\033[0m"


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
echo -e "\033[32mdone\033[0m"

echo "Source the new BASH_SOURCE file..."
source $HOME/.bashrc
echo -e "\033[32mdone\033[0m"
echo -e "\033[31mDotfiles installation complete.\033[0m\n"
echo -e "\033[31mNow open vim to start initial vim.\033[0m"


