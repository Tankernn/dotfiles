#!/bin/sh

fancy_print() {
    printf "\033[31m#### %s\033[0m\n" "$1"
}

fancy_print "Linking dotfiles"
for f in .*
do
    case "$f" in
        .) continue ;;
        ..) continue ;;
        .git) continue ;;
        *.swp) continue ;;
    esac
    ln -s "$(realpath "$f")" ~/
done

prompt()
{
    while true
    do
        printf "%s [y/n] " "$1"
        read -r yn
        case $yn in
            [Yy]* ) return 0;;
            [Nn]* ) return 1;;
            * ) echo "Please answer yes or no.";;
        esac
    done
}

git_make_install()
{
    (
    mkdir -p "$HOME/git/$1"
    cd "$HOME/git/$1" || return
    git clone "$2" .
    make
    sudo make install
    )
}

fancy_print "Installing Oh My Zsh"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
# Replace default Oh My Zsh config
ln -sf "$(realpath .zshrc)" ~

fancy_print "Installing Oh My Zsh plugins"
git clone https://github.com/zsh-users/zsh-autosuggestions "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions"
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting"

fancy_print "Installing fzf"
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install --key-bindings --completion --no-update-rc

fancy_print "Installing vim-plug"
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

fancy_print "Installing suckless forks"
if prompt "Install st and dwm?" ; then
    git_make_install "st" "https://gogs.tankernn.eu/Tankernn/st.git"
    git_make_install "dwm" "https://gogs.tankernn.eu/Tankernn/dwm.git"
fi
prompt "Install mpv prescalers?" && git_make_install "mpv-prescalers" "https://github.com/bjin/mpv-prescalers.git"

printf "\033[31m"
figlet "Installation complete!"
printf "\033[0m"
