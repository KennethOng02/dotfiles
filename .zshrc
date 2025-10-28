export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="josh"
plugins=(git)

# Load Oh-My-Zsh
source $ZSH/oh-my-zsh.sh

# Locale
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# Preferred editor
export EDITOR=$([ -n "$SSH_CONNECTION" ] && echo vim || echo nvim)

# Compilation flags
export CPPFLAGS="-I/opt/homebrew/opt/openjdk/include"

# Aliases and functions
[ -f ~/.zsh/aliases.zsh ] && source ~/.zsh/aliases.zsh
[ -f ~/.zsh/functions.zsh ] && source ~/.zsh/functions.zsh

# Syntax highlighting & autosuggestions
[ -f /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ] && \
    source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
[ -f /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh ] && \
    source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# Shell completions
eval "$(zoxide init zsh)"
eval "$(uv generate-shell-completion zsh)"
eval "$(pyenv init - zsh)"
