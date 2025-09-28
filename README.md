# ZSH Plugins

## Installation

Install the following plugins by cloning their repositories into the `~/.config/zsh/plugins` directory.

### zsh-autosuggestions
```sh
git clone https://github.com/zsh-users/zsh-autosuggestions ${XDG_CONFIG_HOME:-$HOME/.config}/zsh/plugins/zsh-autosuggestions
```

### zsh-syntax-highlighting
```sh
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${XDG_CONFIG_HOME:-$HOME/.config}/zsh/plugins/zsh-syntax-highlighting
```

Add plugins in `~/.zshrc`:

```sh
if [ -f ${XDG_CONFIG_HOME:-$HOME/.config}/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
    source ${XDG_CONFIG_HOME:-$HOME/.config}/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
fi

if [ -f ${XDG_CONFIG_HOME:-$HOME/.config}/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
    source ${XDG_CONFIG_HOME:-$HOME/.config}/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi
```

Restart terminal or run command again:

```sh
source ~/.zshrc
```
