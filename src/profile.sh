##############################
#SilverArch shell profile
##############################

settings_alias(){
	#Default applications
	export EDITOR='vim'

	#Editing files
	alias vim_history="vim -O $HOME/.bash_history $HOME/.zsh_history"
	alias vim_merge="vim -O $HOME/.bash_history $HOME/.zsh_history $HOME/.profile"
	alias vim_profile="vim -O $HOME/.profile $HOME/.zshrc"

	#System and package managers
	alias sudo='sudo '
	alias apt='pacman'
	alias dnf='pacman'

	#Shortcut for commands
	alias '..'='cd ../'
	alias '...'='cd ../../'
	alias '....'='cd ../../../'
	alias '.....'='cd ../../../../'
	alias '......'='cd ../../../../../'
	
	alias cls='clear'
	alias e='exit'
	alias ll='ls -lah'
	alias lr='ls -lahR'
	alias ls='ls --color=auto'

	#Flatpak alias
	alias code='flatpak run com.visualstudio.code'
	alias eclipse='flatpak run org.eclipse.Java'
	alias firefox='flatpak run org.mozilla.firefox'
	alias gedit='flatpak run org.gnome.gedit'
	alias kate='flatpak run org.kde.kate'
	alias obs='flatpak run com.obsproject.Studio'

	#Clipboard content
	alias pbcopy='xclip -selection clipboard' #Copy output to clipboard
	alias pbpaste='xclip -selection clipboard -o' #Paste clipboard content
}

settings_oh_my_posh_theme(){
	export OH_MY_POSH_THEME="$HOME/.poshthemes/aliens.omp.json"
	#export OH_MY_POSH_THEME="$HOME/.poshthemes/velvet.omp.json"
	#export OH_MY_POSH_THEME="$HOME/.poshthemes/M365Princess.omp.json"
	#export OH_MY_POSH_THEME="$HOME/.poshthemes/agnoster.omp.json"
	#export OH_MY_POSH_THEME="$HOME/.poshthemes/agnosterplus.omp.json"
	#export OH_MY_POSH_THEME="$HOME/.poshthemes/amro.omp.json"
	#export OH_MY_POSH_THEME="$HOME/.poshthemes/atomic.omp.json"
	#export OH_MY_POSH_THEME="$HOME/.poshthemes/atomicBit.omp.json"
	#export OH_MY_POSH_THEME="$HOME/.poshthemes/avit.omp.json"
	#export OH_MY_POSH_THEME="$HOME/.poshthemes/blue-owl.omp.json"
	#export OH_MY_POSH_THEME="$HOME/.poshthemes/blueish.omp.json"
	#export OH_MY_POSH_THEME="$HOME/.poshthemes/bubbles.omp.json"
	#export OH_MY_POSH_THEME="$HOME/.poshthemes/bubblesextra.omp.json"
	#export OH_MY_POSH_THEME="$HOME/.poshthemes/bubblesline.omp.json"
	#export OH_MY_POSH_THEME="$HOME/.poshthemes/capr4n.omp.json"
	#export OH_MY_POSH_THEME="$HOME/.poshthemes/cert.omp.json"
	#export OH_MY_POSH_THEME="$HOME/.poshthemes/cinnamon.omp.json"
	#export OH_MY_POSH_THEME="$HOME/.poshthemes/clean-detailed.omp.json"
	#export OH_MY_POSH_THEME="$HOME/.poshthemes/cloud-native-azure.omp.json"
	#export OH_MY_POSH_THEME="$HOME/.poshthemes/craver.omp.json"
	#export OH_MY_POSH_THEME="$HOME/.poshthemes/darkblood.omp.json"
	#export OH_MY_POSH_THEME="$HOME/.poshthemes/di4am0nd.omp.json"
	#export OH_MY_POSH_THEME="$HOME/.poshthemes/emodipt.omp.json"
	#export OH_MY_POSH_THEME="$HOME/.poshthemes/festivetech.omp.json"
	#export OH_MY_POSH_THEME="$HOME/.poshthemes/fish.omp.json"
	#export OH_MY_POSH_THEME="$HOME/.poshthemes/gmay.omp.json"
	#export OH_MY_POSH_THEME="$HOME/.poshthemes/grandpa-style.omp.json"
	#export OH_MY_POSH_THEME="$HOME/.poshthemes/half-life.omp.json"
	#export OH_MY_POSH_THEME="$HOME/.poshthemes/honukai.omp.json"
	#export OH_MY_POSH_THEME="$HOME/.poshthemes/hotstick.minimal.omp.json"
	#export OH_MY_POSH_THEME="$HOME/.poshthemes/hunk.omp.json"
	#export OH_MY_POSH_THEME="$HOME/.poshthemes/huvix.omp.json"
	#export OH_MY_POSH_THEME="$HOME/.poshthemes/if_tea.omp.json"
	#export OH_MY_POSH_THEME="$HOME/.poshthemes/iterm2.omp.json"
	#export OH_MY_POSH_THEME="$HOME/.poshthemes/jandedobbeleer.omp.json"
	#export OH_MY_POSH_THEME="$HOME/.poshthemes/jblab_2021.omp.json"
	#export OH_MY_POSH_THEME="$HOME/.poshthemes/jonnychipz.omp.json"
	#export OH_MY_POSH_THEME="$HOME/.poshthemes/jtracey93.omp.json"
	#export OH_MY_POSH_THEME="$HOME/.poshthemes/jv_sitecorian.omp.json"
	#export OH_MY_POSH_THEME="$HOME/.poshthemes/kali.omp.json"
	#export OH_MY_POSH_THEME="$HOME/.poshthemes/lambda.omp.json"
	#export OH_MY_POSH_THEME="$HOME/.poshthemes/larserikfinholt.omp.json"
	#export OH_MY_POSH_THEME="$HOME/.poshthemes/marcduiker.omp.json"
	#export OH_MY_POSH_THEME="$HOME/.poshthemes/markbull.omp.json"
	#export OH_MY_POSH_THEME="$HOME/.poshthemes/material.omp.json"
	#export OH_MY_POSH_THEME="$HOME/.poshthemes/microverse-power.omp.json"
	#export OH_MY_POSH_THEME="$HOME/.poshthemes/mojada.omp.json"
	#export OH_MY_POSH_THEME="$HOME/.poshthemes/montys.omp.json"
	#export OH_MY_POSH_THEME="$HOME/.poshthemes/mt.omp.json"
	#export OH_MY_POSH_THEME="$HOME/.poshthemes/negligible.omp.json"
	#export OH_MY_POSH_THEME="$HOME/.poshthemes/night-owl.omp.json"
	#export OH_MY_POSH_THEME="$HOME/.poshthemes/nordtron.omp.json"
	#export OH_MY_POSH_THEME="$HOME/.poshthemes/nu4a.omp.json"
	#export OH_MY_POSH_THEME="$HOME/.poshthemes/paradox.omp.json"
	#export OH_MY_POSH_THEME="$HOME/.poshthemes/pararussel.omp.json"
	#export OH_MY_POSH_THEME="$HOME/.poshthemes/patriksvensson.omp.json"
	#export OH_MY_POSH_THEME="$HOME/.poshthemes/peru.omp.json"
	#export OH_MY_POSH_THEME="$HOME/.poshthemes/pixelrobots.omp.json"
	#export OH_MY_POSH_THEME="$HOME/.poshthemes/plague.omp.json"
	#export OH_MY_POSH_THEME="$HOME/.poshthemes/powerlevel10k_classic.omp.json"
	#export OH_MY_POSH_THEME="$HOME/.poshthemes/powerlevel10k_lean.omp.json"
	#export OH_MY_POSH_THEME="$HOME/.poshthemes/powerlevel10k_modern.omp.json"
	#export OH_MY_POSH_THEME="$HOME/.poshthemes/powerlevel10k_rainbow.omp.json"
	#export OH_MY_POSH_THEME="$HOME/.poshthemes/powerline.omp.json"
	#export OH_MY_POSH_THEME="$HOME/.poshthemes/pure.omp.json"
	#export OH_MY_POSH_THEME="$HOME/.poshthemes/remk.omp.json"
	#export OH_MY_POSH_THEME="$HOME/.poshthemes/robbyrussel.omp.json"
	#export OH_MY_POSH_THEME="$HOME/.poshthemes/rudolfs-dark.omp.json"
	#export OH_MY_POSH_THEME="$HOME/.poshthemes/rudolfs-light.omp.json"
	#export OH_MY_POSH_THEME="$HOME/.poshthemes/slim.omp.json"
	#export OH_MY_POSH_THEME="$HOME/.poshthemes/slimfat.omp.json"
	#export OH_MY_POSH_THEME="$HOME/.poshthemes/smoothie.omp.json"
	#export OH_MY_POSH_THEME="$HOME/.poshthemes/sonicboom_dark.omp.json"
	#export OH_MY_POSH_THEME="$HOME/.poshthemes/sonicboom_light.omp.json"
	#export OH_MY_POSH_THEME="$HOME/.poshthemes/sorin.omp.json"
	#export OH_MY_POSH_THEME="$HOME/.poshthemes/space.omp.json"
	#export OH_MY_POSH_THEME="$HOME/.poshthemes/spaceship.omp.json"
	#export OH_MY_POSH_THEME="$HOME/.poshthemes/star.omp.json"
	#export OH_MY_POSH_THEME="$HOME/.poshthemes/stelbent.minimal.omp.json"
	#export OH_MY_POSH_THEME="$HOME/.poshthemes/takuya.omp.json"
	#export OH_MY_POSH_THEME="$HOME/.poshthemes/thecyberden.omp.json"
	#export OH_MY_POSH_THEME="$HOME/.poshthemes/tiwahu.omp.json"
	#export OH_MY_POSH_THEME="$HOME/.poshthemes/tonybaloney.omp.json"
	#export OH_MY_POSH_THEME="$HOME/.poshthemes/unicorn.omp.json"
	#export OH_MY_POSH_THEME="$HOME/.poshthemes/wopian.omp.json"
	#export OH_MY_POSH_THEME="$HOME/.poshthemes/xtoys.omp.json"
	#export OH_MY_POSH_THEME="$HOME/.poshthemes/ys.omp.json"
	#export OH_MY_POSH_THEME="$HOME/.poshthemes/zash.omp.json"
	#export OH_MY_POSH_THEME="$HOME/.poshthemes/"
}

settings_asdf(){
	#ASDF definitions
	if [[ -f $HOME/.asdf/asdf.sh ]]; then
		source $HOME/.asdf/asdf.sh
	fi

	#For bash shell, instead use:
	if [[ -f $HOME/.asdf/plugins/java/set-java-home.bash ]]; then
		source ~/.asdf/plugins/java/set-java-home.bash
	fi

	#For zsh shell, instead use:
	if [[ -f $HOME/.asdf/plugins/java/set-java-home.zsh ]]; then
		source ~/.asdf/plugins/java/set-java-home.zsh
	fi
}

settings_server_graphic_wayland_fix_qt(){
	if [ -n "$GTK_MODULES" ]; then
		export QT_QPA_PLATFORM=wayland
	fi
}

settings_desktop_environment_plasma_global_menu_for_gtk_apps(){
	if [ -n "$GTK_MODULES" ]; then
		GTK_MODULES="${GTK_MODULES}:appmenu-gtk-module" #unity-gtk-module
		#GTK_MODULES="${GTK_MODULES}:unity-gtk-module" #unity-gtk-module
	else
		GTK_MODULES="appmenu-gtk-module"
		#GTK_MODULES="unity-gtk-module"
	fi

	if [ -z "$UBUNTU_MENUPROXY" ]; then
		UBUNTU_MENUPROXY=1
	fi
}

settings_shell_any(){
	#Applications folder for AppImages and binaries files
	if [[ ! -d $HOME/Applications/ ]]; then
		mkdir -p $HOME/Applications/
	fi

	#User specific environment
	if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:$HOME/Applications/" ]]; then
	    PATH="$HOME/.local/bin:$HOME/bin:$HOME/Applications/:$PATH"
	fi

	export PATH
	
	#If not running interactively, don't do anything
	#PS1='[\u@\h \W]\$ '
	#[[ $- != *i* ]] && return

	#Set a fancy prompt (non-color, unless we know we 'want' color)
	case $TERM in
		xterm-color|*-256color)
			color_prompt=yes
			;;
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
}

settings_shell_bash(){
	#Source global definitions
	if [ -f /etc/bashrc ]; then
		source /etc/bashrc
	fi

	#ASDF definitions
	if [[ -f $HOME/.asdf/completions/asdf.bash ]]; then
		source $HOME/.asdf/completions/asdf.bash
	fi

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
	# Lines configured by zsh-newuser-install
	HISTFILE=~/.zsh_history
	HISTSIZE=100000
	SAVEHIST=100000
	bindkey -e
	# End of lines configured by zsh-newuser-install
	# The following lines were added by compinstall
	#zstyle :compinstall filename '/home/henrikbeck95/.zshrc'
	zstyle :compinstall filename "$HOME/.zshrc"

	autoload -Uz compinit
	compinit
	# End of lines added by compinstall

	##############################
	#My settings
	##############################

	setopt appendhistory

	# Basic auto/tab complete:
	autoload -U compinit
	zstyle ':completion:*' menu select
	zmodload zsh/complist
	compinit
	_comp_options+=(globdots)               #Include hidden files.

	# Custom ZSH Binds
	if [[ -f /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh ]]; then
		source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh 2>/dev/null
	fi

	bindkey '^ ' autosuggest-accept

	######################################Bindkeys##############################
	#Bindkey				#Function						#Shortcut key
	#---					#---							#---
	#Bindkey settings
	bindkey					-N mymap emacs
	#bindkey				-A emacs main
	#bindkey				-v
	#
	#Navigation
	bindkey "^[[1;5C"		forward-word					#CTRL + ARROW_LEFT
	bindkey "^[[1;5D"		backward-word					#CTRL + ARROW_RIGHT
	bindkey "^[[H"			beginning-of-line				#HOME
	bindkey "^[[F"			end-of-line						#END
	bindkey "^[[D"			backward-char					#ARROW_LEFT
	bindkey "^[[C"			forward-char					#ARROW_RIGHT
	#
	#History
	bindkey "^[[5~"			beginning-of-history			#PAGE_UP
	bindkey "^[[A"			up-line-or-history				#ARROW_UP
	bindkey "^[[OB"			down-line-or-history			#ARROW_DOWN
	bindkey "^[[6~"			end-of-history					#PAGE_DOWN
	#
	#Edition
	bindkey "^?"			backward-delete-char			#BACKSPACE
	bindkey "^[[3~"			delete-char						#DELETE
	bindkey "^H"			backward-kill-word				#CTRL + BACKSPACE
	bindkey "^[[3;5~"		kill-word						#CTRL + DELETE
	bindkey "^J"			backward-kill-line				#CTRL + J //Delete everything before cursor
	bindkey "^[[2~"			overwrite-mode					#INSERT
	bindkey "^R"			redo							#CTRL + R
	bindkey "^Z"			undo							#CTRL + Z
	############################################################################

	#ASDF definitions
	fpath=(${ASDF_DIR}/completions $fpath) #Append completions to fpath
	autoload -Uz compinit && compinit #Initialise completions with ZSH's compinit

	#OhMyPosh!
	case $TERM in
		"alacritty" | "xterm-256color")
			#export_poshconfig "$OH_MY_POSH_THEME" json
			eval "$(oh-my-posh --init --shell zsh --config $OH_MY_POSH_THEME)"
			;;
		*) : ;;
	esac
}

settings_alias
settings_oh_my_posh_theme
settings_asdf
#settings_server_graphic_wayland_fix_qt
#settings_desktop_environment_plasma_global_menu_for_gtk_apps
settings_shell_any

#User specific environment and startup programs
case $SHELL in
	"/bin/bash" | "/usr/bin/bash") settings_shell_bash ;;
	"/bin/zsh" | "/usr/bin/zsh") settings_shell_zsh ;;
	*) : ;;
esac