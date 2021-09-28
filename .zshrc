source ~/.profile
source ~/.aliases

export HISTFILE="$HOME/.zsh_history"
export HISTSIZE="1000000"
export SAVEHIST="1000000"

### Added by Zinit's installer
if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing %F{33}DHARMA%F{220} Initiative Plugin Manager (%F{33}zdharma/zinit%F{220})…%f"
    command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
    command git clone https://github.com/zdharma/zinit "$HOME/.zinit/bin" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
        print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zinit-zsh/z-a-rust \
    zinit-zsh/z-a-as-monitor \
    zinit-zsh/z-a-patch-dl \
    zinit-zsh/z-a-bin-gem-node

### End of Zinit's installer chunk

# Autosuggestions & fast-syntax-highlighting
zinit ice wait lucid atinit"zpcompinit; zpcdreplay"
zinit light zdharma/fast-syntax-highlighting
# zsh-autosuggestions
zinit ice wait lucid atload"!_zsh_autosuggest_start"
zinit load zsh-users/zsh-autosuggestions

zinit light 'ytet5uy4/fzf-widgets'

# Load OMZ Git library
zinit snippet OMZL::git.zsh
zinit cdclear -q # <- forget completions provided up to this moment

setopt promptsubst

# Load Git plugin from OMZ
zinit snippet OMZP::git

zinit ice pick"async.zsh" src"pure.zsh"
zinit light sindresorhus/pure

bindkey '^r'  fzf-insert-history
bindkey '^t'  fzf-insert-files

bindkey -v
