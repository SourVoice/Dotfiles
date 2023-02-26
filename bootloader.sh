#!/bin/bash

# Define variables
dotfiles_dir=$HOME/dotfiles

# Check if git is installed
if ! command -v git &> /dev/null
then
  echo "Error: Git is not installed. Please install git and try again."
  exit 1
fi

# Clone dotfiles repository
if [ ! -d "$dotfiles_dir"  ]
then
  git clone https://github.com/SourVoice/dotfiles.git $dotfiles_dir || {
    echo "Error: Failed to clone dotfiles repository. Please check your internet connection and try again."
    exit 1
  }
fi

# Update dotfiles repository
cd $dotfiles_dir
git pull origin master

# Install dotfiles
./install.sh

echo "Dotfiles installation complete."
