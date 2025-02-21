if [ -f /opt/homebrew/bin/brew ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

if [ -d ~/tools ]; then
    export PATH=~/tools:$PATH
fi
