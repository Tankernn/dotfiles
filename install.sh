#!/bin/sh

fancy_print() {
    printf "\033[31m#### $1\033[0m\n"
}

fancy_print "Linking dotfiles"
for f in ".*"
do
    case "$f" in
        *.git*) continue ;;
        *.swp)  continue ;;
    esac
    ln -s $(realpath $f) ~/
done

fancy_print "Sourcing .profile and .aliases"
. ./.profile
. ./.aliases

fancy_print "Installing packages"
xi -y $(cat packages.txt)

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
    mkdir -p "~/git$1";
    cd "~/git/$1";
    git clone "$2" .;
    make;
    sudo make install;
    )
}

fancy_print "Installing suckless forks"
git_make_install "st" "https://gogs.tankernn.eu/Tankernn/st.git"
git_make_install "dwm" "https://gogs.tankernn.eu/Tankernn/dwm.git"

printf "\033[31m"
figlet "Installation complete!"
printf "\033[0m"
