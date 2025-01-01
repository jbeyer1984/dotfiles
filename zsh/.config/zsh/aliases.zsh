#!/bin/sh

alias szh="source ~/.zshrc"
alias vzh="nvim ~/.zshrc"
alias lth="ls -lt | head"
alias lath="ls -lt | head"
alias ltf="ls -lt | less"
alias latf="ls -lt | less"
alias sai="sudo nala install"
alias sas="sudo nala search"
alias cc="xclip -i -r -sel clip"
alias nva="nvim /home/jens/.config/zsh/aliases.zsh"


export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"

# Use fd (https://github.com/sharkdp/fd) for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
_fzf_compgen_path() {
  fd --hidden --exclude .git . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type=d --hidden --exclude .git . "$1"
}

show_file_or_dir_preview="if [ -d {} ]; then eza --tree --color=always {} | head -200; else bat -n --color=always --line-range :500 {}; fi"

export FZF_CTRL_T_OPTS="--preview '$show_file_or_dir_preview'"
export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"

# Advanced customization of fzf options via _fzf_comprun function
# - The first argument to the function is the name of the command.
# - You should make sure to pass the rest of the arguments to fzf.
_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf --preview 'eza --tree --color=always {} | head -200' "$@" ;;
    export|unset) fzf --preview "eval 'echo ${}'"         "$@" ;;
    ssh)          fzf --preview 'dig {}'                   "$@" ;;
    *)            fzf --preview "$show_file_or_dir_preview" "$@" ;;
  esac
}

fzf_history_copy() {
  local num_entries=150  # Adjust this number to show more or fewer entries
  local selected=$(history | tail -n $num_entries | fzf --tac --no-sort --multi)
  if [ -n "$selected" ]; then
    echo "$selected" | sed 's/^ *[0-9]* *//' | xclip -selection clipboard
    echo "Copied to clipboard."
  fi
}
alias hc='fzf_history_copy'


alias lt='eza --group-directories-first -lt modified'

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
		ls -lat $1
	else
		echo $1 | cut -c2- | xargs ls -lat
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
