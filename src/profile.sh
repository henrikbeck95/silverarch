##############################
#SilverArch shell profile
##############################

settings_shell_any(){
	#User specific environment
	if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
	    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
	fi

	export PATH
	
	#Set a fancy prompt (non-color, unless we know we 'want' color)
	case \"$TERM\" in
		xterm-color|*-256color) color_prompt=yes ;;
	esac

	#ASDF definitions
	if [[ -f $HOME/.asdf/asdf.sh ]]; then
		source $HOME/.asdf/asdf.sh
	fi

	#Default applications
	export EDITOR='vim'

	#Shortcut for commands
	alias '..'='cd ../'
	alias '...'='cd ../../'
	alias e='exit'
	alias ll='ls -lah'
	alias lr='ls -lahR'

	#OhMyPosh!
	export OH_MY_POSH_THEME="$HOME/.poshthemes/aliens.omp.json"
	#export OH_MY_POSH_THEME="$HOME/.poshthemes/velvet.omp.json"
}

settings_shell_bash(){
	#Source global definitions
	if [ -f /etc/bashrc ]; then
		source /etc/bashrc
	fi

	#ASDF definitions
	source $HOME/.asdf/completions/asdf.bash

	#OhMyPosh!
	case $TERM in
		"xterm-256color")
			#export_poshconfig "$OH_MY_POSH_THEME" json
			eval "$(oh-my-posh --init --shell bash --config $OH_MY_POSH_THEME)"
			;;
		*) : ;;
	esac
}

settings_shell_zsh(){
	#ASDF definitions
	fpath=(${ASDF_DIR}/completions $fpath) #Append completions to fpath
	autoload -Uz compinit && compinit #Initialise completions with ZSH's compinit

	#OhMyPosh!
	case $TERM in
		"xterm-256color")
			#export_poshconfig "$OH_MY_POSH_THEME" json
			eval "$(oh-my-posh --init --shell zsh --config $OH_MY_POSH_THEME)"
			;;
		*) : ;;
	esac
}

settings_shell_any

#User specific environment and startup programs
case $SHELL in
	"/bin/bash" | "/usr/bin/bash") settings_shell_bash ;;
	"/bin/zsh" | "/usr/bin/zsh") settings_shell_zsh ;;
	*) : ;;
esac