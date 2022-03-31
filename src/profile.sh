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
	case $TERM in
		xterm-color|*-256color) color_prompt=yes ;;
		"linux")
			#Dracula theme
			printf %b '\e[40m' '\e[8]' # set default background to color 0 'dracula-bg'
			printf %b '\e[37m' '\e[8]' # set default foreground to color 7 'dracula-fg'
			printf %b '\e]P0282a36'    # redefine 'black'          as 'dracula-bg'
			printf %b '\e]P86272a4'    # redefine 'bright-black'   as 'dracula-comment'
			printf %b '\e]P1ff5555'    # redefine 'red'            as 'dracula-red'
			printf %b '\e]P9ff7777'    # redefine 'bright-red'     as '#ff7777'
			printf %b '\e]P250fa7b'    # redefine 'green'          as 'dracula-green'
			printf %b '\e]PA70fa9b'    # redefine 'bright-green'   as '#70fa9b'
			printf %b '\e]P3f1fa8c'    # redefine 'brown'          as 'dracula-yellow'
			printf %b '\e]PBffb86c'    # redefine 'bright-brown'   as 'dracula-orange'
			printf %b '\e]P4bd93f9'    # redefine 'blue'           as 'dracula-purple'
			printf %b '\e]PCcfa9ff'    # redefine 'bright-blue'    as '#cfa9ff'
			printf %b '\e]P5ff79c6'    # redefine 'magenta'        as 'dracula-pink'
			printf %b '\e]PDff88e8'    # redefine 'bright-magenta' as '#ff88e8'
			printf %b '\e]P68be9fd'    # redefine 'cyan'           as 'dracula-cyan'
			printf %b '\e]PE97e2ff'    # redefine 'bright-cyan'    as '#97e2ff'
			printf %b '\e]P7f8f8f2'    # redefine 'white'          as 'dracula-fg'
			printf %b '\e]PFffffff'    # redefine 'bright-white'   as '#ffffff'
			;;
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