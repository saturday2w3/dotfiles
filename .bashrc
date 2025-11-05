#
# ~/.bashrc
#


# If not running interactively, don't do anything
[[ $- != *i* ]] && return

~/.local/bin/wallpaper-watcher.sh &


# Aliases
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias bart='python3 bart.py'
alias calc='python3 calculator.py'
alias tung='python3 tung.py'

# Prompt
PS1='[\u@\h \W]\$ '

# Add custom paths
export PATH=$PATH:/home/saturday2/.spicetify

# Starship prompt
eval "$(starship init bash)"

# === Pywal integration ===
# Load shell variables (optional, mostly for scripts)
[ -f ~/.cache/wal/colors.sh ] && source ~/.cache/wal/colors.sh

# Apply colors to Kitty only if running inside Kitty
if [ ! -z "$KITTY_WINDOW_ID" ] && [ -f ~/.cache/wal/kitty.conf ]; then
    kitty @ set-colors --all ~/.cache/wal/kitty.conf
fi

# Only run neofetch if in an interactive shell
if [ -t 1 ]; then
    neofetch
fi
export PATH="$HOME/.local/bin:$PATH"

