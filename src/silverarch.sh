#!/usr/bin/env sh

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
SILVERARCH_SCRIPT_LINK_MAIN="https://raw.githubusercontent.com/henrikbeck95/silverarch/development/src/silverarch.sh"
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

#############################
#Functions - Tools
#############################

tools_check_if_virtualization_is_enabled(){
	#if [[ $(egrep '^flags.*(vmx|svm)' /proc/cpuinfo) ]]; then
	if [[ $(LC_ALL=C lscpu | grep Virtualization) ]]; then
		echo "true"
	else
		echo "false"
	fi
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

#############################
#Functions - Package manager
#############################

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

tools_package_manager_any_tmux_tpm_software_setup(){
	display_message_default "Install Tmux Package Manager setup"
	
    local FILE_PATH="$1"
    
	git clone https://github.com/tmux-plugins/tpm $FILE_PATH/.tmux/plugins/tpm
	
	display_message_default "Tmux Package Manager setup has been installed"
}

tools_package_manager_any_vim_vundle_software_setup(){
	display_message_default "Install Vundle-Vim $@ setup"

	local FILE_PATH="$1"
	
    tools_download_file "https://raw.githubusercontent.com/henrikbeck95/dotfiles/development/compiled/.vimrc" "$FILE_PATH/"

    #Install Vundle-Vim
    git clone https://github.com/VundleVim/Vundle.vim.git $FILE_PATH/.vim/bundle/Vundle.vim
    
    #Install Vim plugins
    vim +PluginInstall +qall

	display_message_default "Vundle-Vim $@ setup has been installed"
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

#############################
#Functions - Define SilverArch operating system name
#############################

#label_must_be_created
silverarch_release_set_logo(){
	display_message_empty
}

files_etc_os_release(){
    tools_string_replace_text "/etc/os-release" "PRETTY_NAME=\"Arch Linux\"" "PRETTY_NAME=\"SilverArch\""
}

files_etc_skel_asdf(){
    tools_package_manager_any_asdf_software_setup "/etc/skel/.asdf"
}

files_etc_skel_shell(){
    #$HOME/.profile file
    install_shell_profile "/etc/skel"

    #$HOME/.bash_logout file
    tools_string_write_exclusive_line_on_a_file '
    #~/.bash_logout
    ' > /etc/skel/.bash_logout

    #$HOME/.bash_profile file
    tools_string_write_exclusive_line_on_a_file '
    #Load the $HOME/.bashrc file
    if [ -f ~/.bashrc ]; then
        . ~/.bashrc
    fi
    ' > /etc/skel/.bash_profile

    #$HOME/.bashrc file
    tools_string_write_exclusive_line_on_a_file '
    #Load global settings
    if [[ -f $HOME/.profile ]]; then
        source $HOME/.profile
    fi
    ' > /etc/skel/.bashrc

    #$HOME/.zshrc file
    tools_string_write_exclusive_line_on_a_file '
    #Load global settings
    if [[ -f $HOME/.profile ]]; then
        source $HOME/.profile
    fi
    ' >> /etc/skel/.zshrc
}

files_etc_skel_tmux(){
    tools_download_file "https://raw.githubusercontent.com/henrikbeck95/dotfiles/development/current/tmux.conf" "/etc/skel"
    tools_package_manager_any_tmux_tpm_software_setup "/etc/skel"
}

files_etc_skel_vim(){
    #tools_download_file "https://raw.githubusercontent.com/henrikbeck95/dotfiles/development/compiled/.vimrc" "/etc/skel"
    tools_download_file "https://raw.githubusercontent.com/henrikbeck95/dotfiles/development/current/vimrc" "/etc/skel"
	mv /etc/skel/vimrc /etc/skel/.vimrc
	#vim +PluginInstall +qall
    tools_package_manager_any_vim_vundle_software_setup "/etc/skel"
}

files_etc_skel_xresources(){
    tools_download_file "https://raw.githubusercontent.com/henrikbeck95/dotfiles/development/current/Xresources" "/etc/skel"
}

#files_usr_bin_dynamic_wallpaper(){}

files_usr_bin_silverarch(){
	#Copy this script file to the arch-chroot
	cp $0 /mnt/usr/bin/silverarch
	tools_give_executable_permission /mnt/usr/bin/silverarch
}

files_usr_share_backgrounds_silverarch(){
    tools_download_file "$SILVERARCH_WALLPAPER_LINK" "/usr/share/backgrounds/silverarch/"
}

#fedora-logo
#ln silverarch-logo archlinux-logo
#files_usr_share_silverarch_logo(){}

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

install_platform_virtual_machine_main(){
    display_message_default "Install virtual machine platform"

    while true; do
    read -p "Inform what you want: [virt-manager | virtual-box | skip] " QUESTION_VIRTUAL_MACHINE

        case $QUESTION_VIRTUAL_MACHINE in
            "virt-manager") break ;;
            "virtual-box") break ;;
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
		libuser \
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
		udisks2-doc

	display_message_success "Alpine essential softwares have been installed"
}

install_softwares_from_ubuntu_apt_essential(){
	display_message_default "Install Ubuntu essential softwares"

	tools_package_manager_ubuntu_apt_software_install \
        build-essential \
        cpu-checker \
        gnupg2 \
        pciutils \
        util-linux

	#tools_package_manager_ubuntu_apt_software_install \
        #libsbigudrv2 \
        #libsbigudrv0 \
        #linux-sound-base \
        #linux-headers-`uname -r` \
        #pavucontrol 

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

#lang::display::message::status::warning("")
#pkg::default::software::install_single(CONFIRM, "lxappearance")
#pkg::default::software::install_single(CONFIRM, "xfce4-terminal")
#pkg::default::software::install_single(CONFIRM, "gnome-disk-utility")

#useradd -mG wheel "${%USERNAME}"
#passwd "${%USERNAME}"

#system::os::init::service::later::enable("SERVICE_NAME")
#system::os::init::service::now::enable("SERVICE_NAME")

#Create a virtual machine
#qemu-img convert -f vdi -O qcow2 Ubuntu\ 20.04.vdi /var/lib/libvirt/images/ubuntu-20-04.qcow2

#virsh net-dumpxml default > br1.xml
#tools_edit_file br1.xml

#############################
#Functions - Operating system
#############################

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
	tools_system_daemon_systemd_enable_now NetworkManager.service

	#Enable Reflector
    tools_system_daemon_systemd_enable_later reflector.timer
    #tools_system_daemon_systemd_enable_later fstrim.timer #ERROR

	#Configuring GRUB by commenting the line: MODULES=()
	#tools_string_replace_text "/etc/mkinitcpio.conf" "^MODULES=()" "#MODULES=()"
	#tools_string_replace_text "/etc/mkinitcpio.conf" "^MODULES=()" "MODULES=(btrfs)"

	tools_edit_file $FILENAME #Add text: MODULES=(btrfs)
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
		linux \
		snapper \
		vim
		
		#linux-lts \

	case $PROCESSOR in
		"AuthenticAMD") pacstrap /mnt/ amd-ucode ;;
		"GenuineIntel") pacstrap /mnt/ intel-ucode ;;
		*)
			display_message_error "Your processor could not be identified!"
			exit 0
		;;
	esac
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

    #operating_system_changing_language_keyboard
    #operating_system_changing_language_default
    
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

    operating_system_changing_language_keyboard
    operating_system_changing_language_default

    if [[ $IS_VIRTUALIATION != "kvm" ]]; then
        operating_system_archlinux_connecting_internet_wifi
        #operating_system_archlinux_connecting_ssh
    fi

    operating_system_archlinux_partiting_disk
    operating_system_archlinux_partiting_mounting
    operating_system_archlinux_install_system_base
	#tools_backup_setup #Testing
    operating_system_archlinux_creating_fstab
	files_usr_bin_silverarch
    operating_system_archlinux_mount_chroot

    display_message_warning "Script has been finished!"
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

calling_update(){
    tools_check_if_internet_connection_exists
    tools_check_if_user_has_root_previledges

    tools_download_file "$SILVERARCH_SCRIPT_LINK_MAIN" "/usr/bin/"
    mv /usr/bin/silverarch.sh /usr/bin/silverarch
	tools_give_executable_permission /mnt/usr/bin/silverarch
}

calling_backup(){
    case $AUX2 in
        "create") tools_backup_snaptshot_create $AUX3 ;;
        "delete") tools_backup_snaptshot_delete $AUX3 ;;
        "" | "help") tools_backup_message_help ;;
        "list") tools_backup_snapshot_list ;;
        "restore") tools_backup_snapshot_restore $AUX3 ;;
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
    "-ar-p01" | "--archlinux-part-01") calling_archlinux_part_01 ;;
    "-f" | "--fedora") calling_fedora ;;
	"-u" | "--update") calling_update ;;
	*) echo -e "$MESSAGE_ERROR_GENERICS" ;;
esac