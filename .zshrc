# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
if [[ $TERM != "linux" ]] ; then
    ZSH_THEME="powerlevel10k/powerlevel10k"
else
    ZSH_THEME="jonathan"
fi

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
#plugins=(git)
plugins=(git zsh-autosuggestions zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

# --- user configuration -------------------------------------------------------

setopt APPEND_HISTORY
setopt EXTENDED_HISTORY
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_SAVE_NO_DUPS

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi
export EDITOR='nvim'

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

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

# --- custom env variables -----------------------------------------------------

export XDG_CONFIG_HOME="$HOME/.config"

if [ -f $XDG_CONFIG_HOME/zsh/custom-env.zsh ]; then
    source $XDG_CONFIG_HOME/zsh/custom-env.zsh
fi

# --- pass completion ----------------------------------------------------------

# if [ -f $XDG_CONFIG_HOME/zsh/completions/pass-completion.zsh ]; then
#     source $XDG_CONFIG_HOME/zsh/completions/pass-completion.zsh
# fi

if command -v brew &> /dev/null ; then
    LLVM_PREFIX=$(brew --prefix llvm)
    if [ $LLVM_PREFIX"x" != "x" ] ; then
        export PATH="$LLVM_PREFIX/bin:$PATH"
    fi
fi

# --- better cd command --------------------------------------------------------

if command -v zoxide &> /dev/null ; then
    eval "$(zoxide init zsh)"
    alias cd="z"
fi

# --- open / attach tmux session with fzf --------------------------------------

# bindkey -s ^f "~/.config/tmux/bin/tmux-sessionizer\n"
alias ts="~/.config/tmux/bin/tmux-sessionizer"

# --- aliases ------------------------------------------------------------------

alias n="nvim"

alias psg="ps aux | grep -v grep | grep"

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

# sorted disk usage
alias dumb='du -shx * | sort -rhk1'
