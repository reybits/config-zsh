# Oh My Zsh
```sh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

# PowerLevel10K Theme
```sh
git clone https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k
```

Set theme in `~/.zshrc`:
```sh
ZSH_THEME="powerlevel10k/powerlevel10k"
```

# Configure PowerLevel10K

Restart terminal or run command:
```sh
source ~/.zshrc
```

You should now be seeing the PowerLevel10K configuration process. If you don't, run the following:
```sh
p10k configure
```

# ZSH Plugins
### zsh-autosuggestions
```sh
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
```

### zsh-syntax-highlighting
```sh
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
```

Set plugins in `~/.zshrc`:
```sh
plugins=(git zsh-autosuggestions zsh-syntax-highlighting)
```

Restart terminal or run command again:
```sh
source ~/.zshrc
```
