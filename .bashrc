# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples
[ -z "$PS1" ] && return
# {{{ Exports 
export MPD_HOST=127.0.0.1
export MPD_PORT=6600
export OOO_FORCE_DESKTOP=gnome
export DISPLAY=":0"
export PATH=$PATH:$HOME/bin:$HOME/scripts:/usr/games
export FLASH_FORCE_PULSEAUDIO="1"
export LANG=uk_UA.UTF-8
export LC_ALL=uk_UA.UTF-8
export GTK2_RC_FILES=$HOME/.gtkrc-2.0
export EDITOR="vim"
#}}}
shopt -s checkwinsize
[ -x /usr/bin/lesspipe ] && eval "$(lesspipe)"
eval `dircolors -b ~/.dircolors`
shopt -s histverify  extglob cmdhist
shopt -u promptvars sourcepath
set -o noclobber
#kill flow control
if tty -s ; then
    stty -ixon
    stty -ixoff
fi
complete -cf sudo         # sudo tab-completion
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi
# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi
# {{{ Alias
alias trnm=" transmission-remote mybook:9091"
alias awesome-restart='echo "awesome.restart()"|awesome-client'
alias rm="rm -i"
alias ls='ls --color'
alias dir='ls --color --format=vertical'
alias ll='ls -lha'
alias la='ls -A'
alias l='ls -CF'
alias cdd="cd .."
alias lss="ls -shaC"
alias r='fc -s'
alias o="netstat -tuael --numeric-hosts --numeric-ports"
alias lsnet="sudo lsof -i4 -P -T"
alias du="du -h"
alias df="df -h"
alias h="history 24"
alias ssu="sudo bash"
alias d='dirs -v'
alias pst='pstree -G |more'
alias toprun="ps axo %cpu,%mem,comm |sort -unr| head -n 9"
alias psaux="ps aux"
alias ps_top="ps -eo pcpu,pid,user,args | sort -k 1 -r | head -10"
alias lls='ls -ahl $1 | more; echo "\e[1;32m --[\e[1;34m Dirs:\e[1;36m `ls -al $1 | egrep \"^drw\" | wc -l` \e[1;32m|\e[1;35m Files: \e[1;31m`ls -al | egrep -v \"^drw\" | grep -v total | wc -l` \e[1;32m]--"'

alias cxwine="/home/grishka/stuff/cxoffice/bin/wine"
alias weather="clweather -s UKKK"
alias muttgmail="mutt -F $HOME/.mutt/muttrc.gmail"
#}}}
#{{{ Functions
# viewing man pages
function man 
{
  /usr/bin/man $* | col -bp | iconv -c | view -c 'set ft=man nomod nolist' -
}
roll () {
    FILE=$1
    case $FILE in
        *.tar.bz2) shift && tar cjf $FILE $* ;;
        *.tar.gz) shift && tar czf $FILE $* ;;
        *.tgz) shift && tar czf $FILE $* ;;
        *.zip) shift && zip $FILE $* ;;
        *.rar) shift && rar $FILE $* ;;
    esac
}

extract_ () {
    if [ -f $1 ] ; then
        case $1 in
            *.tar.bz2)  tar xjf $1      ;;
            *.tar.gz)   tar xzf $1      ;;
            *.bz2)      bunzip2 $1      ;;
            *.rar)      rar x $1        ;;
            *.gz)       gunzip $1       ;;
            *.tar)      tar xf $1       ;;
            *.tbz2)     tar xjf $1      ;;
            *.tgz)      tar xzf $1      ;;
            *.zip)      unzip $1        ;;
            *.Z)        uncompress $1   ;;
            *)          echo "'$1' cannot be extracted via extract()" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

pskill () {
    if [ ! -z $1 ] ; then
        local pid
        pid=$(ps ax | grep $1 | grep -v grep | awk '{ print $1 }')
        if [ x$pid != x ] ; then
            echo -n ">> Killing $1 (process $pid)... "
            kill -9 $pid
            echo "slaughtered"
        else
            echo "!! Process not found"
        fi
    else
        echo "!! Need process name"
    fi
}

psgrep() {
    if [ ! -z $1 ] ; then
        echo "Grepping for processes matching $1..."
        ps ax | grep $1 | grep -v grep
    else
        echo "!! Need name to grep for"
    fi
}

function search()
{
 	case "$1" in
 		-g) w3m http://www.google.com/search\?q=$2
 		;;
 		-u) w3m http://groups.google.com/groups\?q=$2
 		;;
 		-m) w3m http://groups.google.com/groups\?selm=$2
 		;;
 		-a) w3m http://groups.google.com/groups\?as_uauthors=$2
 		;;
 		-c) w3m http://search.cpan.org/search\?query=$2\&mode=module
 		;;
 		-f) w3m http://freshmeat.net/search/\?q=$2\&section=projects
 		;;
 		-s) w3m "http://sourceforge.net/search/?type_of_search=soft&type_of_search=soft&words=$2"
 		;;
 		-w) w3m http://ru.wikipedia.org/wiki/$2
 		;;
 		-W) w3m http://en.wikipedia.org/wiki/$2
 		;;
 		*) 
 		  echo "Usage: $0 {-g | -u | -m | -a | -f | -c | -F | -s | -w | -W | -d}"
 		  echo "	-g:  Searching for keyword in google.com"
 		  echo "	-u:  Searching for keyword in groups.google.com"
 		  echo "	-m:  Searching for message-id in groups.google.com"
 		  echo "	-a:  Searching for Authors in groups.google.com"
 		  echo "	-c:  Searching for Modules on cpan.org."
 		  echo "	-f:  Searching for projects on Freshmeat."
 		  echo "	-F:  Searching for packages on FileWatcher."
 		  echo "	-G:  Gentoo file search."
 		  echo "	-s:  Searching for software on Sourceforge."
 		  echo "	-w:  Searching for keyword at wikipedia (german)."
 		  echo "	-W:  Searching for keyword at wikipedia (english)."
 		  echo "	-d:  Query dict.leo.org ;)"
 	esac
}
#}}}
#{{{ Prompt
if [[ ${EUID} == 0 ]] ; then
	PS1='\[\033[01;31m\]\h\[\033[01;34m\] \W \$\[\033[0m\] '
else
    PS1="\[\033[0;33m\]\u@\h\[\033[01;34m\] \W \n\$ \[\033[0m\]"
fi

export PROMPT_COMMAND='echo -ne "\033]2;$LOGNAME@$HOSTNAME    $PWD\007\033]1;$LOGNAME@$HOST\007"'

#}}}
# vim: set fdm=marker tabstop=4 shiftwidth=4 expandtab smarttab autoindent smartindent nu:
