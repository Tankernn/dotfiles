#!/bin/sh

fancy_print() {
    printf "\033[31m#### $1\033[0m\n"
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
    ln -s $(realpath $f) ~/
done

fancy_print "Installing packages"
sudo xbps-install -Suy $(cat packages.txt)

fancy_print "Installing optional software"

prompt_install()
{
    while true
    do
        echo -n "Install $1? [y/n] "
        read yn
        case $yn in
            [Yy]* ) xi -y $1; break;;
            [Nn]* ) break;;
            * ) echo "Please answer yes or no.";;
        esac
    done
}

for line in $(cat optional_packages.txt)
do
    prompt_install "$line"
done

git_make_install()
{
    (
    mkdir -p "$HOME/git/$1"
    cd "$HOME/git/$1"
    git clone "$2" .
    make
    sudo make install
    )
}

fancy_print "Installing Oh My Zsh"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
# Replace default Oh My Zsh config
ln -sf $(realpath .zshrc) ~

fancy_print "Installing vim-plug"
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

fancy_print "Installing suckless forks"
git_make_install "st" "https://gogs.tankernn.eu/Tankernn/st.git"
git_make_install "dwm" "https://gogs.tankernn.eu/Tankernn/dwm.git"

printf "\033[31m"
figlet "Installation complete!"
printf "\033[0m"
