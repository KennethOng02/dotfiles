# Homebrew environment
eval "$(/opt/homebrew/bin/brew shellenv)"

# NVM (Node Version Manager)
export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"

# OpenJDK path
export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"

# Add active Node version to PATH if NVM is loaded
export PATH="$NVM_DIR/versions/node/$(nvm version 2>/dev/null || echo "none")/bin:$PATH"

export STARSHIP_CONFIG=~/.config/starship/starship.toml

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
if command -v pyenv 1>/dev/null 2>&1; then
    eval "$(pyenv init --path)"
    eval "$(pyenv init -)"
    eval "$(pyenv virtualenv-init -)"
fi

export PATH="/usr/local/opt/mysql@8.0/bin:$PATH"
