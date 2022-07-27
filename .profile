# ~/.profile: executed by the command interpreter for login shells.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022
source /etc/profile

export GOPATH="$HOME/go"
export PATH="/usr/lib/distcc/bin:$PATH:$HOME/.cargo/bin:$GOPATH/bin:$HOME/.scripts:$HOME/bin"
export BROWSER="firefox"
export READER="zathura"
export MAKEFLAGS="-j$(nproc)"
export EDITOR="nvim"
export LESSOPEN="|lesspipe.sh %s"
export GTK_THEME=Adwaita:dark

# less colors
export LESS=-R
export LESS_TERMCAP_mb=$(tput bold; tput setaf 2) # green
export LESS_TERMCAP_md=$(tput bold; tput setaf 6) # cyan
export LESS_TERMCAP_me=$(tput sgr0)
export LESS_TERMCAP_so=$(tput bold; tput setaf 3; tput setab 4) # yellow on blue
export LESS_TERMCAP_se=$(tput rmso; tput sgr0)
export LESS_TERMCAP_us=$(tput smul; tput bold; tput setaf 7) # white
export LESS_TERMCAP_ue=$(tput rmul; tput sgr0)
export LESS_TERMCAP_mr=$(tput rev)
export LESS_TERMCAP_mh=$(tput dim)
export LESS_TERMCAP_ZN=$(tput ssubm)
export LESS_TERMCAP_ZV=$(tput rsubm)
export LESS_TERMCAP_ZO=$(tput ssupm)
export LESS_TERMCAP_ZW=$(tput rsupm)

# Start graphical server if Xorg not already running.
[ "$(tty)" = "/dev/tty1" ] && ! pgrep -x Xorg >/dev/null && exec startx
