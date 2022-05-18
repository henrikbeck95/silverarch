#!/usr/bin/env sh

#############################
#Functions - Display
#############################

display_message_default(){
	echo -e "$COLOR_WHITE \n#############################\n#$1\n#############################\n $COLOR_END"
}

#############################
#Import files
#############################

#Check if Shell Script Library is installed
if [[ -f /usr/local/bin/shell-script-library ]]; then
	local PATH_URL_SHELL_SCRIPT_LIBRARY=""

	echo -e "Shell Script Library is required to procedure with this installation"

	#Download the Shell Script Library
	cd /usr/local/bin/
	echo -e "Downloading $PATH_URL_SHELL_SCRIPT_LIBRARY file"
	curl -L -O $PATH_URL_SHELL_SCRIPT_LIBRARY || wget -c $PATH_URL_SHELL_SCRIPT_LIBRARY
	cd -

	exit 127
else
	source /usr/local/bin/shell-script-library
	utils_load_operating_system_properties
fi

#############################
#Declaring variables
#############################

PATH_SCRIPT="$(dirname "$(readlink -f "$0")")"
#SILVERARCH_SCRIPT_LINK_MAIN="https://raw.githubusercontent.com/henrikbeck95/testing/main/linux.sh"
SILVERARCH_SCRIPT_LINK_MAIN="https://raw.githubusercontent.com/henrikbeck95/silverarch/development/src/silverarch.sh"
SILVERARCH_SCRIPT_LINK_PROFILE="https://raw.githubusercontent.com/henrikbeck95/silverarch/development/src/profile.sh"
SILVERARCH_SCRIPT_PATH="$PATH_SCRIPT/"
#SILVERARCH_SCRIPT_PATH="$HOME/"
#SILVERARCH_SCRIPT_PATH="/root/"
SILVERARCH_WALLPAPER_LINK="https://raw.githubusercontent.com/henrikbeck95/silverarch/development/assets/silverarch_wallpaper.png"

#BACKUP_TOOL="btrfk"
BACKUP_TOOL="snapper"
#BACKUP_TOOL="timeshift"

#CONTAINER_MANAGER="docker"
CONTAINER_MANAGER="podman"

#CREATE DECISION FLUX IF SOFTWARE EXISTS
#EDITOR="nano"
#EDITOR="vi"
EDITOR="vim"

#$EDITOR /etc/default/keyboard

case $NAME in
    "Arch Linux" | "CentOS Linux" | "Fedora") MESSAGE_OPERATING_SYSTEM="Great, this script file supports it \o/" ;;
    *) MESSAGE_OPERATING_SYSTEM="This script file does not support it. Maybe this is not the right script for you :(" ;;
esac

MESSAGE_HELP_GENERICS="
\t\t\t\t\tLinux installation setup
\t\t\t\t\t----------------------------\n
[Credits]
Author: Henrik Beck
E-mail: henrikbeck95@gmail.com
License: GPL3
Version: v.1.0.0

[First things first]
We have detected you are using $TEXT_BLINK $(echo $NAME) $COLOR_END operating system. $MESSAGE_OPERATING_SYSTEM

[Description]
This is a Linux installation and post installation setup for using the operating system as a desktop workstation.
This script supports Alpine, ArchLinux and Fedora operating systems.

[Parameters]
$COLOR_ORANGE Basic script file options $COLOR_END
-h\t--help\t-?\t\t\tDisplay this help message
-e\t--edit\t\t\t\tEdit this script file
-b\t--backup\t\t\tSilverArch backup

$COLOR_BLUE Alpine installation setup $COLOR_END
-al-p01\t--alpine-part-01\t\tInstall ArchLinux system base $COLOR_RED_LIGHT (ONLY ROOT) $COLOR_END
-al-p02\t--alpine-part-02\t\tConfigure and install ArchLinux essential system softwares $COLOR_RED_LIGHT (ONLY ROOT) $COLOR_END

$COLOR_BLUE Archlinux installation setup $COLOR_END
-ar-p01\t--archlinux-part-01\t\tInstall ArchLinux system base $COLOR_RED_LIGHT (ONLY ROOT) $COLOR_END
-ar-p02\t--archlinux-part-02\t\tConfigure and install ArchLinux essential system softwares and drivers $COLOR_RED_LIGHT (ONLY ROOT) $COLOR_END
-ar-p03\t--archlinux-part-03\t\tInstall support platforms $COLOR_RED_LIGHT (ONLY ROOT) $COLOR_END

$COLOR_BLUE_LIGHT Fedora installation setup $COLOR_END
-f\t--fedora\t\t\tConfigure and install Fedora essential system softwares $COLOR_RED_LIGHT (ONLY ROOT) $COLOR_END

$COLOR_RED_LIGHT Others installation setup $COLOR_END
-g\t--global-softwares\t\tInstall softwares which can be installed in any Linux operating system distro
-s\t--system-appearance\t\tCustomize operating system appearance
-t\t--testing\t\t\tTesting selected functions for debugging this script file
"

MESSAGE_HELP_BACKUP="
[Description]
SilverArch uses $BACKUP_TOOL as default backup tool on background to manage all system snapshots.

[Parameters]
create\t\t\tCreate a new system snapshot to preverse the current state
delete\t\t\tRemove a system snapshot
help\t\t\tDisplay this help message
list\t\t\tList all system snapshots and the relational dates
restore\t\t\tRestore a system snapshot and come back in time

[Examples]
$AUX0 $AUX1 create '???'
$AUX0 $AUX1 delete '???'
$AUX0 $AUX1 help
$AUX0 $AUX1 list
$AUX0 $AUX1 restore '???'
"

MESSAGE_RESTART="Must restart current session for apply the new settings"

MESSAGE_ERROR_GENERICS="Invalid option for $0!\n$MESSAGE_HELP_GENERICS"

MESSAGE_ERROR_BACKUP="Invalid option for $AUX2 $AUX3!\n$MESSAGE_HELP_BACKUP"

AUX0=$0
AUX1=$1
AUX2=$2
AUX3=$3

case $AUX2 in
	"--debug") DEBUG="true" ;;
	*) DEBUG="false" ;;
esac

#############################
#Functions - Backup
#############################

#label_must_be_created
tools_backup_setup(){
	case $BACKUP_TOOL in
		"btrfk") display_message_empty_complex ;;
		"snapper") 
			#Command line interface (CLI)
			system_pkg_default_software_install_single \
				snapper

			#Graphic user interface (GUI)
			#git clone https://aur.archlinux.org/snapper-gui-git.git
			#cd snapper-gui-git/
			#makepkg -si PKGBUILD
			;;
		"timeshift") display_message_empty_complex ;;
		*) display_message_empty_complex ;;
	esac
}

#############################
#Functions - Package manager
#############################

#label_must_be_edited
#label_must_be_improved
system_pkg_any_python_anaconda_software_setup(){
	display_message_warning_complex "Installing Python - Anaconda setup"

	#https://docs.anaconda.com/anaconda/install/linux/
	
	cd $HOME/Downloads/
	#Download Anaconda script file
	https://repo.anaconda.com/archive/Anaconda3-2021.11-Linux-x86_64.sh
	cd -

	#Import Anaconda script file
	bash ~/Downloads/Anaconda3-2021.11-Linux-x86_64.sh
	
	display_message_success_complex "Python - Anaconda setup has been installed"
}
system_pkg_any_python_pip_software_setup(){
	display_message_warning_complex "Installing Python - Pip3 setup"

    #case $NAME in
        #"Arch Linux") system_pkg_default_software_install_single python-pip ;;
        #"CentOS Linux" | "Fedora") : ;; #Native installed
        #*) display_message_error_complex "" ;;
    #esac

	#Install Python plugin
	system_pkg_any_asdf_repository_add python
	
	#List all Python plugins available
	system_pkg_any_asdf_software_list all python

	#Install Python versions
	system_pkg_any_asdf_software_install python 3.6-dev
	system_pkg_any_asdf_software_install python 3.6.0
	system_pkg_any_asdf_software_install python 3.9.2

	#Set Python environment
	asdf global python 3.9.2
	cd ~/Documents/voice_assistant_linux/ && asdf local python 3.6-dev #Your current working directory

	#Check if Python version
	python --version
	
	display_message_success_complex "Python - Pip3 setup has been installed"
}
#RUST
system_pkg_archlinux_aur_software_install(){}
system_pkg_archlinux_aur_software_list(){}
system_pkg_archlinux_aur_software_uninstall(){}

tools_question_username(){
	local QUESTION_USERNAME
	
    while true; do
        read -p "Inform the username: " QUESTION_USERNAME #henrikbeck95

        case $QUESTION_USERNAME in
            "") echo "Please answer your username." ;;
            *) break ;;
        esac
    done
}

#############################
#Functions - Define SilverArch operating system name
#############################

#label_must_be_created
silverarch_release_set_logo(){
	display_message_empty_complex
}

files_etc_os_release(){
    string_replace_text "/etc/os-release" "PRETTY_NAME=\"Arch Linux\"" "PRETTY_NAME=\"SilverArch\""
}

files_etc_skel_asdf(){
    system_pkg_any_software_install_platform_asdf "/etc/skel/.asdf"
}

files_etc_skel_shell(){
    #$HOME/.profile file
    install_shell_profile "/etc/skel"

    #$HOME/.bash_logout file
    string_write_exclusive_line_on_a_file '
    #~/.bash_logout
    ' > /etc/skel/.bash_logout

    #$HOME/.bash_profile file
    string_write_exclusive_line_on_a_file '
    #Load the $HOME/.bashrc file
    if [ -f ~/.bashrc ]; then
        . ~/.bashrc
    fi
    ' > /etc/skel/.bash_profile

    #$HOME/.bashrc file
    string_write_exclusive_line_on_a_file '
    #Load global settings
    if [[ -f $HOME/.profile ]]; then
        source $HOME/.profile
    fi
    ' > /etc/skel/.bashrc

    #$HOME/.zshrc file
    string_write_exclusive_line_on_a_file '
    #Load global settings
    if [[ -f $HOME/.profile ]]; then
        source $HOME/.profile
    fi
    ' >> /etc/skel/.zshrc
}

files_etc_skel_tmux(){
    utils_download_file "https://raw.githubusercontent.com/henrikbeck95/dotfiles/development/current/tmux.conf" "/etc/skel"
    system_pkg_any_software_install_platform_tpm "/etc/skel"
}

files_etc_skel_vim(){
    #utils_download_file "https://raw.githubusercontent.com/henrikbeck95/dotfiles/development/compiled/.vimrc" "/etc/skel"
    utils_download_file "https://raw.githubusercontent.com/henrikbeck95/dotfiles/development/current/vimrc" "/etc/skel"
	mv /etc/skel/vimrc /etc/skel/.vimrc
	#vim +PluginInstall +qall
    system_pkg_any_software_install_platform_vundle "/etc/skel"
}

files_etc_skel_xresources(){
    utils_download_file "https://raw.githubusercontent.com/henrikbeck95/dotfiles/development/current/Xresources" "/etc/skel"
}

#files_usr_bin_dynamic_wallpaper(){}

files_usr_bin_silverarch(){
	#Copy this script file to the arch-chroot
	cp $0 /mnt/usr/bin/silverarch
	system_permission_set_executable /mnt/usr/bin/silverarch
}

files_usr_share_backgrounds_silverarch(){
    utils_download_file "$SILVERARCH_WALLPAPER_LINK" "/usr/share/backgrounds/silverarch/"
}

#Move to utils download fonts developer
files_usr_share_fonts(){
	#Download the files
	#utils_download_file https://github.com/tonsky/FiraCode/releases/download/5.2/Fira_Code_v5.2.zip "/tmp/the_fonts"
	utils_download_file "https://github.com/ryanoasis/nerd-fonts/releases/download/2.2.0-RC/FiraCode.zip" "/tmp/the_fonts"
	utils_download_file "https://github.com/ryanoasis/nerd-fonts/releases/download/2.2.0-RC/LiberationMono.zip" "/tmp/the_fonts"
	utils_download_file "https://github.com/ryanoasis/nerd-fonts/releases/download/2.2.0-RC/Hack.zip" "/tmp/the_fonts"
	utils_download_file "https://github.com/ryanoasis/nerd-fonts/releases/download/2.2.0-RC/Meslo.zip" "/tmp/the_fonts"

	#Extract files
	utils_extract_file_zip "/tmp/the_fonts/FiraCode.zip" "/usr/share/fonts/FiraCode"
	utils_extract_file_zip "/tmp/the_fonts/LiberationMono.zip" "/usr/share/fonts/LiberationMono"
	utils_extract_file_zip "/tmp/the_fonts/Hack.zip" "/usr/share/fonts/Hack"
	utils_extract_file_zip "/tmp/the_fonts/Meslo.zip" "/usr/share/fonts/Meslo"

	#Remove temporary folder
	utils_remove_file "/tmp/the_fonts/"

	#Update the fonts cache
	utils_update_fonts_cache
}

#fedora-logo
#ln silverarch-logo archlinux-logo
#files_usr_share_silverarch_logo(){}

#############################
#Functions - Downloading
#############################

download_operating_system_fedora_silverblue(){
	display_message_warning_complex "Downloading Fedora Silverblue operating system"
	
	utils_download_file "https://mirror1.cl.netactuate.com/fedora/releases/35/Silverblue/x86_64/iso/Fedora-Silverblue-ostree-x86_64-35-1.2.iso" "$HOME/Downloads/"
	cd -
	
	display_message_success_complex "Fedora Silverblue operating system has been downloaded"
}

#############################
#Functions - Installing
#############################

install_platform_container_main(){
	display_message_warning_complex "Installing $CONTAINER_MANAGER $@ platform"

    while true; do
        read -p "Inform what you want: [docker | podman | skip] " QUESTION_CONTAINER_MANAGER

        #case $CONTAINER_MANAGER in
        case $QUESTION_CONTAINER_MANAGER in
            "docker")
                system_pkg_default_software_install_platform_docker
                break
                ;;
            "podman")
                system_pkg_default_software_install_platform_podman
                break
                ;;
            "skip") break ;;
            *) echo "Please answer file or partition." ;;
        esac
    done

	display_message_success_complex "$CONTAINER_MANAGER $@ platform has been installed"
}

install_platform_virtual_machine_main(){
    display_message_warning_complex "Installing virtual machine platform"

    while true; do
    read -p "Inform what you want: [virt-manager | virtual-box | skip] " QUESTION_VIRTUAL_MACHINE

        case $QUESTION_VIRTUAL_MACHINE in
            "virt-manager")
                system_pkg_default_software_install_platform_virtmanager
                break
                ;;
            "virtual-box")
                system_pkg_default_software_install_platform_virtualbox
                break
                ;;
            "skip") break ;;
            *) echo "Please answer file or partition." ;;
        esac
    done

	display_message_success_complex "Virtual machine platform has been installed"
}

#label_must_be_tested
install_shell_profile(){
	local FILE_PATH="$1"
	
	utils_download_file "$SILVERARCH_SCRIPT_LINK_PROFILE" "$FILE_PATH"
	utils_move_file "$FILE_PATH/profile.sh" "$FILE_PATH/.profile"
}

install_softwares_from_archlinux_aur(){
	display_message_warning_complex "Installing softwares from ArchLinux User Repository (AUR)"
    system_pkg_archlinux_aur_software_install \
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
	
	display_message_success_complex "Softwares from ArchLinux User Repository (AUR) have been installed"
}

#label_must_be_fixed
install_softwares_from_archlinux_pacman_manually(){
	display_message_warning_complex "Installing softwares from Pacman manually"

	#Timeshift
	utils_download_file https://aur.andontie.net/x86_64/timeshift-21.09.1-3-x86_64.pkg.tar.zst "$HOME/"
	pacman -U $HOME/timeshift-21.09.1-3-x86_64.pkg.tar.zst

	#Libinput
	#utils_download_file https://mirror.clarkson.edu/manjaro/testing/community/x86_64/libinput-gestures-2.69-1-any.pkg.tar.zst "$HOME/"
	#pacman -U $HOME/compilation/libinput-gestures-2.69-1-any.pkg.tar.zst
	
	#Gestures
	#utils_download_file https://mirror.clarkson.edu/manjaro/stable/community/x86_64/gestures-0.2.5-1-any.pkg.tar.zst "$HOME/"
	#pacman -U $HOME/compilation/gestures-0.2.5-1-any.pkg.tar.zst

	display_message_success_complex "Softwares from Pacman manually have been installed"
}

##########################################################################################
#DONE SO FAR
##########################################################################################

#############################
#Functions - System
#############################

#label_must_be_fixed
install_driver_audio(){
	while true; do
		read -p "Inform what you want: [alsa | pipewire | pulseaudio | none] " QUESTION_DRIVER_AUDIO

		case $QUESTION_DRIVER_AUDIO in
			"alsa")
				system_pkg_default_software_install_platform_alsa
				break
				;;
			"pipewire")
                system_pkg_default_software_install_platform_pipewire
                break
				;;
			"pulseaudio")
				system_pkg_default_software_install_platform_pulseaudio
				break
				;;
			"none") break ;;
			*) echo "Please answer question." ;;
		esac
	done
}

#label_operating_system
#REPLACE THIS FUNCTION BY AUTO DETECTING NEEDS
install_driver_graphic_video(){
	display_message_default "Install video driver"

    display_message_default "Install video driver for VirtualBox virtual machine video driver"
	system_pkg_default_software_install_single virtualbox-guest-utils

    display_message_default "Install video driver for VMWare virtual machine video driver"
	system_pkg_default_software_install_single xf86-video-vmware

    display_message_default "Install video driver for X Window System QXL driver including Xspice server for virtual machine"
	system_pkg_default_software_install_single xf86-video-qxl

	while true; do
        #Select the option according to your graphic video manufacturer.
        lspci | grep -e VGA -e 3D

		read -p "Inform what you want: [amd | intel | nvidia | none] " QUESTION_GRAPHIC_VIDEO

		case $QUESTION_GRAPHIC_VIDEO in
			"amd")
				system_pkg_default_software_install_platform_amd
				break
				;;
			"intel")
				system_pkg_default_software_install_platform_intel
				break
				;;
			"nvidia")
				system_pkg_default_software_install_platform_nvidia
				break
				;;
			"none") break ;;
			*) echo "Please answer question." ;;
		esac
	done
}

install_display_server(){
	display_message_default "Install display server"

	while true; do
		read -p "Inform what you want: [wayland | xorg | none] " QUESTION_DISPLAY_SERVER

		case $QUESTION_DISPLAY_SERVER in
			"wayland")
				display_message_default "$QUESTION_DISPLAY_SERVER display server has been installed"
				
				system_pkg_default_software_install_single wayland
				
				display_message_default "$QUESTION_DISPLAY_SERVER display server has been installed"
				break
				;;
			"xorg")
				display_message_default "$QUESTION_DISPLAY_SERVER display server has been installed"
				
				system_pkg_default_software_install_single \
					xorg
					#xorg-server
				
				display_message_default "$QUESTION_DISPLAY_SERVER display server has been installed"
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
				system_pkg_default_software_install_platform_deepin
				break
				;;
            "gnome")
				system_pkg_default_software_install_platform_gnome
				break
				;;
			"i3")
				install_desktop_enviroment_i3
				break
				;;
			"kde")
				system_pkg_default_software_install_platform_plasma
				break
				;;
			"xfce")
				system_pkg_default_software_install_platform_xfce
				break
				;;
			"none") break ;;
			*) echo "Please answer question." ;;
		esac
	done
}

#label_operating_system
install_lock_screen(){
	display_message_default "Installing lock screen"

	while true; do
		read -p "Inform what you want: [lightdm/ly/none] " QUESTION_LOCK_SCREEN

		case $QUESTION_LOCK_SCREEN in
			"lightdm")
				system_pkg_default_software_install_platform_lightdm
				break
				;;
            "ly")
				system_pkg_default_software_install_platform_ly
				break
				;;
			"none") break ;;
			*) echo "Please answer question." ;;
		esac
	done

	display_message_warning_complex "$MESSAGE_RESTART"
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
	utils_check_if_user_has_root_previledges

	utils_edit_file "/etc/apk/repositories"
	apk update
	system_pkg_default_software_install_single sudo

	local MY_USER_CREDENTIALS="Henrik Beck"
	local MY_USERNAME="henrikbeck95"

	adduser -g "$MY_USER_CREDENTIALS" $MY_USERNAME
	adduser $MY_USERNAME wheel

	visudo
}

operating_system_archlinux_changing_hostname(){
	local QUESTION_HOST

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

	#utils_edit_file /etc/locale.gen #Uncomment the pt_BR.UTF-8 UTF-8 line
	locale-gen
	
	echo LANG=en_US.UTF-8 >> /etc/locale.conf
	#echo LANG=pt_BR.UTF-8 >> /etc/locale.conf

	echo KEYMAP=br-abnt2 >> /etc/vconsole.conf
}

#EDITING_NOW
operating_system_changing_language_keyboard(){
	display_message_default "Changing the keyboard layout settings"
    
	case $NAME in
        "Alpine") loadkeys setxkbmap -model abnt2 -layout br ;;
        "Arch Linux") loadkeys br-abnt2 ;;
        "CentOS Linux" | "Fedora") : ;; #Native installed
        *) display_message_error_complex "" ;;
    esac

	display_message_success_complex "Keyboard layout has been changed"
}

#EDITING_NOW
operating_system_changing_language_default(){
	display_message_default "Changing the keyboard layout to Brazilian Portuguese keymap"
    
	case $NAME in
        "Alpine") : ;;
        "Arch Linux")
			display_message_default "Changing for Brazilian Portuguese keymap"

			#Uncomment the line: # pt_BR.UTF-8 UTF-8
			string_replace_text "/etc/locale.gen" "#pt_BR.UTF-8 UTF-8" "pt_BR.UTF-8 UTF-8"

			#Apply the new settings
			export LANG=pt_BR.UTF-8
			;;
        "CentOS Linux" | "Fedora") : ;; #Native installed
        *) display_message_error_complex "" ;;
    esac

	display_message_success_complex "Keyboard layout has been changed to Brazilian Portuguese keymap"
}

#EDITING_NOW
operating_system_archlinux_changing_password_root(){
	display_message_default "Change the root password"

	passwd
}

#EDITING_NOW
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
	arch-chroot /mnt/
}

#EDITING_NOW
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
	local QUESTION_WIFI_METHOD

	display_message_default "Connect to Wi-Fi network"

	while true; do
		read -p "Inform what you want (when finish type skip): [iwctl/terminal/skip] " QUESTION_WIFI_METHOD

		case $QUESTION_WIFI_METHOD in
			"iwctl")
                display_message_warning_complex "iwctl Wi-Fi connect\n\n> #device list\n> #station wlan0 scan\n> #station wlan0 get-networks\n> #station wlan0 connect <wireless network name>\n> #exit"

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

#EDITING_NOW
#label_must_be_edited
operating_system_archlinux_database_software_reflector(){
	timedatectl set-ntp true
	hwclock --systohc

	reflector -c Brazil -a 12 --sort rate --save /etc/pacman.d/mirrorlist
	pacman -Sy

	firewall-cmd --add-port=1025-65535/tcp --permanent
	firewall-cmd --add-port=1025-65535/udp --permanent
	firewall-cmd --reload
}

#EDITING_NOW
#label_must_be_tested
operating_system_archlinux_editing_sudo_properties(){
	display_message_default "Setting the Vim as the default text editor and also edit the visudo file"

	#Uncomment the line: # %wheel ALL=(ALL) ALL
	string_replace_text "/etc/sudoers" "# %wheel ALL=(ALL) ALL" "%wheel ALL=(ALL) ALL"
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
				display_message_warning_complex "Editing module Multilib"
				string_replace_text "$PATH_REPOSITORY" "$CONTENT_LINE_STRING_CURRENT" "[multilib]"
				string_replace_number "$PATH_REPOSITORY" "$CONTENT_LINE_NUMBER_BELOW" "Include = \/etc\/pacman.d\/mirrorlist"

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
				display_message_warning_complex "Editing module Multilib-Testing"
				string_replace_text "$PATH_REPOSITORY" "$CONTENT_LINE_STRING_CURRENT" "[multilib-testing]"
				string_replace_number "$PATH_REPOSITORY" "$CONTENT_LINE_NUMBER_BELOW" "Include = \/etc\/pacman.d\/mirrorlist"

				unset $CONTENT_LINE_STRING_CURRENT
				unset $CONTENT_LINE_NUMBER_CURRENT
				unset $CONTENT_LINE_NUMBER_BELOW

				#############################
				#Verify if file has been created correctly
				#############################

				utils_edit_file $FILENAME
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

	system_pkg_default_software_install_single \
        grub \
        grub-btrfs \
		base-devel \
		cron \
		dialog \
		dosfstools \
		efibootmgr \
		linux-headers \
		mtools \
		networkmanager \
		network-manager-applet \
		os-prober \
		reflector \
		wireless_tools \
		wpa_supplicant
		
		#linux-lts-headers \

	#Enable the NetworkManager 
	system_daemon_enable_now NetworkManager.service

	#Enable Reflector
    system_daemon_enable_later reflector.timer
    #system_daemon_enable_later fstrim.timer #ERROR

	#Configuring GRUB by commenting the line: MODULES=()
	#string_replace_text "/etc/mkinitcpio.conf" "^MODULES=()" "#MODULES=()"
	#string_replace_text "/etc/mkinitcpio.conf" "^MODULES=()" "MODULES=(btrfs)"

	utils_edit_file $FILENAME #Add text: MODULES=(btrfs)
	mkinitcpio -p linux

	#Applying GRUB
	case $IS_BIOS_UEFI in #label_must_be_fixed
		"legacy")
			#grub-install --target=x86_64-efi --bootloader-id=GRUB
			#grub-install --target=x86_64-efi --boot-directory=/boot/efi --bootloader-id=GRUB
			#efibootmgr -c -d /dev/sda -p 1 -L "ArchLinux" -l \vmlinuz-linux -u "root=/dev/sda2 rw initrd=/initramfs-linux.img"
			display_message_error_complex "
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
			display_message_error_complex "The BIOS could not be identified!"
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
		linux \
		snapper \
		vim
		
		#linux-lts \

	case $PROCESSOR in
		"AuthenticAMD") pacstrap /mnt/ amd-ucode ;;
		"GenuineIntel") pacstrap /mnt/ intel-ucode ;;
		*)
			display_message_error_complex "Your processor could not be identified!"
			exit 0
		;;
	esac
}

#label_must_be_fixed
operating_system_fedora_version_upgrade(){
    #Replace repository database
	sudo dnf upgrade
	system_pkg_default_repository_syncronize
	sudo dnf --refresh upgrade
	system_pkg_default_software_install_single dnf-plugin-system-upgrade --best
	
    #Upgrade distro version - Fedora
	#sudo dnf system-upgrade download --refresh --releasever=35
	#sudo dnf system-upgrade download --refresh --releasever=$(rpm -E %fedora) #MUST ADD +1
	sudo dnf system-upgrade download --refresh --releasever=$(($(rpm -E %fedora)+1)) #MUST ADD +1
}

#############################
#Functions - Calling
#############################

calling_essential(){
	utils_check_if_internet_connection_exists
	utils_check_if_user_has_root_previledges

	utils_export_variables_bios
	utils_export_variables_virtualization
	utils_check_processor_family

	#operating_system_archlinux_setup_installation_script_download
	cd $SILVERARCH_SCRIPT_PATH/
}

calling_alpine(){
	calling_essential
    tools_question_username

    #operating_system_changing_language_keyboard
    #operating_system_changing_language_default
    
	operating_system_alpine_create_user
	system_pkg_default_software_install_combo_essential
	system_pkg_default_software_install_platform_xfce
	system_pkg_default_software_install_platform_bash
	system_pkg_default_software_install_platform_zsh

    display_message_warning_complex "Script has been finished!"
}

calling_archlinux_part_01(){
    calling_essential
    tools_question_username

    operating_system_changing_language_keyboard
    operating_system_changing_language_default

    if [[ $IS_VIRTUALIATION != "kvm" ]]; then
        operating_system_archlinux_connecting_internet_wifi
        #system_pkg_default_software_install_platform_openssh
    fi

    system_disk_partition_management
	#Formatting the partitions
	system_disk_partition_format_fat32 "$PARTITION_BOOT"
	system_disk_partition_format_btrfs "$PARTITION_ROOT"
	system_disk_partition_format_ext4 "$PARTITION_FILE"
	system_disk_partition_list_all

    system_disk_partition_mount_btrfs
    operating_system_archlinux_install_system_base
	#tools_backup_setup #Testing
    operating_system_archlinux_creating_fstab
	files_usr_bin_silverarch
    operating_system_archlinux_mount_chroot

    display_message_warning_complex "Script has been finished!"
}

calling_archlinux_part_02(){
    calling_essential
    tools_question_username

    #Working
    system_disk_swap_ask
    operating_system_archlinux_changing_timezone
    changing_language
    operating_system_archlinux_changing_hostname
    #operating_system_archlinux_enabling_support_32_bits
    system_pkg_default_repository_syncronize
    operating_system_archlinux_database_software_reflector
    operating_system_archlinux_changing_password_root
    system_pkg_default_software_install_platform_openssh
    operating_system_archlinux_installing_bootloader #Including base-devel
    
	#Testing
	#install_softwares_from_archlinux_pacman_manually
	#silverarch_release_set_logo
	files_etc_skel_asdf
	files_etc_skel_shell
	files_etc_skel_tmux
	files_etc_skel_vim
	files_etc_skel_xresources
	files_etc_os_release
	#files_usr_bin_dynamic_wallpaper
	files_usr_share_backgrounds_silverarch
	files_usr_share_fonts
	#files_usr_share_silverarch_logo
	
    system_pkg_any_software_install_platform_lf
	system_pkg_default_software_install_platform_zsh
    
	system_backup_snaptshot_create "SilverArch installation setup command line interface (CLI) has been completed!"

	#
    #install_driver_graphic_video
	#install_display_server
    #install_desktop_enviroment_main
	#system_pkg_default_software_install_platform_xdg
    	#install_driver_audio #Default

	#Configure Snapper
	#umount /.snapshots/
	#rm -fr /.snapshots/
	#snapper -c root create-config /
	#utils_edit_file /etc/snapper/configs/root
		#Replace
			#ALLOW_USERS=""
		#To
			#ALLOW_USERS="$QUESTION_USERNAME"
	#chmod a+rx /.snapshots/
	#systemctl enable --now snapper-timeline.timer
	#systemctl enable --now snapper-cleanup.timer
	#systemctl enable --now grub-btrfs.path
	#reboot
	#snapper -c root list #root = #$USER
	#snapper -c root create -c timeline --description 'After install'
	#snapper -c root list
	#reboot
	#Remove read only
	#snapper -c root create -c timeline --description 'Before GUI'
	#snapper -c root list
	#
	#git clone https://aur.archlinux.org/snapper-gui-git.git
	#cd snapper-gui-git/
	#makepkg -si PKGBUILD
	#
	#snapper -c root list
	#btrfs property list -ts /.snapshots/$NUMBER/snapshot/ #3
	#btrfs property set -ts /.snapshots/$NUMBER/snapshot/ ro false #3
	#
	#---

    #system_pkg_default_software_install_combo_essential
	#system_pkg_default_software_install_combo_battery
	#system_pkg_default_software_install_combo_utility
    
    #operating_system_archlinux_creating_new_user
    #operating_system_archlinux_editing_sudo_properties

    #install_platform_virtual_machine_main
    #install_platform_container_main
    #system_pkg_any_software_install_platform_distrobox

    #system_pkg_default_software_install_platform_bluetooth
    #system_pkg_default_software_install_platform_cups
    #system_pkg_default_software_install_platform_dhcpcd

    #system_pkg_default_software_install_platform_flatpak

	#system_backup_snaptshot_create "SilverArch installation setup graphical user interface (GUI) has been completed!"
    
    display_message_success_complex "Script has been finished!"
    
	display_message_warning_complex "Verify if everything is okay and then go back to the livecd mode by typing:\n\t> $ exit\n\t> $ umount -a\n\t> $ systemctl reboot"
}

calling_archlinux_part_03(){
	system_pkg_any_software_install_platform_paru
	system_pkg_archlinux_aur_repository_syncronize
	#system_pkg_default_repository_syncronize
	#system_pkg_any_python_pip_repository_add
	#system_pkg_default_software_install_platform_snap
	#system_pkg_default_software_install_platform_debtrap
	#install_platform_wine
	#install_softwares_aur
}

calling_fedora(){
    #tools_question_username

	system_pkg_default_cache_make
	system_pkg_default_software_install_combo_repository_free
	system_pkg_default_software_install_combo_repository_nonfree
	system_pkg_default_cache_make
	system_pkg_default_software_install_combo_useful
    system_pkg_default_software_install_combo_utility
    system_pkg_default_software_install_combo_useful
	system_pkg_default_software_install_platform_codecs
	
	install_platform_virtual_machine_main
	#install_platform_wine
}

#label_must_be_improved
calling_global_softwares(){
    #ASDF
	system_pkg_any_software_install_platform_asdf "$HOME/.asdf"

    #Programming language plugins
	install_plugin_from_any_asdf_java
	install_plugin_from_any_asdf_node_npm
	install_plugin_from_any_asdf_python_pip
    
    #AppImages
    install_softwares_from_any_appimage
    
    #Installation from binary
    system_pkg_any_software_install_platform_distrobox
	system_pkg_any_software_install_platform_dropbox
	system_pkg_any_software_install_platform_joplin
	system_pkg_any_software_install_platform_lf

    #Flatpak
    #ADD FLATPAK REPOSITORIES
    #???
    install_softwares_from_any_flatpak

    #NodeJS
    #???

    #Python - Pip
    install_softwares_from_any_pip
	
    #Snap
    system_pkg_default_software_install_platform_snap

    #Vim - Vundle
    system_pkg_any_software_install_platform_vundle "$HOME"

    #Containers
    download_container_distrobox_image

    #Games
	system_pkg_default_software_install_combo_games
}

calling_system_appearance(){
    system_pkg_any_software_install_platform_oh_my_posh
    system_appearance_desktop_environment_gnome
    system_appearance_theme_shell_starship
    system_appearance_theme_gtk_adwaita
    system_appearance_theme_gtk_dracula
    system_appearance_theme_gedit_dracula
    system_appearance_theme_libreoffice_dracula
}

calling_testing(){
	#echo -e "$TEXT_BACKGROUND_WHITE_CYAN 256-color background, de jure standard (ITU-T T.416) $TEXT_BACKGROUND_END"
	#echo -e "$TEXT_BACKGROUND_WHITE_ORANGE truecolor background, de jure standard (ITU-T T.416) (new in 0.52) $TEXT_BACKGROUND_END"

    #system_pkg_any_software_install_platform_asdf
	utils_check_if_internet_connection_exists
	#connecting_internet_wifi
	#system_backup_snaptshot_create

    #string_replace_backslash_to_forward_slash "C:\foo\bar.xml"
    #string_replace_forward_slash_to_backslash_cancelled "/tmp/.mozilla/"
}

calling_update(){
    utils_check_if_internet_connection_exists
    utils_check_if_user_has_root_previledges

    utils_download_file "$SILVERARCH_SCRIPT_LINK_MAIN" "/usr/bin/"
    utils_move_file "/usr/bin/silverarch.sh" "/usr/bin/silverarch"
	system_permission_set_executable "/mnt/usr/bin/silverarch"
}

calling_backup(){
    case $AUX2 in
        "create") system_backup_snaptshot_create $AUX3 ;;
        "delete") system_backup_snaptshot_delete $AUX3 ;;
        "" | "help") system_backup_message_help ;;
        "list") system_backup_snapshot_list ;;
        "restore") system_backup_snapshot_restore $AUX3 ;;
        *) display "$MESSAGE_ERROR_BACKUP" ;;
    esac
}

#############################
#Calling the functions
#############################

clear

case $AUX1 in
	"" | "-h" | "--help" | "-?") echo -e "$MESSAGE_HELP_GENERICS" ;;
	"-e" | "--edit") $EDITOR $0 ;;
	"-b" | "--backup") calling_backup ;;
    "-al-p01" | "--alpine-part-01") calling_alpine ;;
    "-al-p02" | "--alpine-part-02") calling_alpine_part_02 ;;
    "-ar-p01" | "--archlinux-part-01") calling_archlinux_part_01 ;;
    "-ar-p02" | "--archlinux-part-02") calling_archlinux_part_02 ;;
    "-ar-p03" | "--archlinux-part-03") calling_archlinux_part_03 ;;
    "-f" | "--fedora") calling_fedora ;;
    "-g" | "--global-softwares") calling_global_softwares ;;
    "-s" | "--system-appearance") calling_system_appearance ;;
    "-t" | "--testing") calling_testing ;;
	"-u" | "--update") calling_update ;;
	*) echo -e "$MESSAGE_ERROR_GENERICS" ;;
esac