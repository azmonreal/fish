set -x XDG_DATA_HOME ~/.local/share
set -x XDG_CONFIG_HOME ~/.config
set -x XDG_STATE_HOME ~/.local/state
set -x XDG_CACHE_HOME ~/.cache

set -x EDITOR $(which nvim)
set -x SUDO_EDITOR $(which nvim)
# set -Ux MANPAGER "nvim +Man!"

set -x FZF_DEFAULT_COMMAND "fd"

fish_add_path ~/.local/bin/
fish_add_path ~/.local/scripts/

if status is-interactive
	alias rm="rm -i"

	alias vlime="sbcl -load ~/.local/share/nvim/site/pack/packer/start/vlime/lisp/start-vlime.lisp"

	alias ls="exa --group-directories-first --icons"
	alias la="exa -a --group-directories-first --icons"
	alias ll="exa -la --group-directories-first --icons"
	alias tree="exa --tree --group-directories-first --icons"

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

	# alias "history -t"="history --show-time=\"%Y-%m-%d %H:%M \""
	function historya
		if test $argv = "-t"
			builtin history --show-time="%Y-%m-%d %H:%M " | echo
		else
			builtin history $argv | echo
		end
	end

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
	end

	function cargonew
		cargo new $argv
		cd $argv
	end

	function echo_prompt --on-event fish_postexec
		echo ""
	end

	zoxide init fish | source
	starship init fish | source

	if test -z "$TMUX"; tmux new-session; end
end
