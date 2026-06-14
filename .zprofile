# Homebrew environment
eval "$(/opt/homebrew/bin/brew shellenv)"

# NVM (Node Version Manager)
export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"

# Add active Node version to PATH if NVM is loaded
export PATH="$NVM_DIR/versions/node/$(nvm version 2>/dev/null || echo "none")/bin:$PATH"

export PATH="/usr/local/opt/mysql@8.0/bin:$PATH"

export PATH="$HOME/.local/bin:$PATH"

export JAVA_HOME=$(/usr/libexec/java_home)
export PATH=$JAVA_HOME/bin:$PATH
