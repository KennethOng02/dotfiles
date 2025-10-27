# Dotfiles

Personal configuration files managed using **GNU Stow**.  
This repository allows quick setup of a consistent development environment across multiple systems and clean updates through version control.

---

## 1. Prerequisites

Ensure the following are installed:

### Debian / Ubuntu

```bash
sudo apt update
sudo apt install -y stow git
```

### macOS

```bash
brew install stow git
```

### Fedora

```bash
sudo dnf install -y stow git
```

---

## 2. Installation (Fresh OS Setup)

### Step 1: Clone the Repository

Clone the dotfiles repo into your home directory to maintain correct relative paths.

```bash
git clone https://github.com/<your-username>/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
```

### Step 2: Apply Dotfiles

Use GNU Stow to symlink configurations into `$HOME`.

Apply specific modules:

```bash
stow bash
stow git
stow zsh
stow nvim
```

Or apply all available modules:

```bash
stow */
```

Each folder represents a configuration module (for example: `bash/`, `git/`, `nvim/`, `zsh/`).

---

## 3. Updating Dotfiles (Existing System)

When you’ve updated your dotfiles on another system or remotely:

### Step 1: Pull Latest Changes

```bash
cd ~/.dotfiles
git pull origin main
```

### Step 2: Restow Updated Configurations

```bash
stow -R */
```

If you only changed one module:

```bash
stow -R <module-name>
```

The `-R` flag tells Stow to reapply the links, updating them if paths have changed.

---

## 4. Modifying and Pushing Updates

Edit configurations directly in the repository, **not** in `$HOME`.

Example:

```bash
vim ~/.dotfiles/nvim/.config/nvim/init.lua
```

After confirming changes work:

```bash
cd ~/.dotfiles
git add .
git commit -m "update nvim configuration"
git push origin main
```

This keeps your configurations version-controlled and portable.

---

## 5. Removing Configurations

To remove a stowed module (unlink its symlinks):

```bash
cd ~/.dotfiles
stow -D <module-name>
```

Example:

```bash
stow -D zsh
```

---

## 6. Repository Structure

Example layout:

```
~/.dotfiles/
├── bash/
│   ├── .bashrc
│   └── .bash_aliases
├── git/
│   └── .gitconfig
├── nvim/
│   └── .config/nvim/
├── zsh/
│   └── .zshrc
└── ...
```

Each directory maps directly to `$HOME` when stowed.

---

## 7. Notes

- Always run `stow` commands **from within** the repository root.
- If your dotfiles repo isn’t inside `$HOME`, specify the target manually:

  ```bash
  stow -t ~ <module-name>
  ```

- Use `stow --no-folding` if you want to prevent directory merging.
- Backup or inspect existing configs before first-time installation.
