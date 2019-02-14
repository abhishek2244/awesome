alsi -l -f ~/.config/alsi/alsi.logo

export EDITOR=vim
export VISUAL=vim
HISTCONTROL=ignoreboth
HISTSIZE=1000
HISTFILESIZE=2000
shopt -s checkwinsize
shopt -s histappend
# bind 'set show-mode-in-prompt on'
#set -o vi
# shopt -s dotglob nullglob #( include hidden files in globs, but []regex fails)

function parse_hg_branch {
	hg branch 2> /dev/null 
}

function parse_git_branch {
	git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1 /'
}

function check_version_control {
	parse_git_branch
	(( $? )) || parse_hg_branch 
}

function motd(){
	if [ $(command -v fortune) ] && [ $(command -v cowsay) ]; then
		fortune | cowsay -f $(ls /usr/share/cows/ | shuf -n1)
	fi
}

function gitpulls(){
	clear
	echo "batch pull : $PWD"
	echo "------------"
	echo ""
	for dir in $(find . -name ".git")
	do cd ${dir%/*}
		echo $PWD
		git pull
		echo ""
		cd - > /dev/null
	done
}

PS1="\n\[\e[38;5;250m\]\[\e[48;5;240m\] \u \$(check_if_ssh_tty)\[\e[48;5;235m\]\[\e[38;5;240m\]\[\e[38;5;15m\]\[\e[48;5;235m\] \w \[\e[0m\]\[\e[38;5;235m\]\n\[\e[38;5;220m\]\[\e[48;5;236m\]\$(if [[ \$? == 0 ]]; then echo \" \$ \"; else echo \" x_x \"; fi)\$(check_version_control)\[\e[0m\]\[\e[38;5;236m\]\[\e[0m\] " 

if [ -x /usr/bin/dircolors ]; then
	test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
	alias ls='ls --color=auto'
	alias grep='grep --color=auto'
	alias fgrep='fgrep --color=auto'
	alias egrep='egrep --color=auto'
fi

if [ -f ~/.bash_aliases ]; then
	. ~/.bash_aliases
fi
if [ -f ~/.bash_exports ]; then
	. ~/.bash_exports
fi

alias ll="ls -l"
# motGd

export $(gnome-keyring-daemon --daemonize --start)
PATH=$PATH:/home/abhishek/.gem/ruby/2.4.0/bin
export PATH

function check_if_ssh_tty(){
	if [ $(who -m |grep -o "([0-9.]*)$") ] ; then echo '[SSH]'; fi
}
#PS1="\$(check_if_ssh_tty) #"

source /etc/profile.d/vte.sh
alias reapache="sudo systemctl restart httpd"
alias remysql="sudo systemctl restart mysqld"
alias rdpserver="xfreerdp /v:192.168.1.250  /u:abhishek -encryption"
export SLIMERJSLAUNCHER=~/Public/firefox_52/firefox/firefox
export ANDROID_HOME=/opt/android-sdk
export PATH=$PATH:$ANDROID_HOME/platform-tools
export PATH=$PATH:/home/abhishek/.gem/ruby/2.5.0/gems/bundler-1.16.4/exe
export PATH=$PATH:/home/abhishek/Public/gitin/gitin
export SONAR_SCANNER_HOME="/opt/sonar-scanner"
export PATH="${PATH}:${SONAR_SCANNER_HOME}/bin"

PATH="/home/abhishek/perl5/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="/home/abhishek/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/home/abhishek/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/home/abhishek/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/home/abhishek/perl5"; export PERL_MM_OPT;


export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
