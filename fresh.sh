#!/bin/sh

echo "Setting up your Mac..."

# Check for Oh My Zsh and install if we don't have it
if test ! $(which omz); then
  /bin/sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/HEAD/tools/install.sh)"
fi

# Check for Homebrew and install if we don't have it
if test ! $(which brew); then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> $HOME/.zprofile
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Removes .zshrc from $HOME (if it exists) and symlinks the .zshrc file from the .dotfiles
rm -rf $HOME/.zshrc
ln -sw $HOME/.dotfiles/.zshrc $HOME/.zshrc

# Removes .hyper.js from $HOME (if it exists) and symlinks the .hyper.js file from the .dotfiles
rm -rf $HOME/.hyper.js
ln -sw $HOME/.dotfiles/.hyper.js $HOME/.hyper.js

# Removes .gitignore_global from $HOME (if it exists) and symlinks the .gitignore_global file from the .dotfiles
rm -rf $HOME/.gitignore_global
ln -sw $HOME/.dotfiles/.gitignore_global $HOME/.gitignore_global

# Removes .gitconfig from $HOME (if it exists) and symlinks the .gitconfig file from the .dotfiles
rm -rf $HOME/.gitconfig
cp $HOME/.dotfiles/.gitconfig $HOME/.gitconfig

# Update Homebrew recipes
brew update

# Install all our dependencies with bundle (See Brewfile)
brew tap homebrew/bundle
brew bundle --file ./Brewfile

# Create a projects directories
mkdir $HOME/Code
mkdir $HOME/Herd

# Set macOS preferences - we will run this last because this will reload the shell
source ./.macos
