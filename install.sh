#!/usr/bin/env bash
# Setup script for setting up a new macos machine
echo "Starting setup"

# install xcode CLI
xcode-select —-install

# Check for Homebrew to be present, install if it's missing
if test ! $(which brew); then
    echo "Installing homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Update homebrew recipes
brew update

PACKAGES=(
  neovim
  poetry
  exa
  bat
)
echo "Installing packages..."
brew install ${PACKAGES[@]}

echo "Cleaning up..."
brew cleanup

echo "Installing cask..."
CASKS=(
  iterm2
  spotify
  discord
)
echo "Installing cask apps..."
brew install --cask ${CASKS[@]}

echo "Configuring OS..."

defaults write com.apple.dock static-only -bool TRUE; killall Dock
defaults write com.apple.dock showhidden -bool TRUE; killall Dock
defaults write com.apple.dock mineffect suck; killall Dock

echo "Configure Dotfiles"
git clone --bare git@github.com:KennethOng02/dotfiles.git $HOME/.dotfiles
alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
echo ".dotfiles" >> .gitignore
config checkout
config config status.showUntrackedFiles no

echo "Macbook setup completed!"
