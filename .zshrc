# --- set config home variable -------------------------------------------------

export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:-$HOME/.config}

# --- history configuration ----------------------------------------------------

export HISTSIZE=10000       # number of commands to remember in the command history
export SAVEHIST=10000       # number of history entries to save to the history file

setopt APPEND_HISTORY       # append to the history file, don't overwrite it
setopt INC_APPEND_HISTORY   # write each command to the history file as soon as it is entered
setopt EXTENDED_HISTORY     # save timestamp of each command in history file
setopt HIST_IGNORE_ALL_DUPS # remove older duplicate entries from history
setopt HIST_IGNORE_SPACE    # ignore commands that start with space

# --- enable emacs keybindings -------------------------------------------------

bindkey -e

# --- search command history by typing the initial letters ---------------------

bindkey '^P' history-beginning-search-backward
bindkey '^N' history-beginning-search-forward

bindkey '^[[A' history-beginning-search-backward
bindkey '^[[B' history-beginning-search-forward

# --- set language environment -------------------------------------------------

# export LANG=en_US.UTF-8

# --- preferred editor for local and remote sessions ---------------------------

# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi
export EDITOR='nvim'
export VISUAL='nvim'

# --- fzf support --------------------------------------------------------------

configureFZF() {
    export FZF_DEFAULT_OPTS='--height 75% --layout=reverse --border --no-hscroll --info inline-right'

    # prefer fd
    if command -v fd &> /dev/null ; then
        export FZF_DEFAULT_COMMAND="fd --ignore-vcs -tl -tf"
        export FZF_ALT_C_COMMAND="fd --ignore-vcs -tl -td"
    else
        # use ripgrep
        if command -v rg &> /dev/null ; then
            export FZF_DEFAULT_COMMAND='rg --follow --ignore-vcs --files'
        fi
    fi

    export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
}

if command -v fzf &> /dev/null ; then
    # Argument '--zsh' available starting v0.48
    eval "$(fzf --zsh 2>/dev/null)"

    configureFZF

elif [ -f ~/.fzf.zsh ] ; then
    # Used when installing fzf from a custom source or location
    source ~/.fzf.zsh

    configureFZF
fi

# --- extract files from any archive -------------------------------------------
# Usage: ex <archive_name>

ex()
{
    if [ -f $1 ] ; then
        case $1 in
            *.tar.bz2) tar xjf $1 ;;
            *.tar.gz) tar xzf $1 ;;
            *.bz2) bunzip2 $1 ;;
            *.rar) unrar x $1 ;;
            *.gz) gunzip $1 ;;
            *.tar) tar xf $1 ;;
            *.tbz2) tar xjf $1 ;;
            *.tgz) tar xzf $1 ;;
            *.zip) 7zz x $1 ;;
            *.Z) uncompress $1 ;;
            *.7z) 7zz x $1 ;;
            *) echo "'$1' cannot be extracted via extract()" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

# --- zsh autosuggestions ------------------------------------------------------

if [ -f $XDG_CONFIG_HOME/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
    source $XDG_CONFIG_HOME/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
fi

# --- zsh syntax highlighting --------------------------------------------------

if [ -f $XDG_CONFIG_HOME/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
    source $XDG_CONFIG_HOME/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

# --- git completion -----------------------------------------------------------

autoload -Uz compinit && compinit

# --- enable menu selection ----------------------------------------------------

zstyle ':completion:*' menu select

# --- pass completion ----------------------------------------------------------

# if [ -f $XDG_CONFIG_HOME/zsh/completions/pass-completion.zsh ]; then
#     source $XDG_CONFIG_HOME/zsh/completions/pass-completion.zsh
# fi

# --- export LLVM path ---------------------------------------------------------

if command -v brew &> /dev/null ; then
    LLVM_PREFIX=$(brew --prefix llvm)
    if [ $LLVM_PREFIX"x" != "x" ] ; then
        export PATH="$LLVM_PREFIX/bin:$PATH"
    fi
fi

# --- better cd command --------------------------------------------------------

if command -v zoxide &> /dev/null ; then
    eval "$(zoxide init zsh)"
    alias cd='z'
fi

# --- open / attach tmux session with fzf --------------------------------------

ts() {
  ~/.config/tmux/bin/tmux-sessionizer
}
zle -N ts
bindkey '^f' ts

# --- convienient process searching and killing --------------------------------

alias psg='ps aux | grep -v grep | grep'

psf() {
    ps -Ar -o user,pid,ppid,start,time,command | fzf --query=$@ \
        --header 'CTRL-R -> refresh, CTRL-Y -> kill' \
        --header-lines=1 --height=75% --layout=reverse \
        --info inline-right --border --nth=1,2,6 \
        --no-hscroll \
        --preview 'echo {2} {6..}' --preview-window up:2:wrap:follow \
        --bind 'ctrl-r:reload(ps -Ar -o user,pid,ppid,start,time,command)' \
        --bind 'ctrl-y:reload(kill {2} || ps -Ar -o user,pid,ppid,start,time,command)'
}

# --- rest of aliases ----------------------------------------------------------

alias ls='ls --color=auto'
alias la='ls -lathr --color=auto'

alias n='nvim'

alias e='exit'

# sorted disk usage
alias dumb='du -shx * | sort -rhk1'

# --- custom env variables -----------------------------------------------------

if [ -f $XDG_CONFIG_HOME/zsh/custom-env.zsh ]; then
    source $XDG_CONFIG_HOME/zsh/custom-env.zsh
fi

# --- starship prompt configuration --------------------------------------------

if command -v starship &> /dev/null ; then
    export STARSHIP_CONFIG=$XDG_CONFIG_HOME/starship/starship.toml
    eval "$(starship init zsh)"
else
    echo "Install starship to enable prompt."
fi
