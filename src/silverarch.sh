#!/usr/bin/env sh

#############################
#Instructions
#############################

#Labels
#NO LABEL					= There is nothing to do for this function tag
#label_must_be_choosen		= Must be created a selection menu
#label_must_be_created		= There is no content inside this function tag
#label_must_be_edited		= Create a display message for this function tag
#label_must_be_fixed		= There is a detected bug for this function tag
#label_must_be_improved		= Must be organized this function tag
#label_must_be_tested		= Must debug this function tag
#label_operating_system		= Must be generated a version for another operating system

#############################
#Import files
#############################

#Getting operating system properties
source /etc/os-*

#############################
#Declaring variables
#############################

PATH_SCRIPT="$(dirname "$(readlink -f "$0")")"
#SILVERARCH_SCRIPT_LINK_MAIN="https://raw.githubusercontent.com/henrikbeck95/testing/main/linux.sh"
SILVERARCH_SCRIPT_LINK_MAIN="https://raw.githubusercontent.com/henrikbeck95/silverarch/development/src/main.sh"
SILVERARCH_SCRIPT_LINK_PROFILE="https://raw.githubusercontent.com/henrikbeck95/silverarch/development/src/profile.sh"
SILVERARCH_SCRIPT_PATH="$PATH_SCRIPT/"
#SILVERARCH_SCRIPT_PATH="$HOME/"
#SILVERARCH_SCRIPT_PATH="/root/"

TERMINAL_COLOR_BLACK="\033[0;30m"
TERMINAL_COLOR_BLUE="\033[0;34m"
TERMINAL_COLOR_BLUE_LIGHT="\033[1;34m"
TERMINAL_COLOR_CYAN="\033[0;36m"
TERMINAL_COLOR_CYAN_LIGHT="\033[1;36m"
TERMINAL_COLOR_GRAY_DARK="\033[1;30m"
TERMINAL_COLOR_GRAY_LIGHT="\033[0;37m"
TERMINAL_COLOR_GREEN="\033[0;32m"
TERMINAL_COLOR_GREEN_LIGHT="\033[1;32m"
TERMINAL_COLOR_ORANGE="\033[0;33m"
TERMINAL_COLOR_PURPLE="\033[0;35m"
TERMINAL_COLOR_PURPLE_LIGHT="\033[1;35m"
TERMINAL_COLOR_RED="\033[0;31m"
TERMINAL_COLOR_RED_LIGHT="\033[1;31m"
TERMINAL_COLOR_WHITE="\033[1;37m"
TERMINAL_COLOR_YELLOW="\033[1;33m"
TERMINAL_COLOR_END="\033[0m"

TERMINAL_TEXT_BLINK="\e[5m" #\e[25m
TERMINAL_TEXT_BOLD="\e[1m"
TERMINAL_TEXT_BOLD_AND_ITALIC="\e[3m\e[1m"
TERMINAL_TEXT_ITALIC="\e[3m"
TERMINAL_TEXT_REVERSE="\e[7m" #\e[27m
TERMINAL_TEXT_STRIKETHROUGH="\e[9m"
TERMINAL_TEXT_UNDERLINE="\e[4m"
TERMINAL_TEXT_YYY="\e[31m"
TERMINAL_TEXT_ZZZ="\x1B[31m"
TERMINAL_TEXT_END="\e[0m"

TERMINAL_TEXT_BACKGROUND_WHITE_CYAN="\e[48:5:42m"
TERMINAL_TEXT_BACKGROUND_WHITE_ORANGE="\e[48:2::240:143:104m"
TERMINAL_TEXT_BACKGROUND_END="\e[49m"

#CONTAINER_MANAGER="docker"
CONTAINER_MANAGER="podman"

#CREATE DECISION FLUX IF SOFTWARE EXISTS
#EDITOR="nano"
#EDITOR="vi"
EDITOR="vim"

#LAYOUT_KEYBOARD="br-abnt2"
LAYOUT_KEYBOARD="setxkbmap -model abnt2 -layout br"
#$EDITOR /etc/default/keyboard

case $NAME in
    "Arch Linux" | "CentOS Linux" | "Fedora") MESSAGE_OPERATING_SYSTEM="Great, this script file supports it \o/" ;;
    *) MESSAGE_OPERATING_SYSTEM="This script file does not support it. Maybe this is not the right script for you :(" ;;
esac

MESSAGE_HELP="
\t\t\t\t\tLinux installation setup
\t\t\t\t\t----------------------------\n
[Credits]
Author: Henrik Beck
E-mail: henrikbeck95@gmail.com
License: GPL3
Version: v.1.0.0

[First things first]
We have detected you are using $TERMINAL_TEXT_BLINK $(echo $NAME) $TERMINAL_COLOR_END operating system. $MESSAGE_OPERATING_SYSTEM

[Description]
This is a Linux installation and post installation setup for using the operating system as a desktop workstation.
This script supports Alpine, ArchLinux and Fedora operating systems.

[Parameters]
$TERMINAL_COLOR_ORANGE Basic script file options $TERMINAL_COLOR_END
-h\t--help\t-?\t\t\tDisplay this help message
-e\t--edit\t\t\t\tEdit this script file

$TERMINAL_COLOR_BLUE Alpine installation setup $TERMINAL_COLOR_END
-al-p01\t--alpine-part-01\t\t
Install ArchLinux system base $TERMINAL_COLOR_RED_LIGHT (ONLY ROOT) $TERMINAL_COLOR_END

-al-p02\t--alpine-part-02\t\t
Configure and install ArchLinux essential system softwares $TERMINAL_COLOR_RED_LIGHT (ONLY ROOT) $TERMINAL_COLOR_END

$TERMINAL_COLOR_BLUE Archlinux installation setup $TERMINAL_COLOR_END
-ar-p01\t--archlinux-part-01\t\tInstall ArchLinux system base $TERMINAL_COLOR_RED_LIGHT (ONLY ROOT) $TERMINAL_COLOR_END
-ar-p02\t--archlinux-part-02\t\tConfigure and install ArchLinux essential system softwares and drivers $TERMINAL_COLOR_RED_LIGHT (ONLY ROOT) $TERMINAL_COLOR_END
-ar-p03\t--archlinux-part-03\t\tInstall support platforms $TERMINAL_COLOR_RED_LIGHT (ONLY ROOT) $TERMINAL_COLOR_END

$TERMINAL_COLOR_BLUE_LIGHT Fedora installation setup $TERMINAL_COLOR_END
-f\t--fedora\t\t\tConfigure and install Fedora essential system softwares $TERMINAL_COLOR_RED_LIGHT (ONLY ROOT) $TERMINAL_COLOR_END

$TERMINAL_COLOR_RED_LIGHT Others installation setup $TERMINAL_COLOR_END
-g\t--global-softwares\t\tInstall softwares which can be installed in any Linux operating system distro
-s\t--system-appearance\t\tCustomize operating system appearance
-t\t--testing\t\t\tTesting selected functions for debugging this script file
"

MESSAGE_RESTART="Must restart current session for apply the new settings"

MESSAGE_ERROR="Invalid option for $0!\n$MESSAGE_HELP"

AUX1=$1
AUX2=$2
AUX3=$3

case $AUX2 in
	"--debug") DEBUG="true" ;;
	*) DEBUG="false" ;;
esac

#############################
#Functions - Display
#############################

display_message_default(){
	echo -e "$TERMINAL_COLOR_WHITE \n#############################\n#$1\n#############################\n $TERMINAL_COLOR_END"
}

display_message_empty(){
	echo -e "$TERMINAL_COLOR_GRAY_DARK \n#############################\n#This is an empty function. Please fill it with some instructions\n#############################\n $TERMINAL_COLOR_END"
}

display_message_error(){
	echo -e "$TERMINAL_COLOR_RED_LIGHT \n#############################\n#Error! $1\n#############################\n $TERMINAL_COLOR_END"
}

display_message_success(){
	echo -e "$TERMINAL_COLOR_GREEN_LIGHT \n#############################\n#$1\n#############################\n $TERMINAL_COLOR_END"
}

display_message_warning(){
	echo -e "$TERMINAL_COLOR_YELLOW \n***$1*** $TERMINAL_COLOR_END"
}

#############################
#Functions - Tools
#############################

tools_backup_create(){
	tools_check_if_user_has_root_previledges

	display_message_default "Creating Timeshift $1 backup"

	#Get Timeshift help
	#timeshift --help
	
	#Change Timeshift engine
	timeshift --btrfs

	#Linux all snapshots
	#timeshift --list

	#Create a snapshot
	timeshift --create --comments "$1" --tags D

	#Restore a Timeshift snapshot
	#timeshift --restore --snapshot '2021-07-09_00-37-36'

	display_message_success "Timeshift backup $1 has been created"
}

tools_browser_open_url(){
	display_message_default "Opening $@ from $BROWSER browser software"

	xdg-open $@
}

tools_check_if_internet_connection_exists(){
    echo -e "GET http://google.com HTTP/1.0\n\n" | nc google.com 80 > /dev/null 2>&1

    if [ $? -eq 0 ]; then
        echo "true"
    else
        echo "false"
    fi
}

tools_check_if_software_is_installed(){
    echo -e "GET http://google.com HTTP/1.0\n\n" | nc google.com 80 > /dev/null 2>&1

	if command -v $1 >/dev/null; then
        echo "true"
    else
        echo "false"
    fi
}

tools_check_if_string_pattern_matches(){
    local CONTENT_STRING=$1
    local FILE_PATH=$2

	#Check if strings matches only if the file exists
	if [[ -f "$FILE_PATH" ]]; then
		if grep -q "$CONTENT_STRING" "$FILE_PATH"; then
			echo "true"
		else
			echo "false"
		fi
	else
		echo "fail"
	fi
}

tools_check_if_user_has_root_previledges(){
	if [[ $UID != 0 ]]; then
		echo -e "You must be root for preduring this step!"
		exit 127;
	fi
}

tools_check_if_virtualization_is_enabled(){
	#if [[ $(egrep '^flags.*(vmx|svm)' /proc/cpuinfo) ]]; then
	if [[ $(LC_ALL=C lscpu | grep Virtualization) ]]; then
		echo "true"
	else
		echo "false"
	fi
}

tools_clear_history(){
	display_message_default "Clearing terminal history"

	while true; do
		read -p "Inform what you want: [ash | bash | zsh | skip] " QUESTION_TERMINAL_HISTORY

		case $QUESTION_TERMINAL_HISTORY in
			"ash")
				cat /dev/null > $HOME/.ash_history
				break
				;;
			"bash")
				cat /dev/null > $HOME/.bash_history
				break
				;;
			"zsh")
				cat /dev/null > $HOME/.zsh_history
				break
				;;
			"skip") break ;;
			*) echo "Please answer file or partition." ;;
		esac
	done
}

tools_create_path_directory(){
	display_message_warning "Creating $@ folder directory"
	
	if [[ ! -d $@/ ]]; then
		mkdir -p $@/
	fi

	display_message_success "$@ folder directory has been created"
}

tools_create_symbolic_link(){
	display_message_warning "Creating symbolic link to $1 to $2"
	
	ln -sf $1 $2

	display_message_success "Symbolic link from $1 to $2 has been created"
}

tools_download_file(){
	case $# in
		1)
			display_message_warning "Downloading $1 file"
			curl -L -O $1
			#wget -c $1
			display_message_success "$1 file has been downloaded"
			;;
		2) 
			display_message_warning "Downloading $1 file to $2"

			cd $2
			pwd
			curl -L -O $1
			#wget -c $1 -O $2
			cd -

			display_message_success "$1 file has been downloaded to $2"
			;;
		*) display_message_error "Invalid option" ;;
	esac
}

tools_edit_file(){
	#gedit $@
	#nano $@
	#vi -O $@
	vim -O $@
}

tools_export_variables_bios(){
	display_message_default "Exporting/loading BIOS variables"

	BIOS=$(ls -A /sys/firmware/efi/efivars 2>&1 /dev/null) #Verifying if BIOS supports UEFI

	#Verifying if BIOS supports UEFI by checking if directory is empty
	if [ -z "$(ls -A /sys/firmware/efi/efivars)" ]; then
		IS_BIOS_UEFI="legacy" #echo "Empty"
	else
		IS_BIOS_UEFI="uefi" #"Not Empty"
	fi

	display_message_warning "Your device BIOS is $IS_BIOS_UEFI"
}

tools_export_variables_processor(){
	PROCESSOR=$(cat /proc/cpuinfo | grep vendor_id | head -1 | awk '{print $3}')
	#PROCESSOR=$(cat /sys/devices/virtual/dmi/id/board_{vendor,name,version})

	display_message_warning "Your device processor family is $PROCESSOR"
}

tools_export_variables_virtualization(){
	IS_VIRTUALIATION=$(hostnamectl | grep "Virtualization" | awk '{print $2}')

	if [[ $IS_VIRTUALIATION == "kvm" ]]; then
		display_message_warning "I know you are using a virtual machine!"

		PARTITION_PATH="/dev/vda"
		PARTITION_BOOT="/dev/vda1"
		PARTITION_ROOT="/dev/vda2"
		PARTITION_FILE="/dev/vda3"
		PARTITION_SWAP="/dev/vda4"

	else
		display_message_warning "Great! You are installing on your host machine!"

		PARTITION_PATH="/dev/sda"
		PARTITION_BOOT="/dev/sda1"
		PARTITION_ROOT="/dev/sda2"
		PARTITION_FILE="/dev/sda3"
		PARTITION_SWAP="/dev/sda4"
	fi
}

tools_extract_file_tar(){
	display_message_default "Extracting $@ file(s)"

	tar -zxvf $@ || tar -xzf $@ || tar -xf $@
	
	display_message_success "File(s) $@ has/have been extracted"
}

tools_give_executable_permission(){
	display_message_default "Giving executable permission to $@ file(s)"
	
	chmod +x $@

	display_message_success "File(s) $@ has/have been given executable permission"
}

tools_partiting_swap(){
	display_message_default "Create the SWAP"

	while true; do
		read -p "Inform what you want: [file/partition/skip] " QUESTION_SWAP

		case $QUESTION_SWAP in
			"file")
				tools_partiting_swap_file
				;;
			"partition")
				tools_partiting_swap_partition
				;;
			"skip") break ;;
			*) echo "Please answer file or partition." ;;
		esac
	done
}

#label_must_be_fixed
tools_partiting_swap_file(){
	tools_check_if_user_has_root_previledges

	display_message_default "Creating the SWAP file"

	truncate -s 0 /swap/swapfile
	chattr +C /swap/swapfile
	btrfs property set /swap/swapfile compression none

	#Set 4 GB size to Swap file
	dd if=/dev/zero of=/swap/swapfile bs=4G count=2 status=progress
	
	#Give the right permissions to the swap file
	chmod 600 /swap/swapfile
	mkswap /swap/swapfile
	swapon /swap/swapfile

	#Enable the Swap file on boot
	echo -e "\n#Swapfile\n/swap/swapfile none swap defaults 0 0" >> /etc/fstab
	
	#Check /etc/fstab file
	tools_edit_file /etc/fstab #text

	display_message_success "SWAP file has been created"
}

tools_partiting_swap_partition(){
	tools_check_if_user_has_root_previledges

	display_message_default "Creating the SWAP partition"

	mkswap -f $PARTITION_SWAP
	swapon $PARTITION_SWAP

	display_message_success "SWAP partition has been created"
}

tools_string_convert_from_lower_to_upper(){
	echo ${@^^}
}

tools_string_convert_from_upper_to_lower(){
	echo ${@,,}
}

tools_string_replace_backslash_to_forward_slash(){
	echo "$1" | sed 's/\\/\//g'
}

tools_string_replace_forward_slash_to_backslash_cancelled(){
	local TEXT_OLD="\/"
	local TEXT_NEW="\\\/"

	#Replace all the match values from a sonsole
	echo "$1" | sed 's/\//\\\//g'
}

tools_string_replace_number(){
	local PATH_FILE="$1"
	local TEXT_OLD_LINE_NUMBER="$2"
	local TEXT_NEW="$3"

	#Replace all the text from the line number
    sed -i "$TEXT_OLD_LINE_NUMBER c\\$TEXT_NEW" $PATH_FILE
}

tools_string_replace_output(){
	local TEXT_OLD="$1"
	local TEXT_NEW="$2"

	#Replace all the match values from a sonsole
	sed -s "s/$TEXT_OLD/$TEXT_NEW/g"
}

tools_string_replace_text(){
	local PATH_FILE="$1"
	local TEXT_OLD="$2"
	local TEXT_NEW="$3"

	#Replace all the match values in a text file
	sed -i "s/$TEXT_OLD/$TEXT_NEW/g" $PATH_FILE
}

tools_string_write_exclusive_line_on_a_file(){
	case $(tools_check_if_string_pattern_matches "$1" "$2") in
		"true" | "fail") display_message_error "String already exists on file" ;;
		"false")
			echo "$1" >> "$2"
			display_message_success "String has been appended on the last line of the file"
			;;
	esac
}

tools_system_daemon_openrc_disable_later(){
	display_message_default "Disable $@ process on start up from OpenRC (after rebooting)"
	
	tools_check_if_user_has_root_previledges
	rc-update del $@ default
}

tools_system_daemon_openrc_disable_now(){
	display_message_default "Disable $@ process on start up from OpenRC (right now)"
	
	tools_check_if_user_has_root_previledges
	rc-service $@ stop && rc-update del $@
}

tools_system_daemon_openrc_enable_later(){
	display_message_default "Enable $@ process on start up from OpenRC (after rebooting)"
	
	tools_check_if_user_has_root_previledges
	rc-update add $@ default
}

tools_system_daemon_openrc_enable_now(){
	display_message_default "Enable $@ process on start up from OpenRC (right now)"
	
	tools_check_if_user_has_root_previledges
	rc-service $@ start && rc-update add $@
}

tools_system_daemon_openrc_restart(){
	display_message_default "Restart $@ process from OpenRC"
	
	tools_check_if_user_has_root_previledges
	rc-service $@ restart
}

tools_system_daemon_openrc_start(){
	display_message_default "Start $@ process now from OpenRC"
	
	tools_check_if_user_has_root_previledges
	rc-service $@ start
}

tools_system_daemon_openrc_status(){
	display_message_default "Get $@ process status from OpenRC"
	
	tools_check_if_user_has_root_previledges
	#rc-status
	#rc-status --list
	rc-service $@ status
}

tools_system_daemon_openrc_stop(){
	display_message_default "Stop $@ process now from OpenRC"
	
	tools_check_if_user_has_root_previledges
	rc-service $@ stop
}

tools_system_daemon_systemd_disable_later(){
	display_message_default "Disable $@ process on start up from SystemD (after rebooting)"
	
	tools_check_if_user_has_root_previledges
	systemctl disable $@
}

tools_system_daemon_systemd_disable_now(){
	display_message_default "Disable $@ process on start up from SystemD (right now)"
	
	tools_check_if_user_has_root_previledges
	systemctl disable --now $@
}

tools_system_daemon_systemd_enable_later(){
	display_message_default "Enable $@ process on start up from SystemD (after rebooting)"
	
	tools_check_if_user_has_root_previledges
	systemctl enable $@
}

tools_system_daemon_systemd_enable_now(){
	display_message_default "Enable $@ process on start up from SystemD (right now)"
	
	tools_check_if_user_has_root_previledges
	systemctl enable --now $@
}

tools_system_daemon_systemd_restart(){
	display_message_default "Restart $@ process from SystemD"
	
	tools_check_if_user_has_root_previledges
	systemctl restart $@
}

tools_system_daemon_systemd_start(){
	display_message_default "Start $@ process now from SystemD"
	
	tools_check_if_user_has_root_previledges
	systemctl start $@
}

tools_system_daemon_systemd_status(){
	display_message_default "Get $@ process status from SystemD"
	
	tools_check_if_user_has_root_previledges
	systemctl status $@
}

tools_system_daemon_systemd_stop(){
	display_message_default "Stop $@ process now from SystemD"
	
	tools_check_if_user_has_root_previledges
	systemctl stop $@
}

tools_update_fonts_cache(){
	display_message_default "Update cache from $HOME/.fonts/, /usr/share/fonts/ and /usr/local/share/fonts/ fonts pathes"
	
	fc-cache update

	display_message_success "Font cache pathes from $HOME/.fonts/, /usr/share/fonts/ and /usr/local/share/fonts/ have been updated"
}

#############################
#Functions - Container
#############################

tools_container_distrobox_image_download(){
	#distrobox-create --name debian10-distrobox --image debian:10
	distrobox-create --name $1 --image $2
}

tools_container_distrobox_image_enter(){
	#distrobox-enter --name debian10-distrobox
	distrobox-enter --name $@
}

tools_container_manager_image_backup(){
	#$CONTAINER_MANAGER save -o $HOME/Desktop/centos.tgz centos:latest
	$CONTAINER_MANAGER save -o $HOME/Desktop/$@.tgz $@
}

tools_container_manager_image_download(){
	$CONTAINER_MANAGER pull $@
}

tools_container_manager_image_execute(){
	$CONTAINER_MANAGER run -it $@
}

tools_container_manager_image_list(){
    $CONTAINER_MANAGER image ls
}

tools_container_manager_image_remove(){
    $CONTAINER_MANAGER image rm $@
}

#############################
#Functions - GitHub
#############################

tools_git_repository_clone(){
	display_message_success "Cloning $1 Git repository"

	tools_create_path_directory $HOME/Documents/developement/
	
	cd $HOME/Documents/developement/
	git clone $1
	cd -
	
	display_message_success "$1 Git repository has been cloned"
}

#label_must_be_improved
tools_git_setup_credentials(){
	display_message_default "Setting up Git credentials to $1 - $2"

	#Set Git e-mail credential
	git config --global user.email "$1" #Try: "henrikbeck95@gmail.com"
	
	#Set Git username credential
	git config --global user.name "$2" #Try: "Henrik Beck"

	#Store Git credentials to cache file
	#git config --global credential.helper store

	#git pull
	#cat ~/.git-credentials

	display_message_success "Git setup credentials has been set to $1 - $2"
}

#############################
#Functions - Package manager
#############################

tools_package_manager_any_asdf_repository_add(){
	display_message_default "Add ASDF $@ repository"
	
	asdf plugin add $@ || asdf plugin-add $@
	tools_package_manager_any_asdf_repository_syncronize $@

	display_message_default "ASDF $@ repository has been added"
}

tools_package_manager_any_asdf_repository_remove(){
	display_message_default "Remove ASDF $@ repository"
	
	asdf plugin remove $@

	display_message_default "ASDF $@ repository has been removed"
}

tools_package_manager_any_asdf_repository_syncronize(){
	display_message_default "Syncronize ASDF $@ repository"
	
	asdf plugin update $@

	display_message_default "ASDF $@ repository has been syncronized"
}

tools_package_manager_any_asdf_software_install(){
	display_message_default "Install ASDF $@ software"
	
	asdf #install python 3.7.4
	asdf install $@

	display_message_default "ASDF $@ software has been installed"
}

tools_package_manager_any_asdf_software_list(){
	display_message_default "List ASDF $@ softwares"
	
	asdf list
}

tools_package_manager_any_asdf_software_setup(){
	display_message_default "Install ASDF $@ setup"
	
	#Install ASDF
	git clone https://github.com/asdf-vm/asdf.git /etc/skel/.asdf --branch v0.9.0
	#git clone https://github.com/asdf-vm/asdf.git $HOME/.asdf --branch v0.9.0
	
	#BASH
	#tools_string_write_exclusive_line_on_a_file "source \$HOME/.asdf/asdf.sh" "$HOME/.bashrc"

	#tools_string_write_exclusive_line_on_a_file "source \$HOME/.asdf/completions/asdf.bash" "$HOME/.bashrc"
	
	#ZSH
	#tools_string_write_exclusive_line_on_a_file "source \$HOME/.asdf/asdf.sh" "$HOME/.zshrc"
	#tools_string_write_exclusive_line_on_a_file "source \$HOME/.asdf/completions/asdf.bash" "$HOME/.zshrc"
	
	display_message_default "ASDF $@ setup has been installed"
}

tools_package_manager_any_asdf_software_uninstall(){
	display_message_default "Uninstall ASDF $@ software"

	#asdf uninstall python 3.7.4
	asdf uninstall $@
	
	display_message_default "ASDF $@ software has been unistalled"
}

tools_package_manager_any_flatpak_repository_add(){
	display_message_default "Add Flatpak $@ repository"
	
	#flatpak remote-add --if-not-exists $@
	#flatpak remote-add --user --if-not-exists $@
	flatpak remote-add --system --if-not-exists $@
	
	display_message_default "Flatpak $@ repository has been added"
}

tools_package_manager_any_flatpak_repository_list(){
	display_message_default "List Flatpak $@ repositories"

	flatpak remote-list
}

tools_package_manager_any_flatpak_repository_remove(){
	display_message_default "Remove Flatpak $@ repository"
	
	#flatpak remote-delete $@
	#flatpak remote-delete --user $@
	flatpak remote-delete --system $@

	display_message_default "Flatpak $@ repository has been added"
}

tools_package_manager_any_flatpak_repository_syncronize(){
	display_message_default "Syncronize Flatpak $@ repository"
    
	flatpak update
	
	display_message_default "Flatpak $@ repository has been syncronized"
}

tools_package_manager_any_flatpak_software_install(){
	display_message_default "Install Flatpak $@ software"
	
	case $DEBUG in
		"false") flatpak install $@ ;;
		"true") flatpak install -y $@ ;;
	esac
	
	display_message_default "Flatpak $@ software(s) has/have been installed"
}

tools_package_manager_any_flatpak_software_list(){
	display_message_default "List Flatpak $@ softwares"
	
	flatpak list
}

tools_package_manager_any_flatpak_software_setup(){
	display_message_default "Install Flatpak $@ setup"
    
	case $NAME in
        "Alipne") display_message_empty ;;
        "Arch Linux") tools_package_manager_archlinux_pacman_software_install flatpak ;;
        "CentOS Linux" | "Fedora") : ;; #Native installed
        *) display_message_error "" ;;
    esac

	display_message_warning "$MESSAGE_RESTART"

	display_message_default "Flatpak $@ setup has been installed"
}

tools_package_manager_any_flatpak_software_uninstall(){
	display_message_default "uninstall Flatpak $@ software"
    
	case $DEBUG in
		"false") flatpak uninstall $@ ;;
		"true") flatpak uninstall -y $@ ;;
	esac
	
	display_message_default "Flatpak $@ software(s) has/have been uninstalled"
}

#label_must_be_created
tools_package_manager_any_node_npm_repository_add(){
	display_message_default "Add Node - NPM $@ repository"

	display_message_empty	

	display_message_default "Node - NPM $@ repository has been added"
}

#label_must_be_created
tools_package_manager_any_node_npm_repository_remove(){
	display_message_default "Remove Node - NPM $@ repository"
	
	display_message_empty
	
	display_message_default "Node - NPM $@ repository has been added"
}

tools_package_manager_any_node_npm_repository_syncronize(){
	display_message_default "Syncronize Node - NPM $@ repository"
	
	npm install npm@latest -g
	
	display_message_default "Node - NPM $@ repository has been syncronized"
}

tools_package_manager_any_node_npm_software_install_global(){
	display_message_default "Install Node - NPM (globally) $@ software"
	
	npm install -g $@
	
	display_message_default "Node - NPM (globally) $@ software(s) has/have been installed"
}

tools_package_manager_any_node_npm_software_install_local(){
	display_message_default "Install Node - NPM (locally) $@ software"
	
	npm install $@
	
	display_message_default "Node - NPM (locally) $@ software(s) has/have been installed"
}

tools_package_manager_any_node_npm_software_list(){
	display_message_default "List Node - NPM softwares"

	display_message_warning "List all local installed Node libraries"
	npm list

	display_message_warning "List all globally installed Node libraries"
	npm list -g
}

tools_package_manager_any_node_npm_software_setup(){
	display_message_default "Install Node - NPM setup"
	
	#Install NodeJS plugin
	tools_package_manager_any_asdf_repository_add nodejs https://github.com/asdf-vm/asdf-nodejs.git

	#List all NodeJS plugins available
	tools_package_manager_any_asdf_software_list all nodejs

	#Install NodeJS versions
	#tools_package_manager_any_asdf_software_install nodejs latest
	tools_package_manager_any_asdf_software_install nodejs lts

	#Set NodeJS environment
	asdf global nodejs lts
	#asdf local nodejs latest #Your current working directory

	#Check if NodeJS version
	nodejs --version
	
	display_message_default "Node - NPM setup has been installed"
}

tools_package_manager_any_node_npm_software_uninstall_global(){
	display_message_default "Uninstall Node - NPM (gloablly) $@ software"
	
	npm uninstall -g $@
	
	display_message_default "Node - NPM (gloablly) $@ software(s) has/have been uninstalled"
}

tools_package_manager_any_node_npm_software_uninstall_local(){
	display_message_default "Uninstall Node - NPM (locally) $@ software"
	
	npm uninstall $@
	
	display_message_default "Node - NPM (locally) $@ software(s) has/have been uninstalled"
}

#label_must_be_created
tools_package_manager_any_node_yarn_repository_add(){
	display_message_default "Add Node - YARN $@ repository"
		
	display_message_empty

	display_message_default "Node - YARN $@ repository has been added"
}

#label_must_be_created
tools_package_manager_any_node_yarn_repository_remove(){
	display_message_default "Remove Node - YARN $@ repository"
	
	display_message_empty
	
	display_message_default "Node - YARN $@ repository has been added"
}

#label_must_be_created
tools_package_manager_any_node_yarn_repository_syncronize(){
	display_message_default "Syncronize Node - YARN $@ repository"

	display_message_empty
	
	display_message_default "Node - YARN $@ repository has been syncronized"
}

#label_must_be_created
tools_package_manager_any_node_yarn_software_install(){
	display_message_default "Install Node - YARN $@ software"

	display_message_empty
	
	display_message_default "Node - YARN $@ software(s) has/have been installed"
}

#label_must_be_created
tools_package_manager_any_node_yarn_software_list(){
	display_message_default "List Node - YARN softwares"

	display_message_empty
}

tools_package_manager_any_node_yarn_software_setup(){
	display_message_default "Install Node - YARN setup"
	
	display_message_empty
	
	display_message_default "Node - YARN setup has been installed"
}

#label_must_be_created
tools_package_manager_any_node_yarn_software_uninstall(){
	display_message_default "Uninstall Node - YARN $@ software"
		
	display_message_empty
	
	display_message_default "Node - YARN $@ software(s) has/have been uninstalled"
}

#label_must_be_created
tools_package_manager_any_python_anaconda_repository_add(){
	display_message_default "Add Python - Anaconda $@ repository"

	display_message_empty

	display_message_default "Python - Anaconda $@ repository has been added"
}

#label_must_be_created
tools_package_manager_any_python_anaconda_repository_remove(){
	display_message_default "Python - Anaconda $@ repository has been added"
	
	display_message_empty
	
	display_message_default "Remove Python - Anaconda $@ repository"
}

#label_must_be_created
tools_package_manager_any_python_anaconda_repository_syncronize(){
	display_message_default "Syncronize Python - Anaconda $@ repository"
	
	display_message_empty

	display_message_default "Python - Anaconda $@ repository has been syncronized"
}

#label_must_be_created
tools_package_manager_any_python_anaconda_software_install(){
	display_message_default "Install Python - Anaconda $@ software"
		
	display_message_empty
	
	display_message_default "Python - Anaconda $@ software(s) has/have been installed"
}

#label_must_be_created
tools_package_manager_any_python_anaconda_software_list(){
	display_message_default "List Python - Anaconda softwares"

	display_message_empty
}

#label_must_be_edited
#label_must_be_improved
tools_package_manager_any_python_anaconda_software_setup(){
	display_message_default "Install Python - Anaconda setup"

	#https://docs.anaconda.com/anaconda/install/linux/
	
	cd $HOME/Downloads/
	#Download Anaconda script file
	https://repo.anaconda.com/archive/Anaconda3-2021.11-Linux-x86_64.sh
	cd -

	#Import Anaconda script file
	bash ~/Downloads/Anaconda3-2021.11-Linux-x86_64.sh
	
	display_message_default "Python - Anaconda setup has been installed"
}

#label_must_be_created
tools_package_manager_any_python_anaconda_software_uninstall(){
	display_message_default "Uninstall Python - Anaconda $@ software"

	display_message_empty
	
	display_message_default "Python - Anaconda $@ software(s) has/have been uninstalled"
}

#label_must_be_created
tools_package_manager_any_python_pip_repository_add(){
	display_message_default "Add Python - Pip3 $@ repository"

	display_message_empty
		
	display_message_default "Python - Pip3 $@ repository has been added"
}

#label_must_be_created
tools_package_manager_any_python_pip_repository_remove(){
	display_message_default "Python - Pip3 $@ repository has been added"
	
	display_message_empty
	
	display_message_default "Remove Python - Pip3 $@ repository"
}

#label_must_be_created
tools_package_manager_any_python_pip_repository_syncronize(){
	display_message_default "Syncronize Python - Pip3 $@ repository"

	display_message_empty
	
	display_message_default "Python - Pip3 $@ repository has been syncronized"
}

tools_package_manager_any_python_pip_software_install(){
	display_message_default "Install Python - Pip3 $@ software"
	
    case $DEBUG in
		"false") pip3 install $@ ;;
		"true") pip3 install -y $@ ;;
	esac

	display_message_default "Python - Pip3 $@ software(s) has/have been installed"
}

tools_package_manager_any_python_pip_software_list(){
	display_message_default "List Python - Pip3 softwares"

	pip3 list
}

tools_package_manager_any_python_pip_software_setup(){
	display_message_default "Install Python - Pip3 setup"

    #case $NAME in
        #"Arch Linux") tools_package_manager_archlinux_pacman_software_install python-pip ;;
        #"CentOS Linux" | "Fedora") : ;; #Native installed
        #*) display_message_error "" ;;
    #esac

	#Install Python plugin
	tools_package_manager_any_asdf_repository_add python
	
	#List all Python plugins available
	tools_package_manager_any_asdf_software_list all python

	#Install Python versions
	tools_package_manager_any_asdf_software_install python 3.6-dev
	tools_package_manager_any_asdf_software_install python 3.6.0
	tools_package_manager_any_asdf_software_install python 3.9.2

	#Set Python environment
	asdf global python 3.9.2
	cd ~/Documents/voice_assistant_linux/ && asdf local python 3.6-dev #Your current working directory

	#Check if Python version
	python --version
	
	display_message_default "Python - Pip3 setup has been installed"
}

#label_must_be_created
tools_package_manager_any_python_pip_software_uninstall(){
	display_message_default "Uninstall Python - Pip3 $@ software"

	display_message_empty
	
	display_message_default "Python - Pip3 $@ software(s) has/have been uninstalled"
}

#label_must_be_created
tools_package_manager_any_rust_cargo_repository_add(){
	display_message_default "Add Rust - Cargo $@ repository"
		
	display_message_empty

	display_message_default "Rust - Cargo $@ repository has been added"
}

#label_must_be_created
tools_package_manager_any_rust_cargo_repository_remove(){
	display_message_default "Remove Rust - Cargo $@ repository"
	
	display_message_empty

	display_message_default "Rust - Cargo $@ repository has been added"
}

#label_must_be_created
tools_package_manager_any_rust_cargo_repository_syncronize(){
	display_message_default "Syncronize Rust - Cargo $@ repository"

	display_message_empty
	
	display_message_default "Rust - Cargo $@ repository has been syncronized"
}

#label_must_be_created
tools_package_manager_any_rust_cargo_software_list(){
	display_message_default "List Rust - Cargo softwares"

	display_message_empty
}

#label_must_be_created
tools_package_manager_any_rust_cargo_software_install(){
	display_message_default "Install Rust - Cargo $@ software"
	
	display_message_empty
	
	display_message_default "Rust - Cargo $@ software(s) has/have been installed"
}

#label_must_be_created
tools_package_manager_any_rust_cargo_software_uninstall(){
	display_message_default "Uninstall Rust - Cargo $@ software"

	display_message_empty
		
	display_message_default "Rust - Cargo $@ software(s) has/have been uninstalled"
}

#label_must_be_created
tools_package_manager_any_snap_repository_add(){
	display_message_default "Add Snap $@ repository"

	display_message_empty

	display_message_default "Snap $@ repository has been added"
}

#label_must_be_created
tools_package_manager_any_snap_repository_remove(){
	display_message_default "Remove Snap $@ repository"
	
	display_message_empty
	
	display_message_default "Snap $@ repository has been added"
}

tools_package_manager_any_snap_repository_syncronize(){
	display_message_default "Syncronize Snap $@ repository"
	
	tools_check_if_user_has_root_previledges

    case $DEBUG in
		"false") snap update ;;
		"true") snap update -y ;;
	esac
		
	display_message_default "Snap $@ repository has been syncronized"
}

tools_package_manager_any_snap_software_install(){
	display_message_default "Install Snap $@ software"
	
	tools_check_if_user_has_root_previledges

    case $DEBUG in
		"false") snap install $@ ;;
		"true") snap install -y $@ ;;
	esac
		
	display_message_default "Snap $@ software(s) has/have been installed"
}

tools_package_manager_any_snap_software_setup(){
	display_message_default "Install Snap setup"
	
    case $NAME in
        "Arch Linux")
            tools_package_manager_archlinux_pacman_software_install \
                snapd

            #Enabling the Snap core on systemd
            tools_system_daemon_systemd_enable_now snapd.socket

            display_message_warning "$MESSAGE_RESTART"
            ;;
        "CentOS Linux" | "Fedora")
            #Install Snap runtime
            tools_package_manager_fedora_dnf_software_install_single snapd

            #Create a symbolic link to root directory
            sudo ln -s /var/lib/snapd/snap /snap
            #sudo rm -f /snap
            ;;
        *) display_message_error "" ;;
    esac
	
	display_message_default "Snap setup has been installed"
}

tools_package_manager_any_snap_software_list(){
	display_message_default "List Snap softwares"

	snap list
}

tools_package_manager_any_snap_software_uninstall(){
	display_message_default "Uninstall Snap $@ software"
	
	tools_check_if_user_has_root_previledges

	case $DEBUG in
		"false") snap remove $@ ;;
		"true") snap remove -y $@ ;;
	esac
	
	display_message_default "Snap $@ software(s) has/have been uninstalled"
}

tools_package_manager_any_vim_vundle_software_setup(){
	display_message_default "Install Vundle-Vim $@ setup"
	
    tools_download_file "https://raw.githubusercontent.com/henrikbeck95/dotfiles/development/compiled/.vimrc" "/etc/skel/"

    #Install Vundle-Vim
    #git clone https://github.com/VundleVim/Vundle.vim.git $HOME/.vim/bundle/Vundle.vim
    git clone https://github.com/VundleVim/Vundle.vim.git /etc/skel/.vim/bundle/Vundle.vim
    
    #Install Vim plugins
    vim +PluginInstall +qall

	display_message_default "Vundle-Vim $@ setup has been installed"
}

#label_must_be_created
tools_package_manager_alpine_apk_repository_add(){
	display_message_default "Add Alpine - APK $@ repository"

	display_message_empty

	display_message_default "Alpine - APK $@ repository has been added"
}

#label_must_be_created
tools_package_manager_alpine_apk_repository_remove(){
	display_message_default "Remove Alpine - APK $@ repository"

	display_message_empty
	
	display_message_default "Alpine - APK $@ repository has been added"
}

tools_package_manager_alpine_apk_repository_syncronize(){
	tools_check_if_user_has_root_previledges

	display_message_default "Syncronize Alpine - APK $@ repository"
	
	apk update

	display_message_default "Alpine - APK $@ repository has been syncronized"
}

tools_package_manager_alpine_apk_software_install(){
	tools_check_if_user_has_root_previledges
	
	display_message_default "Install Alpine - APK $@ software"

    case $DEBUG in
		"false") apk add $@ ;;
		"true") apk add -y $@ ;;
	esac

	display_message_default "Alpine - APK $@ software(s) has/have been installed"
}

tools_package_manager_alpine_apk_software_list(){
	display_message_default "List Alpine - APK softwares"

	apk list
}

#label_must_be_created
tools_package_manager_alpine_apk_software_setup(){
	display_message_default "Install Alpine - APK setup"

	display_message_empty
	
	display_message_default "Alpine - APK setup has been installed"
}

tools_package_manager_alpine_apk_software_uninstall(){
	tools_check_if_user_has_root_previledges

	display_message_default "Uninstall Alpine - APK $@ software"

    case $DEBUG in
		"false") apk remove $@ ;;
		"true") apk remove -y $@ ;;
	esac
	
	display_message_default "Alpine - APK $@ software(s) has/have been uninstalled"
}

#label_must_be_created
tools_package_manager_archlinux_aur_repository_add(){
	display_message_default "Add ArchLinux - AUR $@ repository"

	display_message_empty

	display_message_default "ArchLinux - AUR $@ repository has been added"
}

#label_must_be_created
tools_package_manager_archlinux_aur_repository_remove(){
	display_message_default "Remove ArchLinux - AUR $@ repository"
	
	display_message_empty
	
	display_message_default "ArchLinux - AUR $@ repository has been added"
}

#label_must_be_improved
tools_package_manager_archlinux_aur_repository_syncronize(){
	display_message_default "Syncronize ArchLinux - AUR $@ repository"

    case $DEBUG in
		#"false") yay -Syyuu ;;
		#"true") yay -Syyuu --noconfirm ;;
		"false") paru -Syyuu ;;
		"true") paru -Syyuu --noconfirm ;;
	esac
	
	display_message_default "ArchLinux - AUR $@ repository has been syncronized"
}

#label_must_be_improved
tools_package_manager_archlinux_aur_software_install(){
	display_message_default "Install ArchLinux - AUR $@ software"
	
    case $DEBUG in
		#"false") yay -S $@ ;;
		#"true") yay -S $@ --noconfirm ;;
		"false") paru -S $@ ;;
		"true") paru -S $@ --noconfirm ;;
	esac

	#paru -S $@
	#paru -S $@ --needed
	#paru -S $@ --noconfirm
	#paru -S $@ --noconfirm --needed

	#yay -S $@
	#yay -S $@ --needed
	#yay -S $@ --noconfirm
	#yay -S $@ --noconfirm --needed
	
	display_message_default "ArchLinux - AUR $@ software(s) has/have been installed"
}

#label_must_be_created
tools_package_manager_archlinux_aur_software_list(){
	display_message_default "List ArchLinux - AUR softwares"

	display_message_empty
}

tools_package_manager_archlinux_aur_software_setup(){
	display_message_default "Install ArchLinux - AUR setup"
	
    #Paru
	tools_create_path_directory $HOME/compilation/
	git clone https://aur.archlinux.org/paru.git $HOME/compilation/paru

	cd $HOME/compilation/paru/
	makepkg -si
	cd -

	display_message_default "ArchLinux - AUR setup has been installed"
}

tools_package_manager_archlinux_aur_software_uninstall(){
	display_message_default "Uninstall ArchLinux - AUR $@ software"
	
	case $DEBUG in
		#"false") yay -Rns $@ ;;
		#"true") yay -Rns $@ --noconfirm ;;
		"false") paru -Rns $@ ;;
		"true") paru -Rns $@ --noconfirm ;;
	esac
	
	display_message_default "ArchLinux - AUR $@ software(s) has/have been uninstalled"
}

#label_must_be_created
tools_package_manager_archlinux_pacman_repository_add(){
	display_message_default "Add ArchLinux - Pacman $@ repository"

	display_message_empty

	display_message_default "ArchLinux - Pacman $@ repository has been added"
}

#label_must_be_created
tools_package_manager_archlinux_pacman_repository_remove(){
	display_message_default "Remove ArchLinux - Pacman $@ repository"

	display_message_empty
	
	display_message_default "ArchLinux - Pacman $@ repository has been added"
}

tools_package_manager_archlinux_pacman_repository_syncronize(){
	display_message_default "Syncronize ArchLinux - Pacman $@ repository"
	
	tools_check_if_user_has_root_previledges
	
    case $DEBUG in
		"false") pacman -Syyuu ;;
		"true") pacman -Syyuu --noconfirm ;;
	esac
	
	display_message_default "ArchLinux - Pacman $@ repository has been syncronized"
}

tools_package_manager_archlinux_pacman_software_install(){
	tools_check_if_user_has_root_previledges

	display_message_default "Install ArchLinux - Pacman $@ software"

    case $DEBUG in
		"false") pacman -S $@ ;;
		"true") pacman -S --noconfirm $@ ;;
		#"true") pacman -S --noconfirm --needed $@ ;;
	esac
	
	display_message_default "ArchLinux - Pacman $@ software(s) has/have been installed"
}

#label_must_be_created
tools_package_manager_archlinux_pacman_software_list(){
	display_message_default "List ArchLinux - Pacman softwares"
	
	display_message_empty
}

tools_package_manager_archlinux_pacman_software_uninstall(){
	tools_check_if_user_has_root_previledges

	display_message_default "Uninstall ArchLinux - Pacman $@ software"

    case $DEBUG in
		"false") pacman -Rns $@ ;;
		"true") pacman -Rns --noconfirm $@ ;;
		#"true") pacman -Rns --noconfirm --needed $@ ;;
	esac

	display_message_default "ArchLinux - Pacman $@ software(s) has/have been uninstalled"
}

#label_must_be_created
tools_package_manager_fedora_dnf_cache_clean(){
	display_message_default "Clean Fedora DNF $@ cache"
		
	display_message_default "Fedora DNF $@ cache has been cleaned"
	
	display_message_empty
}

tools_package_manager_fedora_dnf_cache_make(){
	display_message_default "Make Fedora DNF $@ cache"
		
	tools_check_if_user_has_root_previledges

	dnf makecache
	
	display_message_default "Fedora DNF $@ cache has been made"
}

#label_must_be_created
tools_package_manager_fedora_dnf_repository_add(){
	display_message_default "Add Fedora DNF $@ repository"
		
	display_message_empty
	
	display_message_default "Fedora DNF $@ repository has been added"
}

#label_must_be_created
tools_package_manager_fedora_dnf_repository_remove(){
	display_message_default "Remove Fedora DNF $@ repository"
		
	display_message_empty
	
	display_message_default "Fedora DNF $@ repository has been removed"
}

tools_package_manager_fedora_dnf_repository_syncronize(){
	display_message_default "Syncronize Fedora DNF $@ repository"
		
	tools_check_if_user_has_root_previledges
	
	dnf update

	display_message_default "Fedora DNF $@ repository has been syncronized"
}

tools_package_manager_fedora_dnf_software_install_single(){
	display_message_default "Install Fedora DNF (single) $@ software(s)"
	
	tools_check_if_user_has_root_previledges

    case $AUX2 in
		"false") dnf install $@ ;;
		"true") dnf install -y $@ ;;
	esac
	
	display_message_default "Fedora DNF (single) $@ software(s) has/have been installed"
}

tools_package_manager_fedora_dnf_software_install_group(){
	tools_check_if_user_has_root_previledges

	display_message_default "Install Fedora DNF (group) $@ software(s)"

	case $AUX2 in
		"false") dnf group install --with-optional $@ ;;
		"true") dnf group install -y --with-optional $@ ;;
	esac

	display_message_default "Fedora DNF (group) $@ software(s) has/have been installed"
}

tools_package_manager_fedora_dnf_software_list(){
	display_message_default "List Fedora - DNF softwares"

	rpm -q $@
}

tools_package_manager_fedora_dnf_software_uninstall(){
	tools_check_if_user_has_root_previledges
	
	display_message_default "Uninstall Fedora - DNF $@ software"

	case $AUX2 in
		"false") dnf remove $@ ;;
		"true") dnf remove -y $@ ;;
	esac

	display_message_default "Fedora - DNF $@ software(s) has/have been uninstalled"
}
	
#label_must_be_created
tools_package_manager_fedora_yum_repository_add(){
	display_message_default "Add Fedora - YUM $@ repository"

	display_message_empty

	display_message_default "Fedora - YUM $@ repository has been added"
}

#label_must_be_created
tools_package_manager_fedora_yum_repository_remove(){
	display_message_default "Remove Fedora - YUM $@ repository"

	display_message_empty
	
	display_message_default "Fedora - YUM $@ repository has been added"
}

#label_must_be_created
tools_package_manager_fedora_yum_repository_syncronize(){
	display_message_default "Syncronize Fedora - YUM $@ repository"

	display_message_empty
	
	display_message_default "Fedora - YUM $@ repository has been syncronized"
}

#label_must_be_created
tools_package_manager_fedora_yum_software_install(){
	display_message_default "Install Fedora - YUM $@ software"

	display_message_empty
	
	display_message_default "Fedora - YUM $@ software(s) has/have been installed"
}

#label_must_be_created
tools_package_manager_fedora_yum_software_list(){
	display_message_default "List Fedora - YUM softwares"

	display_message_empty
}

#label_must_be_created
tools_package_manager_fedora_yum_software_uninstall(){
	display_message_default "Uninstall Fedora - YUM $@ software"

	display_message_empty
	
	display_message_default "Fedora - YUM $@ software(s) has/have been uninstalled"
}

tools_package_manager_ubuntu_apt_cache_clean(){
	tools_check_if_user_has_root_previledges

	display_message_default "Clean Ubuntu APT $@ cache"

	apt autoremove

	display_message_default "Ubuntu APT $@ cache has been cleaned"
}

#label_must_be_created
tools_package_manager_ubuntu_apt_repository_add(){
	display_message_default "Add Ubuntu - APT $@ repository"

	display_message_empty

	display_message_default "Ubuntu - APT $@ repository has been added"
}

#label_must_be_created
tools_package_manager_ubuntu_apt_repository_remove(){
	display_message_default "Remove Ubuntu - APT $@ repository"

	display_message_empty
	
	display_message_default "Ubuntu - APT $@ repository has been added"
}

tools_package_manager_ubuntu_apt_repository_syncronize(){
	tools_check_if_user_has_root_previledges

	display_message_default "Syncronize Ubuntu - APT $@ repository"

	apt update

	display_message_default "Ubuntu - APT $@ repository has been syncronized"
}

tools_package_manager_ubuntu_apt_software_install(){
	tools_check_if_user_has_root_previledges

	display_message_default "Install Ubuntu - APT $@ software"

    case $DEBUG in
		"false") apt-get install $@ ;;
		"true") apt-get install -y $@ ;;
	esac

	#apt install --fix-broken
	#apt install --fix-missing

	display_message_default "Ubuntu - APT $@ software(s) has/have been installed"
}

tools_package_manager_ubuntu_apt_software_list(){
	display_message_default "List Ubuntu - APT softwares"

	apt list
	#apt list --upgradable
}

#label_must_be_created
tools_package_manager_ubuntu_apt_software_setup(){
	display_message_default "Install Ubuntu - APT setup"

	display_message_empty
	
	display_message_default "Ubuntu - APT setup has been installed"
}

tools_package_manager_ubuntu_apt_software_uninstall(){
	tools_check_if_user_has_root_previledges

	display_message_default "Uninstall Ubuntu - APT $@ software"

    case $DEBUG in
		"false") apt remove $@ ;;
		"true") apt remove -y $@ ;;
	esac

	display_message_default "Ubuntu - APT $@ software(s) has/have been uninstalled"
}

tools_question_username(){
    while true; do
        read -p "Inform the username: " QUESTION_USERNAME #henrikbeck95

        case $QUESTION_USERNAME in
            "") echo "Please answer file or partition." ;;
            *) break ;;
        esac
    done
}

#############################
#Functions - Define SilverArch operating system name
#############################

#label_must_be_created
silverarch_release_set_logo(){
	display_message_empty
}

silverarch_release_set_name(){
    tools_string_replace_text \
        "/etc/os-release" \
        "PRETTY_NAME=\"Arch Linux\"" \
        "PRETTY_NAME=\"SilverArch\""
}

#############################
#Functions - Adding repositories
#############################

adding_repository_from_fedora_rpm_fusion_free(){
    tools_display_message_warning "RPM Fusion free"

	#Add RedHat Package Manager Fusion free repository
	tools_package_manager_fedora_dnf_software_install_single \
		https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
	
	display_message_success "Fedora RPM Fusion free repository has been added"

	#tools_package_manager_fedora_dnf_software_install_single \
		#https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
	
	#sudo dnf groupupdate core
	#sudo dnf groupupdate Multimedia

	tools_package_manager_fedora_dnf_repository_syncronize
}

adding_repository_from_fedora_rpm_fusion_non_free(){
    tools_display_message_warning "RPM Fusion non free"

	#Add RedHat Package Manager Fusion non-free repository
	tools_package_manager_fedora_dnf_software_install_single --nogpgcheck \
		http://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

	#tools_package_manager_fedora_dnf_software_install_single \
		#https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
	
	tools_package_manager_fedora_dnf_repository_syncronize

	display_message_success "Fedora RPM Fusion nonfree repository has been added"
}

#############################
#Functions - Downloading
#############################

download_operating_system_fedora_silverblue(){
	display_message_default "Downloading Fedora Silverblue operating system"
	
	tools_download_file "https://mirror1.cl.netactuate.com/fedora/releases/35/Silverblue/x86_64/iso/Fedora-Silverblue-ostree-x86_64-35-1.2.iso" "$HOME/Downloads/"
	cd -
	
	display_message_success "Fedora Silverblue operating system has been downloaded"
}

#############################
#Functions - Installing
#############################

install_codec_from_fedora_dnf(){
	display_message_default "Install Fedora $@ codecs"
	
	tools_check_if_user_has_root_previledges

    #Firefox
	dnf config-manager --set-enabled fedora-cisco-openh264
    
    tools_package_manager_fedora_dnf_software_install_single \
	    gstreamer1-plugin-openh264 mozilla-openh264
	
	display_message_default "Fedora $@ codecs has been installed"
}

#label_must_be_improved
install_container_distrobox_from_curl(){
	display_message_default "Install DistroBox setup"
		
	curl -s https://raw.githubusercontent.com/89luca89/distrobox/main/install | sudo sh
	
	display_message_default "DistroBox setup has been installed"
}

#label_must_be_created
install_driver_from_fedora_dnf(){
	display_message_default "Install Fedora $@ drivers"

    display_message_empty

	display_message_success "Fedora $@ drivers has been installed"
}

#label_must_be_improved
install_platform_container_docker(){
    case $NAME in
        "Alpine") display_message_empty ;;
        "Arch Linux")
            #Installation
            tools_package_manager_archlinux_pacman_software_install \
                docker \
                docker-compose

            #Enabling
            tools_system_daemon_systemd_enable_now docker

            #Checking version
            docker --version

            #Removing sudo requirement
            #getent group docker && sudo gpasswd -a $(whoami) docker && echo -e "\n***Log out and then login to apply the changes or restart the operating system***\n"

            display_message_warning "$MESSAGE_RESTART"

            #Verify that you can run docker commands without sudo
            #docker run hello-world
            ;;
        "CentOS Linux" | "Fedora") display_message_empty ;;
        *) display_message_error "" ;;
    esac
}

#label_must_be_improved
install_platform_container_podman(){
    case $NAME in
        "Alpine")
            tools_package_manager_alpine_apk_software_install podman
            tools_package_manager_alpine_apk_software_install fuse-overlayfs shadow slirp4netns

            modprobe tun
            
            useradd -mG wheel $QUESTION_USERNAME
            passwd $QUESTION_USERNAME

            usermod --add-subuids 100000-165535 $QUESTION_USERNAME
            usermod --add-subgids 100000-165535 $QUESTION_USERNAME
            
            podman system migrate
            podman run --rm hello-world
            
            #buildah buildah-doc
            ;;
        "Arch Linux")
            tools_edit_file /etc/default/grub
            #Edit the line: GRUB_CMDLINE_LINUX_DEFAULT="loglevel=3 quiet video=1920x1080 cgroup_no_v1 "all""

            grub-mkconfig -o /boot/grub/grub.cfg
            display_message_warning "$MESSAGE_RESTART"

            tools_package_manager_archlinux_pacman_software_install \
                buildah \
                crun \
                podman

                #cgroups

            tools_system_daemon_systemd_enable_now podman.socket

            ##Check the value of the Podman previledges
            # case $(sysctl kernel.unprivileged_userns_clone) in
            # 	0) 
            # 	1) 
            # 	*) display_message_error "" ;;
            # esac

            #Rootless
            touch /etc/{subuid,subgid}

            usermod --add-subuids 100000-165535 --add-subgids 100000-165535 $QUESTION_USERNAME
            grep $QUESTION_USERNAME /etc/subgid /etc/subuid
            
            #Testing - start
            echo -e "$QUESTION_USERNAME:100000:65536" > /etc/subuid
            echo -e "$QUESTION_USERNAME:100000:65536" > /etc/subgid

            echo -e "buildah:100000:65536" >> /etc/subuid
            echo -e "buildah:100000:65536" >> /etc/subgid
            #Testing - end
            
            #Check if everything is set up rightly
            tools_edit_file /etc/subgid /etc/subuid

            #Propagate changes to subuid and subgid
            podman system migrate

            #display_message_warning "$MESSAGE_RESTART"

            #sudo dnf install -y podman-docker

            ##############################
            #Podman Ngnix example
            ##############################
            #
            #man podman
            #podman search nginx
            #podman pull docker.io/library/nginx
            #podman images
            #podman run -dt 
            #sudo mkdir -p /web/
            #podman run -d -v /web/:/usr/share/nginx/html -p 8080:80/tcp nginx
            #podman ps
            #
            ##############################
            #Create a webpage, access it passthrought the firewall
            ##############################
            #
            #chown $QUESTION_USERNAME: /web/
            #echo -e "Hello world from the container" > /web/index.html
            #sudo firewall-cmd --add-port=8080/tcp
            #xgd-open http://localhost:8080
            #sudo firewall-cmd --add-port=8080/tcp --permanent
            #
            ##############################
            #Create a systemd instance for persistenting the container after reboot
            ##############################
            #
            #sudo loginctl enable-linger $QUESTION_USERNAME
            #loginctl user-status $QUESTION_USERNAME
            #mkdir -p $HOME/.config/systemd/user/
            #cd $HOME/.config/systemd/user/
            #podman generate systemd --name <container_name> --files
            #systemctl --user daemon-reload
            #systemctl --user enable <container_name>
            #display_message_warning "$MESSAGE_RESTART"
            #
            ##############################
            #Disable a systemd instance
            ##############################
            #
            #podman ps
            #systemctl --user status <container_name>
            #systemctl --user disable --now <container_name>
            #podman ps
            #podman ps -a
            #
            ##############################
            ;;
        "CentOS Linux" | "Fedora") display_message_empty ;;
        *) display_message_error "" ;;
    esac
}

install_platform_container_main(){
	display_message_default "Install $CONTAINER_MANAGER $@ platform"

    while true; do
        read -p "Inform what you want: [docker | podman | skip] " QUESTION_CONTAINER_MANAGER

        #case $CONTAINER_MANAGER in
        case $QUESTION_CONTAINER_MANAGER in
            "docker")
                install_platform_container_docker
                break
                ;;
            "podman")
                install_platform_container_podman
                break
                ;;
            "skip") break ;;
            *) echo "Please answer file or partition." ;;
        esac
    done

	display_message_success "$CONTAINER_MANAGER $@ platform has been installed"
}

#label_must_be_improved
#label_must_be_edited
install_platform_debtap(){
	display_message_default "Install Debtrap platform"

    case $NAME in
        "Alpine") display_message_empty ;;
        "Arch Linux")
            tools_package_manager_archlinux_aur_software_install \
                debtap

            debtap -u
            ;;
        "CentOS Linux" | "Fedora") display_message_empty ;;
        *) display_message_error "" ;;
    esac
	
	display_message_success "Debtrap platform has been installed"
}

#label_must_be_improved
install_platform_steam(){
	display_message_default "Install Steam platform"
    
	case $NAME in
        "Arch Linux") display_message_empty ;;
        "CentOS Linux" | "Fedora") 
        	#Add Steam repository
            sudo dnf config-manager --set-enabled rpmfusion-nonfree-steam

            #Install Steam application
            tools_package_manager_fedora_dnf_software_install_single \
                steam
            ;;
        *) display_message_error "" ;;
    esac
	
	display_message_success "Steam platform has been installed"
}

#label_must_be_improved
install_platform_virtual_machine_virt_manager(){
    case $NAME in
        "Alpine") display_message_empty ;;
        "Arch Linux") #label_must_be_fixed
            tools_check_if_virtualization_is_enabled

            #Virt-Manager
            #The Ebtables is an internet brigde software

            tools_package_manager_archlinux_pacman_software_install \
                bridge-utils \
                dnsmasq \
                ebtables \
                libvirt \
                openbsd-netcat \
                qemu \
                virt-manager

                #iptables \
                #vde2 \
                #virt-viewer
            
            #tools_package_manager_archlinux_aur_software_install \
                #libguestfs

            #Setting specific permission
            echo -e 'unix_sock_group = "libvirt"' > /etc/libvirt/libvirtd.conf
            echo -e 'unix_sock_rw_perms = "0770"' > /etc/libvirt/libvirtd.conf
            #tools_edit_file /etc/libvirt/libvirtd.conf

            #Enabling Systemd process
            tools_system_daemon_systemd_enable_now libvirtd.service
            tools_system_daemon_systemd_enable_now dnsmasq.service

            #Add user to the following groups
            gpasswd -a $QUESTION_USERNAME libvirt
            usermod -G libvirt -a $QUESTION_USERNAME
            usermod -aG libvirt $QUESTION_USERNAME

            #Create a virtual machine
            #qemu-img convert -f vdi -O qcow2 Ubuntu\ 20.04.vdi /var/lib/libvirt/images/ubuntu-20-04.qcow2

            #virsh net-dumpxml default > br1.xml
            #tools_edit_file br1.xml

            display_message_warning "$MESSAGE_RESTART"
            ;;
        "CentOS Linux" | "Fedora")
            tools_display_message_warning "Virtual machine"
            
            tools_check_if_virtualization_is_enabled

            tools_package_manager_fedora_dnf_software_install_single @virtualization

            #Alternatively, to install the mandatory, default, and optional packages, run:
            tools_package_manager_fedora_dnf_software_install_group virtualization

            #Enable Systemd service
            tools_system_daemon_systemd_enable_now libvirtd

            #To verify that the KVM kernel modules are properly loaded:
            lsmod | grep kvm
            #If this command lists kvm_intel or kvm_amd, KVM is properly configured.
            #kvm_amd               114688  0
            #kvm                   831488  1 kvm_amd
            
            display_message_success "Virtual machine"
            ;;
        *) display_message_error "" ;;
    esac
}

#label_must_be_created
install_platform_virtual_machine_virtual_box(){
    display_message_empty
}

install_platform_virtual_machine_main(){
    display_message_default "Install virtual machine platform"

    while true; do
    read -p "Inform what you want: [virt-manager | virtual-box | skip] " QUESTION_VIRTUAL_MACHINE

        case $QUESTION_VIRTUAL_MACHINE in
            "virt-manager")
                install_platform_virtual_machine_virt_manager
                break
                ;;
            "virtual-box")
                install_platform_virtual_machine_virtual_box
                break
                ;;
            "skip") break ;;
            *) echo "Please answer file or partition." ;;
        esac
    done

	display_message_success "Virtual machine platform has been installed"
}

#label_must_be_choosen
#label_must_be_improved
install_platform_wine(){
	display_message_default "Install WINE platform"

    case $NAME in
        "Alpine") display_message_empty ;;
        "Arch Linux")
            tools_package_manager_archlinux_pacman_software_install \
                wine \
                winetricks
            ;;
        "CentOS Linux" | "Fedora")
            #Install WINE
            tools_package_manager_fedora_dnf_software_install_single dnf-plugins-core

            #sudo dnf config-manager --add-repo https://dl.winehq.org/wine-builds/fedora/34/winehq.repo
            sudo dnf config-manager --add-repo https://dl.winehq.org/wine-builds/fedora/$(rpm -E %fedora)/winehq.repo
            
            tools_package_manager_fedora_dnf_software_install_single winehq-stable

            #Check if WINE gets installed
            rpm -qi winehq-stable
            wine --version
            
            #Configure WINE
            winecfg
            
            #Install WINE tricks
            wget https://raw.githubusercontent.com/Winetricks/winetricks/master/src/winetricks
            tools_give_executable_permission winetricks
            sudo mv winetricks /usr/local/bin/

            #Install WINE graphical user interface (GUI)
            tools_package_manager_fedora_dnf_software_install_single \
                lutris \
                q4wine
            ;;

        *) display_message_error "" ;;
    esac

	display_message_success "WINE platform has been installed"
}

#label_must_be_choosen
install_shell_bash(){
    display_message_warning "Installing Bash shell..."
	
    case $NAME in
        "Alpine")
			tools_package_manager_alpine_apk_software_install \
				bash \
				bash-doc \
				bash-completion
			;;
        "Arch Linux") : ;;
        "CentOS Linux" | "Fedora") : ;;
        *) display_message_error "" ;;
    esac
    
    display_message_success "Bash shell has been installed successfully!!!"
}

#label_must_be_choosen
install_shell_zsh(){
    display_message_warning "Installing ZSH shell..."

    case $NAME in
        "Alpine")
			tools_package_manager_alpine_apk_software_install \
				zsh \
				zsh-doc

			#Find username and change the default shell from /bin/ash to /bin/zsh
			tools_edit_file /etc/passwd
			echo $SHELL

			#Check the responsible files whose managing the shells
			tools_edit_file \
				/etc/login.defs \
				/etc/default/useradd
			;;
        "Arch Linux")
            tools_package_manager_archlinux_pacman_software_install \
                zsh \
                zsh-autosuggestions \
                zsh-syntax-highlighting \
                zsh-completions

            #Set ZSH as default shell
            echo -e $SHELL
            cat /etc/shells
            chsh -s /usr/bin/zsh
            display_message_warning "$MESSAGE_RESTART"
            ;;
        "CentOS Linux" | "Fedora") display_message_empty ;;
        *) display_message_error "" ;;
    esac

    display_message_success "ZSH shell has been installed successfully!!!"
}

install_softwares_from_any_binary_dropbox(){
	display_message_warning "Installing DropBox"
	
	case $($ARCHITECTURE) in
		"32-bits")
			tools_download_file https://www.dropbox.com/download?plat=lnx.x86 "$HOME/"
			tools_extract_file_tar $HOME/'download?plat=lnx.x86'
			rm 'download?plat=lnx.x86'
			;;
		"64-bits")
			tools_download_file https://www.dropbox.com/download?plat=lnx.x86_64 "$HOME/"
			tools_extract_file_tar $HOME/'download?plat=lnx.x86_64'
			rm 'download?plat=lnx.x86_64'
			;;
		*) display_message_error "" ;;
	esac

	display_message_warning "Execute daemon	(this process is going to open a DropBox web site on user default browser to authenticate an existing account)"
	$HOME/.dropbox-dist/dropboxd

	display_message_warning "Script for controlling DropBox from command line interface (CLI)."
	
	#Download the DropBox command line interface script
	tools_download_file https://www.dropbox.com/download?dl=packages/dropbox.py "$HOME/.dropbox-dist/"

	#display_message_warning ""
	
	#if [[ ! -d $HOME/.dropbox-dist/ ]]; then
		#python3 $HOME/dropbox.py start -i
	#else
		#python3 $HOME/dropbox.py start
	#fi
	
	#Give executable permission to DropBox command line interface script
	tools_give_executable_permission $HOME/.dropbox-dist/dropbox.py
	
	#Create symbolic link for DropBox command line interface script
	tools_create_path_directory $HOME/bin/

	tools_create_symbolic_link \
		$HOME/.dropbox-dist/dropbox.py \
		$HOME/bin/dropbox-cli

	#tools_create_symbolic_link \
		#$HOME/Dropbox/My\ files/scripts/*.sh \
		#$HOME/bin/
		
	#tools_create_symbolic_link \
		#$HOME/Dropbox/My\ files/scripts/dropbox.py \
		#$HOME/bin/dropbox-cli
	
	#Useful commands
	#dropbox-cli status
	#dropbox-cli autostart y
	#dropbox-cli running
	#dropbox-cli start
	#dropbox-cli status

    display_message_success "DropBox has been installed successfully!!!"
}

install_softwares_from_any_binary_joplin(){
	display_message_default "Install Joplin software from binary"

    wget -O - https://raw.githubusercontent.com/laurent22/joplin/dev/Joplin_install_and_update.sh | bash

	display_message_success "Joplin software from binary has been installed"
}

install_softwares_from_any_binary_lf(){
	display_message_default "Install LF file manager software from binary"

	tools_download_file https://github.com/gokcehan/lf/releases/download/r26/lf-linux-amd64.tar.gz "/tmp/"
	
    cd /tmp/
	tools_extract_file_tar /tmp/lf-linux-amd64.tar.gz
    cd -

	mv /tmp/lf /usr/local/bin/lf

	rm -f /tmp/lf-linux-amd64.tar.gz

	display_message_success "LF file manager software from binary has been installed"
}

install_softwares_from_any_binary_oh_my_posh(){
    display_message_default "Install Oh-My-Posh with all themes"
    
    wget https://github.com/JanDeDobbeleer/oh-my-posh/releases/latest/download/posh-linux-amd64 -O /usr/local/bin/oh-my-posh
	tools_give_executable_permission /usr/local/bin/oh-my-posh

	tools_create_path_directory /etc/skel/.poshthemes
	#tools_create_path_directory $HOME/.poshthemes

	wget https://github.com/JanDeDobbeleer/oh-my-posh/releases/latest/download/themes.zip -O /etc/skel/.poshthemes/themes.zip
	#wget https://github.com/JanDeDobbeleer/oh-my-posh/releases/latest/download/themes.zip -O $HOME/.poshthemes/themes.zip
    
	unzip /etc/skel/.poshthemes/themes.zip -d /etc/skel/.poshthemes
	#unzip $HOME/.poshthemes/themes.zip -d $HOME/.poshthemes
	
    chmod u+rw /etc/skel/.poshthemes/*.json
    #chmod u+rw $HOME/.poshthemes/*.json
	
    rm /etc/skel/.poshthemes/themes.zip
    #rm $HOME/.poshthemes/themes.zip

	display_message_success "Oh-My-Posh with all themes has been installed"
}

#label_must_be_created
install_softwares_from_any_compilation(){
    display_message_empty
}

install_softwares_from_alpine_essential(){
	tools_check_if_user_has_root_previledges

	display_message_default "Install Alpine essential softwares"

	tools_package_manager_alpine_apk_software_install
		alpine-sdk \
		curl \
		htop \
		less \
		less-doc \
		libuser \
		man-db \
		man-pages \
		neofetch
		networkmanager \
		pcutils \
		util-linux \
		xf86-video-intel \
		xf86-input-mouse \
		xf86-input-keyboard \
		xf86-input-synaptics \
		kdb \
		setxkbmap \
		udisks2 \
		udisks2-dev \
		udisks2-doc \
		vim \
		wget

		#nodejs \
		#npm \
		#rust

	display_message_success "Alpine essential softwares have been installed"
}

#label_must_be_improved
install_softwares_from_alpine_graphical_interface(){
	tools_check_if_user_has_root_previledges

	display_message_default "Install Alpine graphical interface"

	tools_package_manager_alpine_apk_software_install \
		xfce4 \
		xfce4-terminal \
		xfce4-screensaver \
		lightdm-gtk-greeter

	#rc-service dbus start && rc-update add dbus
	tools_system_daemon_openrc_enable_now "dbus"

	#rc-service lightdm start && rc-update add lightdm
	tools_system_daemon_openrc_enable_now "lightdm"

	display_message_success "Alpine graphical interface has been installed"

	startx
}

install_softwares_from_archlinux_aur(){
	display_message_default "Install softwares from ArchLinux User Repository (AUR)"
    tools_package_manager_archlinux_aur_software_install \
		barrier \
		cava

		#android-studio \
		#cava \
		#davinci-resolve \
		#dropbox \
		#google-chrome \
		#ffmpeg-full \
		#flutter \
		#lf \
		#nerd-fonts-complete \
		#ntfs3-dkms \
		#nvm \
		#polybar \
		#proton \
		#qt5-styleplugins \
		#spotify-adblock \
		#spotirec \
		#timeshift \
		#ttf-ms-fonts
	
	display_message_success "Softwares from ArchLinux User Repository (AUR) have been installed"
}

install_softwares_from_archlinux_pacman_essential(){
	display_message_default "Install essential softwares from Pacman"

    tools_package_manager_archlinux_pacman_software_install \
        alacritty \
        bash-completion \
        cheese \
        ffmpeg \
        firejail \
        git \
        gparted \
        htop \
        jq \
        linux-lts \
        lsb-release \
        neofetch \
        ntfs-3g \
        numlockx \
        redshift \
		rsync \
        scrot \
		subversion \
        tmux \
        unrar \
        unzip \
        wget

        #ark \
    	#arandr \
		#xorg-xrandr \
	
	display_message_success "Essential softwares from Pacman have been installed"
}


install_softwares_from_archlinux_pacman_laptop_battery(){
	display_message_default "Install laptop battery improvements softwares"

	#Laptop battery improvement
	tools_package_manager_archlinux_pacman_software_install \
		acpi \
		acpi_call \
		acpid \
		tlp
    
    tools_system_daemon_systemd_enable_later systemctl acpid
    tools_system_daemon_systemd_enable_later systemctl tlp #Improve battery life for laptop.

	display_message_success "Laptop battery improvements softwares have been installed"
}

#label_must_be_fixed
install_softwares_from_archlinux_pacman_manually(){
	display_message_default "Install softwares from Pacman manually"

	tools_create_path_directory $HOME/compilation/pacman/
	cd $HOME/compilation/pacman/

	#Timeshift
	tools_download_file https://mirror.clarkson.edu/manjaro/testing/community/x86_64/timeshift-21.09.1-3-x86_64.pkg.tar.zst
	pacman -U $HOME/compilation/timeshift-21.09.1-3-x86_64.pkg.tar.zst

	#Libinput
	tools_download_file https://mirror.clarkson.edu/manjaro/testing/community/x86_64/libinput-gestures-2.69-1-any.pkg.tar.zst
	pacman -U $HOME/compilation/libinput-gestures-2.69-1-any.pkg.tar.zst
	
	#Gestures
	tools_download_file https://mirror.clarkson.edu/manjaro/stable/community/x86_64/gestures-0.2.5-1-any.pkg.tar.zst
	pacman -U $HOME/compilation/gestures-0.2.5-1-any.pkg.tar.zst

	cd -

	display_message_success "Softwares from Pacman manually have been installed"
}

install_softwares_from_archlinux_pacman_useful(){
	display_message_default "Install Archlinux useful softwares"

	tools_package_manager_archlinux_pacman_software_install \
		dolphin \
		gthumb \
		lolcat \
		neofetch \
		spectacle

        #archlinux-wallpaper \
		#cmatrix \
		#firefox \
		#go \
		#kdenlive \
		#nautilus \
		#nmap \
		#obs-studio \
		#okular \
		#simplescreenrecorder \
		#vlc
	
	display_message_success "ArchLinux userful softwares have been installed"
}

install_softwares_from_archlinux_pacman_utilities(){
	display_message_default "Install ArchLinux utilities softwares"

	tools_package_manager_archlinux_pacman_software_install \
		avahi \
		dnsutils \
		firewalld \
		gvfs \
		gvfs-smb \
		hplip \
		inetutils \
		ipset \
		nfs-utils \
		nss-mdns \
		sof-firmware

		#gufw #Firewall
    
    tools_system_daemon_systemd_enable_later firewalld
    tools_system_daemon_systemd_enable_later avahi-daemon

	display_message_success "ArchLinux utilities softwares have been installed"
}

install_softwares_from_fedora_dnf_essential(){
	display_message_default "Install Fedora essential softwares"

    tools_package_manager_fedora_dnf_cache_make

	tools_package_manager_fedora_dnf_repository_syncronize

	tools_display_message_warning "RPM softwares"

	#Essential RPM packages
	tools_package_manager_fedora_dnf_software_install_single \
		cheese \
		ffmpeg \
		firejail \
		gparted \
		htop \
		ImageMagick \
		ImageMagick-perl \
		neofetch \
		openh264 \
		openh264-devel \
		scrot \
		svn \
		vim \
		unrar

	#LibreOffice Portuguese package
	tools_package_manager_fedora_dnf_software_install_single \
		libreoffice-langpack-pt-BR

	display_message_success "RPM softwares"

	display_message_success "Fedora essential softwares have been installed"
}

install_softwares_from_fedora_dnf_utilities(){
	display_message_default "Install Fedora utilities softwares"

    tools_package_manager_fedora_dnf_software_install_single \
		alien \
		epiphany \
		ghostwriter \
		gimp \
		gnome-tweaks \
		gwenview \
		native-fier \
		pdfmod \
		vlc

	#tools_package_manager_fedora_dnf_software_install_single \
		#autoconf \
		#automake \
		#binutils \
		#bison \
		#dconf-editor \
		#discord \
		#flex \
		#fontforge \
		#gcc \
		#gcc-c++ \
		#git \
		#glibc-headers \
		#glibc-devel \
		#gnome-tweak-tool \
		#joe \
		#kernel-devel \
		#kernel-headers \
		#lame \
		#libgomp \
		#libtool \
		#make \
		#mc \
		#mpv \
		#multitail \
		#net-tools \
		#openssh-server \
		#patch \
		#qt \
		#remmina \
		#remmina-plugins-rdp \
		#shutter \
		#simplescreenrecorder \
		#steam \
		#tree \
		#chrome-gnome-shell \
		#ctags \
		#cmake \
		#clang \
		#dkms

	#How can I copy&paste from the host to a KVM guest?
	#tools_package_manager_fedora_dnf_software_install_single \
		#spice-vdagent

	#sudo dnf install https://staruml.io/download/releases-v4/StarUML-4.1.6.x86_64.rpm
	#sudo dnf remove staruml

	display_message_success "Fedora utilities softwares have been installed"
}

install_softwares_from_fedora_dnf_useful(){
	display_message_default "Install Fedora useful softwares"

    tools_package_manager_fedora_dnf_software_install_single \
        ark \
        audacity \
        calibre \
        cheese \
        color picker \
        Déjà Dup Backups \
        discord \
        deepin-screenshot \
        dolphin-emulator \
        eclipse \
        epic-games \
        gestures \
        gimp \
        google-earth \
        gparted \
        gnu-octave \
        gpick \
        gwenview \
        inkscape \
        insomnia \
        inversalius \
        keepassxc \
        kinect \
        netbeans \
        postman \
        qalculate \
        rpcs3 \
        spectacle \
        telegram desktop \
        timeshift \
        transmission \
        vlc
	
	#Enable VirtualBox copy/cut mouse
	#tools_package_manager_fedora_dnf_software_install_single \
		#spice-vdagent

	display_message_success "Fedora useful softwares have been installed"
}

install_softwares_from_ubuntu_apt_essential(){
	display_message_default "Install Ubuntu essential softwares"

	tools_package_manager_ubuntu_apt_software_install \
        build-essential \
        cheese \
        cpu-checker \
        curl \
        ffmpeg \
        git \
        gnupg2 \
        gparted \
        htop \
        jq \
        lutris \
        pciutils \
        redshift \
        scrot \
        spectacle \
        subversion \
		timeshift \
        unrar \
        util-linux
        vim \
        virt-manager \
        wget \
        yad

	#Enable VirtualBox copy/cut mouse
	tools_package_manager_ubuntu_apt_software_install \
		spice-vdagent

	#tools_package_manager_ubuntu_apt_software_install \
        #alsa-base \
        #alsa-utils \
        #libsbigudrv2 \
        #libsbigudrv0 \
        #linux-sound-base \
        #linux-headers-`uname -r` \
        #nodejs-lts \
        #npm \
        #pavucontrol \
        #yarn

    #apt_reinstall \
        #linux-image-generic

	display_message_success "Ubuntu essential softwares have been installed"
}

install_softwares_from_ubuntu_apt_wine(){
	display_message_default "Install Ubuntu WINE platform"

    sudo dpkg --add-architecture i386
    wget -nc https://dl.winehq.org/wine-builds/winehq.key
    sudo apt-key add winehq.key
    sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys DFA175A75104960E
    tools_package_manager_ubuntu_apt_software_install install software-properties-common 
    sudo apt-add-repository 'deb https://dl.winehq.org/wine-builds/ubuntu/ bionic main' 
    sudo apt-add-repository 'deb https://download.opensuse.org/repositories/Emulators:/Wine:/Debian/xUbuntu_18.04/ ./'
    tools_package_manager_ubuntu_apt_software_install install --install-recommends winehq-stable
    winecfg

	display_message_success "Ubuntu WINE platform has been installed"
}

##########################################################################################
#DONE SO FAR
##########################################################################################

#######################################################################################
#Functions - LIMBO
#######################################################################################

#label_operating_system
install_driver_audio(){
	tools_package_manager_archlinux_pacman_software_install \
        alsa-utils \
        pavucontrol

	while true; do
		read -p "Inform what you want: [pipewire/pulseaudio/none] " QUESTION_SWAP

		case $QUESTION_SWAP in
			"pipewire")
                tools_package_manager_archlinux_pacman_software_install \
                    pipewire \
                    pipewire-alsa \
                    pipewire-pulse \
                    pipewire-jack
				
                break
				;;
			"pulseaudio")
            	tools_package_manager_archlinux_pacman_software_install \
                    pulseaudio

				break
				;;
			"none") break ;;
			*) echo "Please answer question." ;;
		esac
	done
}

#label_operating_system
install_driver_bluetooth(){
	tools_package_manager_archlinux_pacman_software_install \
        bluez \
        bluez-utils

	tools_system_daemon_systemd_enable_now bluetooth
}

#label_operating_system
install_driver_printer(){
	tools_package_manager_archlinux_pacman_software_install \
        cups

	tools_system_daemon_systemd_enable_now cups.service
}

#label_operating_system
install_driver_graphic_video(){
	display_message_default "Install video driver"

    display_message_default "Install video driver for VirtualBox virtual machine video driver"
	tools_package_manager_archlinux_pacman_software_install \
        virtualbox-guest-utils

    display_message_default "Install video driver for VMWare virtual machine video driver"
	tools_package_manager_archlinux_pacman_software_install \
        xf86-video-vmware

    display_message_default "Install video driver for X Window System QXL driver including Xspice server for virtual machine"
	tools_package_manager_archlinux_pacman_software_install \
        xf86-video-qxl

	while true; do
        #Select the option according to your graphic video manufacturer.
        lspci | grep -e VGA -e 3D

		read -p "Inform what you want: [amd/intel/nvidia/none] " QUESTION_SWAP

		case $QUESTION_SWAP in
			"amd")
				tools_package_manager_archlinux_pacman_software_install \
                    xf86-video-amdgpu

				break
				;;
			"intel")
				tools_package_manager_archlinux_pacman_software_install \
                    xf86-video-intel

				break
				;;
			"nvidia")
				tools_package_manager_archlinux_pacman_software_install \
                    nvidia \
                    nvidia-utils \
                    nvidia-settings

				break
				;;
			"none") break ;;
			*) echo "Please answer question." ;;
		esac
	done
}

#label_operating_system
install_desktop_enviroment_main(){
	display_message_default "Install desktop environment"

	while true; do
		read -p "Inform what you want: [deepin/gnome/i3/kde/xfce/none] " QUESTION_DESKTOP_ENVIRONMENT

		case $QUESTION_DESKTOP_ENVIRONMENT in
			"deepin")
				install_desktop_enviroment_deepin
				break
				;;
            "gnome")
				install_desktop_enviroment_gnome
				break
				;;
			"i3")
				install_desktop_enviroment_i3
				break
				;;
			"kde")
				install_desktop_enviroment_kde
				break
				;;
			"xfce")
				install_desktop_enviroment_xfce
				break
				;;
			"none") break ;;
			*) echo "Please answer question." ;;
		esac
	done
}

#label_operating_system
install_desktop_enviroment_deepin(){
    tools_package_manager_archlinux_pacman_software_install \
		xorg \
		deepin \
		deepin-extra \
		lightdm
		#xorg-server

	echo "greeter-session=lightdm-deepin-greeter" >> /etc/lightdm/lightdm.conf
	#echo "display-setup-script=xrandr --output virtual-1 --mode 1920x1080" >> /etc/lightdm/lightdm.conf

	tools_system_daemon_systemd_enable_later lightdm.service

	display_message_warning "$MESSAGE_RESTART"
}

#label_operating_system
install_desktop_enviroment_gnome(){
	tools_package_manager_archlinux_pacman_software_install \
        xorg \
        gdm \
        gnome \
        gnome-extra \
        gnome-tweaks

	tools_system_daemon_systemd_enable_later gdm

	display_message_warning "$MESSAGE_RESTART"
}

#label_operating_system
install_desktop_enviroment_i3(){
	tools_package_manager_archlinux_pacman_software_install \
        xorg \
        i3 \
        dmenu \
		feh \
        lxappearance \
        nitrogen \
		polybar \
		rofi
	
	install_lock_screen
}

install_softwares_from_ubuntu_apt_graphical_interface_i3(){
	display_message_default "Install Ubuntu i3 desktop environment"

    tools_package_manager_ubuntu_apt_software_install \
        cava \
        feh \
        gnome-center-control \
        i3 \
        i3-gaps \
        i3-lock \
        lxappearence \
        network-manager-gnome \
        polybar \
        rofi \
        ubiquity

    #Cava
    sudo add-apt-repository ppa:hsheth2/ppa
    tools_package_manager_ubuntu_apt_software_install update
    tools_package_manager_ubuntu_apt_software_install install cava

	display_message_success "Ubuntu i3 desktop environment has been installed"
}

#label_operating_system
install_desktop_enviroment_kde(){
	tools_package_manager_archlinux_pacman_software_install \
        xorg \
        sddm \
        plasma \
        materia-kde
	    #kde-applications

	tools_system_daemon_systemd_enable_later sddm

	display_message_warning "$MESSAGE_RESTART"
}

#label_operating_system
install_desktop_enviroment_xfce(){
	tools_package_manager_archlinux_pacman_software_install \
        xorg \
        lightdm \
        lightdm-gtk-greeter \
        lightdm-gtk-greeter-settings \
        xfce4 \
        xfce4-goodies

	tools_system_daemon_systemd_enable_later lightdm

	display_message_warning "$MESSAGE_RESTART"
}

#label_operating_system
install_desktop_utils(){
	tools_package_manager_archlinux_pacman_software_install \
        xdg-user-dirs \
        xdg-utils
}

#label_operating_system
install_lock_screen(){
	display_message_default "Install lock screen"

	while true; do
		read -p "Inform what you want: [lightdm/ly/none] " QUESTION_LOCK_SCREEN

		case $QUESTION_LOCK_SCREEN in
			"lightdm")
                gnome-disk-utility \
                lightdm \
                lightdm-gtk-greeter \
                lightdm-gtk-greeter-settings

                tools_system_daemon_systemd_enable_later lightdm.service -f
                systemctl set-default graphical.target
                
				break
				;;
            "ly")
                git clone https://aur.archlinux.org/ly
                cd ./ly/
                makepkg -si
                
                tools_system_daemon_systemd_enable_later ly.service

				break
				;;
			"none") break ;;
			*) echo "Please answer question." ;;
		esac
	done

	display_message_warning "$MESSAGE_RESTART"
}

#label_operating_system
install_network_interface(){
	tools_package_manager_archlinux_pacman_software_install \
        dhcpcd

	tools_system_daemon_systemd_enable_now dhcpcd
}

#label_operating_system
install_support_ssh(){
	display_message_default "Installing SSH connect support"
		
	tools_package_manager_archlinux_pacman_software_install \
		openssh

	tools_system_daemon_systemd_enable_now sshd.service
}

install_virtual_machine_cockpit(){
    tools_check_if_user_has_root_previledges

    case $NAME in
        "Arch Linux")
			tools_package_manager_archlinux_pacman_software_install
				cockpit \
				cockpit-machines \
				cockpit-pcp \
				cockpit-podman

			tools_package_manager_archlinux_aur_software_install \
				packagekit \
				pcp \
				virt-viewer

			#Enabling Systemd process
            tools_system_daemon_systemd_enable_now cockpit.socket
            tools_system_daemon_systemd_enable_now cockpit.pmcd
            tools_system_daemon_systemd_enable_now pmlogger
            ;;
        "CentOS Linux" | "Fedora")
            display_message_empty
            ;;
        "Ubuntu")
            tools_package_manager_ubuntu_apt_software_install \
                cockpit \
                cockpit-machines \
                cockpit-podman \
                virt-manager
            ;;
        *) display_message_error "" ;;
    esac

    cat /etc/systemd/system/cockpit.socker.d/listen.conf

	#Access Cockpit localhost from browser
	#xdg-open https://localhost:9090/
}

install_virtual_machine_virtmanager(){
    tools_check_if_user_has_root_previledges

    case $NAME in
        "Arch Linux")
            display_message_empty
            ;;
        "CentOS Linux" | "Fedora")
            display_message_empty
            ;;
        "Ubuntu")
            tools_package_manager_ubuntu_apt_software_install \
                qemu-kvm qemu virt-manager virt-viewer libvirt-bin
            ;;
        *) display_message_error "" ;;
    esac
}

#label_operating_system
#label_must_be_improved
install_virtual_machine_virtualbox(){
	#VirtualBox shared folder
	sudo adduser henrikbeck95 vboxsf
	#sudo usermod -aG vboxsf henrikbeck95
	#sudo chown -R henrikbeck95:henrikbeck95 /home/henrikbeck95/shared/
}

#############################
#Functions - Operating system
#############################

#label_must_be_improved
#label_must_be_edited
operating_system_alpine_create_user(){
	tools_check_if_user_has_root_previledges

	tools_edit_file /etc/apk/repositories
	apk update
	tools_package_manager_alpine_apk_software_install sudo

	local MY_USER_CREDENTIALS="Henrik Beck"
	local MY_USERNAME="henrikbeck95"

	adduser -g "$MY_USER_CREDENTIALS" $MY_USERNAME
	adduser $MY_USERNAME wheel

	visudo
}

operating_system_archlinux_changing_hostname(){
	display_message_default "Change the hostname"

	#Applying the hostname to /etc/hostname file
	read -p "Inform the hostname you want: " QUESTION_HOST #biomachine
	echo "$QUESTION_HOST" > /etc/hostname #biomachine

	#Applying the hostname to /etc/hosts file
	echo -e "
	127.0.0.1\t\tlocalhost
	::1\t\t\tlocalhost
	127.0.0.1\t\t$QUESTION_HOST.localdomain\t\t$QUESTION_HOST" >> /etc/hosts
}

changing_language(){
	display_message_default "Change the language"

	#tools_edit_file /etc/locale.gen #Uncomment the pt_BR.UTF-8 UTF-8 line
	locale-gen
	
	echo LANG=en_US.UTF-8 >> /etc/locale.conf
	#echo LANG=pt_BR.UTF-8 >> /etc/locale.conf

	echo KEYMAP=br-abnt2 >> /etc/vconsole.conf
}

operating_system_archlinux_changing_language_keyboard(){
	display_message_default "Changing the keyboard layout settings"
	
	loadkeys $LAYOUT_KEYBOARD
}

operating_system_archlinux_changing_language_default(){
	display_message_default "Changing for Brazilian Portuguese keymap"

	#Uncomment the line: # pt_BR.UTF-8 UTF-8
	local FILENAME="/etc/locale.gen"

	TEXT_OLD="#pt_BR.UTF-8 UTF-8"
	TEXT_NEW="pt_BR.UTF-8 UTF-8"
	sed -i "s/$TEXT_OLD/$TEXT_NEW/g" $FILENAME

	#tools_edit_file $FILENAME
	
	#Apply the new settings
	export LANG=pt_BR.UTF-8
}

operating_system_archlinux_changing_password_root(){
	display_message_default "Change the root password"

	passwd
}

operating_system_archlinux_changing_timezone(){
	display_message_default "Search for UTC time zone"
	timedatectl list-timezones | grep Sao_Paulo
	
	display_message_default "Apply the UTC time zone"
	ln -sf /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime
	
	display_message_default "Sync UTC clock with the hardware machine"
	hwclock --systohc --utc #UTC clock

	#timedatectl set-ntp true
	#hwclock --systohc #Hardware clock
}

operating_system_archlinux_mount_chroot(){
	display_message_default "Log in as root on the ArchLinux which is going to be installed (not the installer iso one)"
	
	#Run a single command and exit
	#arch-chroot /mnt/root cp $0
	#arch-chroot /mnt/usr/bin/ cp $0

	#Enter a chroot
	#arch-chroot /mnt/
}

operating_system_archlinux_creating_fstab(){
	display_message_default "Generate the /etc/fstab file"
	
	genfstab -U /mnt >> /mnt/etc/fstab

	#Check if the /etc/fstab file was generated correctly
	cat /mnt/etc/fstab
}

#label_must_be_tested
operating_system_archlinux_creating_new_user(){
	display_message_default "Create a new user account to be ready to log in after the installation setup is done"

	useradd -mG wheel $QUESTION_USERNAME
	passwd $QUESTION_USERNAME

	#Add user to groups
	gpasswd -a $QUESTION_USERNAME audio
	gpasswd -a $QUESTION_USERNAME daemon
	gpasswd -a $QUESTION_USERNAME dbus
	gpasswd -a $QUESTION_USERNAME disk
	gpasswd -a $QUESTION_USERNAME games
	gpasswd -a $QUESTION_USERNAME lp
	gpasswd -a $QUESTION_USERNAME network
	gpasswd -a $QUESTION_USERNAME optical
	gpasswd -a $QUESTION_USERNAME power
	gpasswd -a $QUESTION_USERNAME rfkill
	gpasswd -a $QUESTION_USERNAME scanner
	gpasswd -a $QUESTION_USERNAME storage
	gpasswd -a $QUESTION_USERNAME users
	gpasswd -a $QUESTION_USERNAME video
}

#label_must_be_tested
operating_system_archlinux_connecting_internet_wifi(){
	display_message_default "Connect to Wi-Fi network"

	while true; do
		read -p "Inform what you want (when finish type skip): [iwctl/terminal/skip] " QUESTION_WIFI_METHOD

		case $QUESTION_WIFI_METHOD in
			"iwctl")
                display_message_warning "iwctl Wi-Fi connect\n\n> #device list\n> #station wlan0 scan\n> #station wlan0 get-networks\n> #station wlan0 connect <wireless network name>\n> #exit"

        	    iwctl
				;;
            "terminal")
                #Unblock driver
                rfkill list
                rfkill unblock wifi

                #Iwd commands
                #iwctl device list
                #iwctl station list
                iwtcl device wlan0 set-property Powered on
                iwctl station wlan0 scan
                iwctl station wlan0 get-networks

		        read -p "Inform the Wi-Fi network name you want to connect: " QUESTION_WIFI_NAME
                iwctl station wlan0 connect $QUESTION_WIFI_NAME
				;;
			"skip") break ;;
			*) echo "Please answer question." ;;
		esac

		#Testing the network connection
	    ping -c 3 archlinux.org
	done
}

#label_must_be_tested
#MUST BE IMPLEMENTED SED CUT FUNCTION
operating_system_archlinux_connecting_ssh(){
	display_message_default "Install OpenSSH software"
	pacman -Syy openssh
	tools_system_daemon_systemd_enable_now sshd.service
	tools_edit_file /etc/ssh/sshd_config #Uncomment the port 22
	
	display_message_default "Change Root password"
	passwd root
	
	display_message_default "Get the ip address"
	ip addr
	
	display_message_default "Auxiliar machine\n	
	For rightly configuring the another PC with Linux, follow the steps below:
	
	$ sudo apt install openssh-client
	$ ssh -l <username> <ip_address>
	or $ ssh root@<ip_address>
	or $ ssh-keygen -f \"/home/your_user/.ssh/known_hosts\" -R \"192.168.1.221\""
}

#label_must_be_edited
operating_system_archlinux_database_software_reflector(){
	timedatectl set-ntp true
	hwclock --systohc

	while true; do
		read -p "Inform the name of your country: [Brazil | bash | zsh | skip] " QUESTION_TERMINAL_HISTORY

		case $QUESTION_TERMINAL_HISTORY in
			"Brazil") break ;;
			#"zsh") break ;;
			"skip") QUESTION_TERMINAL_HISTORY="Brazil" ;;
			*) echo "Please answer file or partition." ;;
		esac
	done

	reflector -c $QUESTION_TERMINAL_HISTORY -a 12 --sort rate --save /etc/pacman.d/mirrorlist
	pacman -Sy

	firewall-cmd --add-port=1025-65535/tcp --permanent
	firewall-cmd --add-port=1025-65535/udp --permanent
	firewall-cmd --reload
}

#label_must_be_tested
operating_system_archlinux_editing_sudo_properties(){
	display_message_default "Setting the Vim as the default text editor and also edit the visudo file"

	#Uncomment the line: # %wheel ALL=(ALL) ALL
	tools_string_replace_text "/etc/sudoers" "# %wheel ALL=(ALL) ALL" "%wheel ALL=(ALL) ALL"
	#echo "ermanno ALL=(ALL) ALL" >> /etc/sudoers.d/ermanno

	EDITOR=vim visudo
}

#label_must_be_fixed
operating_system_archlinux_enabling_support_32_bits(){
	display_message_default "Enable 32 bits support"

	while true; do
		read -p "Do you want to enable 32 bits support? [Y/n] " QUESTION_PARTITION
		case $QUESTION_PARTITION in
			[Yy]*)
				local PATH_REPOSITORY="/etc/pacman.conf"

				#############################
				#Multilib module
				#############################

				#local CONTENT_LINE_STRING_CURRENT="#\[multilib]"
				local CONTENT_LINE_STRING_CURRENT="#\[testing]"
				local CONTENT_LINE_NUMBER_CURRENT=$(cat $PATH_REPOSITORY | grep -n "$CONTENT_LINE_STRING_CURRENT" | awk -F: '{print $1}')
				local CONTENT_LINE_NUMBER_BELOW=$(($CONTENT_LINE_NUMBER_CURRENT+1))

				#Uncomment the match+1 line
				display_message_warning "Editing module Multilib"
				tools_string_replace_text "$PATH_REPOSITORY" "$CONTENT_LINE_STRING_CURRENT" "[multilib]"
				tools_string_replace_number "$PATH_REPOSITORY" "$CONTENT_LINE_NUMBER_BELOW" "Include = \/etc\/pacman.d\/mirrorlist"

				unset $CONTENT_LINE_STRING_CURRENT
				unset $CONTENT_LINE_NUMBER_CURRENT
				unset $CONTENT_LINE_NUMBER_BELOW

				#############################
				#Multilib-testing module
				#############################

				local CONTENT_LINE_STRING_CURRENT="#\[multilib-testing]"
				local CONTENT_LINE_NUMBER_CURRENT=$(cat $PATH_REPOSITORY | grep -n "$CONTENT_LINE_STRING_CURRENT" | awk -F: '{print $1}')
				local CONTENT_LINE_NUMBER_BELOW=$(($CONTENT_LINE_NUMBER_CURRENT+1))

				#Uncomment the match+1 line
				display_message_warning "Editing module Multilib-Testing"
				tools_string_replace_text "$PATH_REPOSITORY" "$CONTENT_LINE_STRING_CURRENT" "[multilib-testing]"
				tools_string_replace_number "$PATH_REPOSITORY" "$CONTENT_LINE_NUMBER_BELOW" "Include = \/etc\/pacman.d\/mirrorlist"

				unset $CONTENT_LINE_STRING_CURRENT
				unset $CONTENT_LINE_NUMBER_CURRENT
				unset $CONTENT_LINE_NUMBER_BELOW

				#############################
				#Verify if file has been created correctly
				#############################

				tools_edit_file $FILENAME
				break
				;;
			[Nn]*) break ;;
			*) echo "Please answer Y for yes or N for no." ;;
		esac
	done
}

#label_must_be_fixed
operating_system_archlinux_installing_bootloader(){
	display_message_default "Installing packages for the bootloader and the network tools"

	tools_package_manager_archlinux_pacman_software_install \
        grub \
		base-devel \
		cron \
		dialog \
		dosfstools \
		efibootmgr \
		linux-lts-headers \
		mtools \
		networkmanager \
		network-manager-applet \
		os-prober \
		reflector \
		wireless_tools \
		wpa_supplicant

	#Enable the NetworkManager 
	tools_system_daemon_systemd_enable_now NetworkManager.service

	#Enable Reflector
    tools_system_daemon_systemd_enable_later reflector.timer
    tools_system_daemon_systemd_enable_later fstrim.timer

	#Configuring GRUB by commenting the line: MODULES=()
	tools_string_replace_text \
		"/etc/mkinitcpio.conf" \
		"MODULES=()" \
		"MODULES=(btrfs)"

	#tools_edit_file $FILENAME #Add text: MODULES=(btrfs)
	mkinitcpio -p linux

	#Applying GRUB
	case $IS_BIOS_UEFI in #label_must_be_fixed
		"legacy")
			#grub-install --target=x86_64-efi --bootloader-id=GRUB
			#grub-install --target=x86_64-efi --boot-directory=/boot/efi --bootloader-id=GRUB
			#efibootmgr -c -d /dev/sda -p 1 -L "ArchLinux" -l \vmlinuz-linux -u "root=/dev/sda2 rw initrd=/initramfs-linux.img"
			display_message_error "
			Sorry but I do not how to install GRUB on BIOS legacy machine
			If you know how, please inform the developer the procedure for implementing it.
			For now, the commands must be implemented manually
			Do not worry, this is the last step to be done."

			exit 0
			;;
		"uefi") 
			grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=GRUB

			grub-mkconfig -o /boot/grub/grub.cfg
			;;
		*)
			display_message_error "The BIOS could not be identified!"
			exit 0
			;;
	esac
}

operating_system_archlinux_install_system_base(){
	display_message_default "Install the system base"

	pacstrap /mnt/ \
		base \
		btrfs-progs \
		linux-firmware \
		linux-lts \
		vim

	case $PROCESSOR in
		"AuthenticAMD") pacstrap /mnt/ amd-ucode ;;
		"GenuineIntel") pacstrap /mnt/ intel-ucode ;;
		*)
			display_message_error "Your processor could not be identified!"
			exit 0
		;;
	esac
}

#label_must_be_improved
operating_system_archlinux_partiting_disk(){
	display_message_default "Make the partitions"

	#Creating the partitions
	while true; do
		cfdisk $PARTITION_PATH

		read -p "Do you want to procedure? [Y/n] " QUESTION_PARTITION
		case $QUESTION_PARTITION in
			[Yy]*) break ;;
			[Nn]*) : ;;
			*) echo "Please answer Y for yes or N for no." ;;
		esac
	done

	#sudo mkfs.btrfs -L data /dev/sdb1
	#mkfs.btrfs -L mylabel /dev/partition
	#mkfs.btrfs -L mylabel -n 32k /dev/partition
	
	#Formatting the partitions
	if [[ -z $PARTITION_BOOT ]]; then
		#mkfs.fat -F32 $PARTITION_BOOT
		#mkfs.fat -F32 -n ESP $PARTITION_BOOT
		mkfs.fat -F32 -n BOOT $PARTITION_BOOT
	fi

	if [[ -z $PARTITION_ROOT ]]; then
		#mkfs.btrfs -f $PARTITION_ROOT
		mkfs.btrfs -f -L ROOT $PARTITION_ROOT
	fi
	
	if [[ -z $PARTITION_FILE ]]; then
		#mkfs.ext4 -f $PARTITION_FILE
		mkfs.ext4 -f -L FILES $PARTITION_FILE
	fi

	#Listing all the partition table
	lsblk
}

#label_must_be_fixed
operating_system_archlinux_partiting_mounting(){
	display_message_default "Mount the partitions"

	#Mounting the root partition
	mount $PARTITION_ROOT /mnt/

	#Creating subvolumes for BTRFS
	btrfs su cr /mnt/@/

	#Mounting root subvolume
	umount /mnt/
	mount -o compress=lzo,subvol=@ $PARTITION_ROOT /mnt/
	
	#Listing all the partition table
	lsblk

	#Mounting boot
	case $IS_BIOS_UEFI in
		"legacy") 
			#label_must_be_fixed
			#mkdir -p /mnt/boot/
			#mount $PARTITION_BOOT /mnt/boot/

			display_message_error "
			Sorry but I do not how to install GRUB on BIOS legacy machine
			If you know how, please inform the developer the procedure for implementing it.
			For now, the commands must be implemented manually
			Do not worry, this is the last step to be done."

			exit 0
			;;
		"uefi") 
			mkdir -p /mnt/boot/efi/
			mount $PARTITION_BOOT /mnt/boot/efi/
			;;
		*)
			display_message_error "The BIOS could not be identified!"
			exit 0
			;;
	esac

	#Listing all the partition table
	lsblk
}

#label_must_be_fixed
operating_system_fedora_version_upgrade(){
    #Replace repository database
	sudo dnf upgrade
	tools_package_manager_fedora_dnf_repository_syncronize
	sudo dnf --refresh upgrade
	tools_package_manager_fedora_dnf_software_install_single dnf-plugin-system-upgrade --best
	
    #Upgrade distro version - Fedora
	#sudo dnf system-upgrade download --refresh --releasever=35
	#sudo dnf system-upgrade download --refresh --releasever=$(rpm -E %fedora) #MUST ADD +1
	sudo dnf system-upgrade download --refresh --releasever=$(($(rpm -E %fedora)+1)) #MUST ADD +1
}

#############################
#Appearance
#############################

#label_must_be_created
appearance_fonts(){
	#
	#sudo chown henrikbeck95:henrikbeck95 -R /home/henrikbeck95/.fonts/
	
	#Firacode font
	#wget https://github.com/tonsky/FiraCode/releases/download/5.2/Fira_Code_v5.2.zip
	
	tools_update_fonts_cache
}

#label_must_be_improved
#label_must_be_edited
appearance_settings_desktop_environment_gnome(){
	#List all the Gnome settings commands
	#clear && gsettings list-recursively | grep "$1" | less
	#gsettings list-recursively | egrep "Alt|Shift|Super|Space|Win|Meta|Primary|Control|Ctrl|Tab" | grep org.gnome | awk '{print $1}' | sort -u
	#clear && gsettings list-recursively | grep col
	
	#Fedora
	gsettings get org.gnome.shell favorite-apps
	gsettings set org.gnome.mutter center-new-windows 'true'
	gsettings set org.gnome.desktop.wm.preferences button-layout ':minimize,maximize,close'
	gsettings set org.gnome.desktop.wm.preferences button-layout ':close'

	#
	gsettings set org.gnome.desktop.background show-desktop-icons true
	gsettings set org.gnome.desktop.interface clock-show-date true
	gsettings set org.gnome.nautilus.preferences show-hidden-files true

	#Ubuntu
	gsettings reset org.gnome.desktop.app-folders folder-children #Removed all the folders
	gsettings reset org.gnome.desktop.sound allow-volume-above-100-percent
	
	gsettings set org.gnome.desktop.a11y always-show-universal-access-status true
	gsettings set org.gnome.desktop.background show-desktop-icons true
	gsettings set org.gnome.desktop.interface show-battery-percentage true
	
	gsettings set org.gnome.gedit.preferences.editor auto-indent true
	gsettings set org.gnome.gedit.preferences.editor bracket-matching true
	gsettings set org.gnome.gedit.preferences.editor display-line-numbers true
	gsettings set org.gnome.gedit.preferences.editor highlight-current-line true
	gsettings set org.gnome.gedit.preferences.editor tabs-size 4
	
	gsettings set org.gnome.mutter center-new-windows true
	gsettings set org.gnome.mutter focus-change-on-pointer-rest true
	
	gsettings set org.gnome.shell.extensions.dash-to-dock dash-max-icon-size 32
	gsettings set org.gnome.shell.extensions.dash-to-dock dock-position RIGHT
	gsettings set org.gnome.shell.extensions.dash-to-dock show-favorites true
	gsettings set org.gnome.shell.extensions.dash-to-dock show-windows-preview true
	gsettings set org.gnome.shell.extensions.desktop-icons show-home false
	gsettings set org.gnome.shell.extensions.desktop-icons show-trash false
}

#label_must_be_choosen
#label_must_be_improved
appearance_shell_theme_starship(){
	sh -c "$(curl -L https://starship.rs/install.sh)"
	echo 'eval "$(starship init bash)"' >> ~/.bashrc
	echo 'eval "$(starship init zsh)"' >> ~/.zshrc
}

#label_must_be_improved
appearance_theme_gtk_adwaita(){
    #Create specific path
    mkdir -p $HOME/.themes/
    cd $HOME/.themes/
    
    #???
    git clone https://github.com/Gnostiphage/adwaita-color-gen.git
    ln -sf $HOME/.themes/adwaita-color-gen/generated/* $HOME/.themes/
    
    #???
    git clone https://github.com/vinceliuice/Orchis-theme.git
    ln -sf $HOME/.themes/Orchis-theme/release/*.tar.xz $HOME/.themes/

	#
	gsettings set org.gnome.desktop.interface gtk-theme Adwaita
	#gsettings set org.gnome.desktop.interface gtk-theme Adwaita-dark
}

#label_must_be_improved
appearance_theme_gtk_dracula(){
	gsettings set org.gnome.desktop.interface gtk-theme "Dracula"
	gsettings set org.gnome.desktop.wm.preferences theme "Dracula"
}

#label_must_be_improved
appearance_theme_gedit_dracula(){
	wget https://raw.githubusercontent.com/dracula/gedit/master/dracula.xml

	display_message_warning "Must open Gedit application and set load this file manually"
}

#label_must_be_improved
appearance_theme_libreoffice_dracula(){
	git clone https://github.com/dracula/libreoffice.git ~/Documents/libroffice
	tools_edit_file ~/Documents/dracula/libroffice/add_dracula_application_colors.sh
	~/Documents/dracula/libroffice/add_dracula_application_colors.sh
}

#############################
#Functions - Calling
#############################

calling_essential(){
	tools_check_if_internet_connection_exists
	tools_check_if_user_has_root_previledges

	tools_export_variables_bios
	tools_export_variables_virtualization
	tools_export_variables_processor

	#operating_system_archlinux_setup_installation_script_download
	cd $SILVERARCH_SCRIPT_PATH/
}

calling_alpine(){
	calling_essential
    tools_question_username

    #operating_system_archlinux_changing_language_keyboard
    #operating_system_archlinux_changing_language_default
    
	operating_system_alpine_create_user
	install_softwares_from_alpine_essential
	install_softwares_from_alpine_graphical_interface
	install_shell_bash
	install_shell_zsh

    display_message_warning "Script has been finished!"
}

calling_archlinux_part_01(){
    calling_essential
    tools_question_username

    operating_system_archlinux_changing_language_keyboard
    operating_system_archlinux_changing_language_default

    if [[ $IS_VIRTUALIATION != "kvm" ]]; then
        operating_system_archlinux_connecting_internet_wifi
        #operating_system_archlinux_connecting_ssh
    fi

    operating_system_archlinux_partiting_disk
    operating_system_archlinux_partiting_mounting
    operating_system_archlinux_install_system_base
    operating_system_archlinux_creating_fstab
    operating_system_archlinux_mount_chroot

    display_message_warning "Script has been finished!"
}

calling_archlinux_part_02(){
    calling_essential
    tools_question_username

    #Working
    tools_partiting_swap
    operating_system_archlinux_changing_timezone
    changing_language
    operating_system_archlinux_changing_hostname
    operating_system_archlinux_enabling_support_32_bits
    tools_package_manager_archlinux_pacman_repository_syncronize
    operating_system_archlinux_changing_password_root
    operating_system_archlinux_creating_new_user
    operating_system_archlinux_editing_sudo_properties
    install_support_ssh
    operating_system_archlinux_installing_bootloader #Including base-devel
    
    #Testing
	install_softwares_from_archlinux_pacman_manually
    operating_system_archlinux_database_software_reflector
    install_softwares_from_archlinux_pacman_essential
	install_softwares_from_archlinux_pacman_laptop_battery
	install_softwares_from_archlinux_pacman_utilities
    tools_package_manager_any_flatpak_software_setup
	install_shell_zsh
    
    install_softwares_from_any_binary_lf
    install_platform_virtual_machine_main
    install_platform_container_main
    install_container_distrobox_from_curl
    tools_package_manager_any_asdf_software_setup

    install_desktop_utils
    install_desktop_enviroment_main
    install_driver_audio
    install_driver_bluetooth
    install_driver_printer
    install_driver_graphic_video
    install_network_interface

    #silverarch_release_set_logo
    silverarch_release_set_name

    tools_package_manager_any_vim_vundle_software_setup
	tools_package_manager_any_asdf_software_setup

	tools_backup_create "SilverArch installation setup completed!"
    
    display_message_success "Script has been finished!"
    display_message_warning "Verify if everything is okay and then go back to the livecd mode by typing:\n\t> $ exit\n\t> $ umount -a\n\t> $ systemctl reboot"
}

calling_archlinux_part_03(){
	tools_package_manager_archlinux_aur_software_setup
	tools_package_manager_archlinux_aur_repository_syncronize
	tools_package_manager_archlinux_pacman_repository_syncronize
	#tools_package_manager_any_python_pip_repository_add
	#tools_package_manager_any_snap_software_setup
	#install_platform_debtap
	#install_platform_wine
	#install_softwares_aur
}

calling_fedora(){
    #tools_question_username

	tools_package_manager_fedora_dnf_cache_make
	adding_repository_from_fedora_rpm_fusion_free
	adding_repository_from_fedora_rpm_fusion_non_free
	install_softwares_from_fedora_dnf_essential
    install_softwares_from_fedora_dnf_utilities
    install_softwares_from_fedora_dnf_useful
	install_codec_from_fedora_dnf
	
	install_platform_virtual_machine_main
	#install_platform_wine
}

#label_must_be_improved
calling_global_softwares(){
    #ASDF
	tools_package_manager_any_asdf_software_setup

    #Programming language plugins
	install_plugin_from_any_asdf_java
	install_plugin_from_any_asdf_node_npm
	install_plugin_from_any_asdf_python_pip
    
    #AppImages
    install_softwares_from_any_appimage
    
    #Installation from binary
    install_container_distrobox_from_curl
	install_softwares_from_any_binary_dropbox
	install_softwares_from_any_binary_joplin
	install_softwares_from_any_binary_lf

    #Flatpak
    #ADD FLATPAK REPOSITORIES
    #???
    install_softwares_from_any_flatpak

    #NodeJS
    #???

    #Python - Pip
    install_softwares_from_any_pip
	
    #Snap
    tools_package_manager_any_snap_software_setup

    #Vim - Vundle
    tools_package_manager_any_vim_vundle_software_setup

    #Containers
    download_container_distrobox_image

    #Games
	install_platform_playstation2
	install_platform_steam
}

calling_system_appearance(){
    install_softwares_from_any_binary_oh_my_posh
    appearance_fonts
    appearance_settings_desktop_environment_gnome
    appearance_shell_theme_starship
    appearance_theme_gtk_adwaita
    appearance_theme_gtk_dracula
    appearance_theme_gedit_dracula
    appearance_theme_libreoffice_dracula
}

calling_testing(){
	#echo -e "$TERMINAL_TEXT_BACKGROUND_WHITE_CYAN 256-color background, de jure standard (ITU-T T.416) $TERMINAL_TEXT_BACKGROUND_END"
	#echo -e "$TERMINAL_TEXT_BACKGROUND_WHITE_ORANGE truecolor background, de jure standard (ITU-T T.416) (new in 0.52) $TERMINAL_TEXT_BACKGROUND_END"

    #tools_package_manager_any_asdf_software_setup
	tools_check_if_internet_connection_exists
	#connecting_internet_wifi
	#tools_backup_create

    #tools_string_replace_backslash_to_forward_slash "C:\foo\bar.xml"
    #tools_string_replace_forward_slash_to_backslash_cancelled "/tmp/.mozilla/"
}

#############################
#Calling the functions
#############################

clear

case $AUX1 in
	"" | "-h" | "--help" | "-?") echo -e "$MESSAGE_HELP" ;;
	"-e" | "--edit") $EDITOR $0 ;;
    "-al-p01" | "--alpine-part-01") calling_alpine ;;
    "-al-p02" | "--alpine-part-02") calling_alpine_part_02 ;;
    "-ar-p01" | "--archlinux-part-01") calling_archlinux_part_01 ;;
    "-ar-p02" | "--archlinux-part-02") calling_archlinux_part_02 ;;
    "-ar-p03" | "--archlinux-part-03") calling_archlinux_part_03 ;;
    "-f" | "--fedora") calling_fedora ;;
    "-g" | "--global-softwares") calling_global_softwares ;;
    "-s" | "--system-appearance") calling_system_appearance ;;
    "-t" | "--testing") calling_testing ;;
	*) echo -e "$MESSAGE_ERROR" ;;
esac