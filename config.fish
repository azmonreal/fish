if status is-interactive
    # Commands to run in interactive sessions can go here
end

set -Ux EDITOR "/usr/local/bin/nvim"
set -Ux SUDO_EDITOR "/usr/local/bin/nvim"
set -Ux MANPAGER "nvim +Man!"

alias clr="clear"
alias ext="exit"
# alias "history -t"="history --show-time=\"%Y-%m-%d %H:%M \""
function historya
	if test $argv = "-t"
		builtin history --show-time="%Y-%m-%d %H:%M " | echo
	else
		builtin history $argv | echo
	end
end

alias rm="rm -i"

function rm.
	read -l -P 'Are you sure you want to remove the current directory? [Y/n]' confirm

	switch $confirm
		case Y y
			set dir (basename $PWD)
			cd ..
			rm -rf $dir
			echo The directory \'$dir\' and all of it\'s contents have been removed
			set -e dir
		case '' N n
			return
	end
end

function mkcd
	command mkdir $argv
	cd $argv
end

alias vlime="sbcl -load ~/.local/share/nvim/site/pack/packer/start/vlime/lisp/start-vlime.lisp"

alias ls="exa --group-directories-first --icons"
alias la="exa -a --group-directories-first --icons"
alias ll="exa -la --group-directories-first --icons"
alias exatree="exa --tree --group-directories-first --icons"

alias ...="cd ../.."
alias ....="cd ../../.."

alias pacud="sudo pacman -Sy"
alias pacug="sudo pacman -Syu"

alias paci="sudo pacman -S"
alias pacr="sudo pacman -R"
alias pacs="sudo pacman -Ss"
alias pacl="sudo pacman -Q"
alias pacll="sudo pacman -Qi"

alias yayi="yay -S"
alias yayr="yay -R"
alias yays="yay -Ss"
alias yayl="yay -Q"
alias yayll="yay -Qi"

alias parui="paru -S"
alias parur="paru -R"
alias parus="paru -Ss"
alias parul="paru -Q"
alias parull="paru -Qi"

alias gita="git add"
alias gitc="git commit"
alias gitch="git checkout"
alias gitl="git log --graph"
alias gits="git status"
alias gitpl="git pull"
alias pitps="git push"

alias matrix="tmatrix -s 20 -C blue"
# alias greet="clr && neofetch"
alias greet="clr"

alias chrome="google-chrome-stable --force-dark-mode"

function ghclone
	git clone https://github.com/$argv
end

function cdc
	cd $argv && clear
end

function cdconf
	if count $argv > /dev/null
		if test -d ~/.config/$argv
		else
			read -l -P 'Dir does not exist. Do you want to create it? [y/N] ' confirm

			switch $confirm
				case Y y
					mkdir ~/.config/$argv
				case '' N n
					return
			end
		end
		cd ~/.config/$argv
	else
		cd ~/.config
	end
	return 0
end

function edconf
	if count $argv > /dev/null
		if test -d ~/.config/$argv
		else
			read -l -P 'Dir does not exist. Do you want to create it? [y/N] ' confirm

			switch $confirm
				case Y y
					mkdir ~/.config/$argv
				case '' N n
					return
			end
		end
		$EDITOR ~/.config/$argv
	else
		$EDITOR ~/.config
	end
	return 0
end

function fish_greeting
	# neofetch
	clear
end

function cargonew
	cargo new $argv
	cd $argv
end

zoxide init fish | source
