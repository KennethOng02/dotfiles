# Dotfiles(Git Bare Repository)

## Install

```console
$ echo ".cfg" >> .gitignore
$ git clone --bare https://github.com/KennethOng02/dotfiles.git $HOME/.cfg
$ alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
$ config config --local status.showUntrackedFiles no
$ source $HOME/.zshrc
$ config checkout
```

## Usage
```console
$ config status
$ config add .zshrc
$ config commit -m "Add zshrc"
$ config push
```

## Reference
- [Dotfiles: Best way to store in a bare git repository](https://www.atlassian.com/git/tutorials/dotfiles)