#!/bin/sh

echo "Starting setup"

# install xcode CLI
xcode-select —-install

# Check for Homebrew to be present, install if it's missing
if test ! $(which brew); then
    echo "Installing homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    (echo; echo 'eval "$(/opt/homebrew/bin/brew shellenv)"') >> /Users/kenneth/.zprofile
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

brew update

echo "Installing most applications with Homebrew and Mac App Store CLI"
brew bundle --global

# Alacritty
mkdir -p ~/.config/alacritty/themes
git clone https://github.com/alacritty/alacritty-theme ~/.config/alacritty/themes

# vscode neovim enable press and hold
defaults write -g ApplePressAndHoldEnabled -bool false

defaults write com.apple.dock autohide -bool true && killall Dock
defaults write com.apple.dock tilesize -integer 35 && killall Dock

# tmux
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

echo "Cleaning..."
~/.cleanup
