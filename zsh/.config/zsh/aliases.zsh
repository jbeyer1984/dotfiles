#!/bin/sh

alias szh="source ~/.config/zsh/.zshrc"
alias lth="ls -lt | head"
alias lath="ls -lt | head"
alias ltf="ls -lt | less"
alias latf="ls -lt | less"

alias lt='ls -lta'
pd() {
	if [ 1 = $# ]; then
		ls -d $PWD/$1 | xclip -r -sel clip
	else
		pwd | xclip -r -sel clip
	fi
}
pld() {
	basename $(pwd) | xclip -r -sel clip
}
function lta() {
	if [ -e $1 ]; then
		ls -lt $1
	else
		echo $1 | cut -c2- | xargs ls -lt
	fi
}
function lf() {
	if [ 1 = $# ]; then
		ls -td -1 "$1/"** | head -n 1
	else
		ls -td -1 "$PWD/"** | head -n 1
	fi
}
cdir () {
	folder=$1
	mkdir -p $folder
	cd $folder
}
function li() {
	if [ 1 = $# ]; then
		awk "NR==$1 {print \$NF}"
	else
		awk 'NR==1 {print $NF}'
	fi
}
function lis() {
	if [ 1 = $# ]; then
		awk "NR<=$1 {print \$NF}"
	else
		awk 'NR<10 {print $NF}'
	fi
}
syncGrep() {
	conpath=$1
	find=$2
	base=$(basename $conpath)
	rsync -av --list-only --exclude='*/*/*' $conpath/ ./ | grep $find | awk '{ print $5 }' | awk -F'/' '{print $NF}' | grep $find > to_download.txt
	rsync -avr --files-from=to_download.txt $conpath/ $base
}
syncLocalGrep() {
	conpath=$1
	find=$2
	rsync -av --list-only --exclude='*/*/*' $conpath/ ./ | grep $find | awk '{ print $5 }' | awk -F'/' '{print $NF}' | grep $find > to_download.txt
	rsync -avr --files-from=to_download.txt $conpath/ .
}



alias j='z'
alias f='zi'
alias g='lazygit'
alias zsh-update-plugins="find "$ZDOTDIR/plugins" -type d -exec test -e '{}/.git' ';' -print0 | xargs -I {} -0 git -C {} pull -q"
alias nvimrc='nvim ~/.config/nvim/'
alias nman='bob'
alias sshk="kitty +kitten ssh"
# alias lvim="env TERM=wezterm lvim"
# alias nvim="env TERM=wezterm nvim"

# Remarkable
alias remarkable_ssh='ssh root@10.11.99.1'
alias restream='restream -p'

# Colorize grep output (good for log files)
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

# confirm before overwriting something
alias cp="cp -i"
alias mv='mv -i'
alias rm='rm -i'

# easier to read disk
alias df='df -h'     # human-readable sizes
alias free='free -m' # show sizes in MB

# get top process eating memory
alias psmem='ps auxf | sort -nr -k 4 | head -5'

# get top process eating cpu ##
alias pscpu='ps auxf | sort -nr -k 3 | head -5'

# systemd
alias mach_list_systemctl="systemctl list-unit-files --state=enabled"

alias mach_java_mode="export SDKMAN_DIR="$HOME/.sdkman" && [[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh""


case "$(uname -s)" in

Darwin)
	# echo 'Mac OS X'
	alias ls='ls -G'
	;;

Linux)
	alias ls='ls --color=auto'
	;;

CYGWIN* | MINGW32* | MSYS* | MINGW*)
	# echo 'MS Windows'
	;;
*)
	# echo 'Other OS'
	;;
esac
