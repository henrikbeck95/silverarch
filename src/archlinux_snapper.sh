#!/usr/bin/env sh

##############################
#Instructions
##############################
#
#rfkill unblock wifi
#iwctl device wlan0 set-property Powered on
#iwctl station wlan0 scan
#iwctl station wlan0 connect <wifi_network_name>
#ping -c 3 archlinux.org
#
#curl -L -O https://raw.githubusercontent.com/henrikbeck95/silverarch/development/src/archlinux_snapper.sh
#
#- [How to install Arch Linux with BTRFS & Snapper](https://www.youtube.com/watch?v=sm_fuBeaOqE)
##############################

##############################
#Declaring variables
##############################

AUX1=$1

#EDITOR="nano"
EDITOR="vim"

PARTITION_BOOT="/dev/sda1"
PARTITION_ROOT="/dev/sda2"

QUESTION_HOST="biomachine"
QUESTION_USERNAME="henrikbeck95"

MESSAGE_HELP="
-h\t--help\t-?\t\t\tDisplay this help message
-e\t--edit\t\t\t\tEdit this script file
-p1\t\t\t\t\tInstallation setup part 1
-p2\t\t\t\t\tInstallation setup part 2
-p3\t\t\t\t\tInstallation setup part 3
"

MESSAGE_ERROR="Invalid option for $0!\n$MESSAGE_HELP"

##############################
#Functions - tools
##############################

tools_string_remove_first_character_from_each_line_in_a_file(){
	cat $1 | sed 's/.\(.*\)/\1/' > $2
	#cut -c 2- < $1
}

tools_backup_snapper_configure(){
	umount /.snapshots/
	rm -fr /.snapshots/
	snapper -c root create-config /

	$EDITOR /etc/snapper/configs/root #Replace the lines:
	#ALLOW_USERS="" to ALLOW_USERS="$QUESTION_USERNAME"
	#Change all the limits for timeline cleanup to 0 value


	#Create a /boot/ directory backup when Linux kernel gets updated
	echo -e "[Trigger]\nOperation = Upgrade\nOperation = Install\nOperation = Remove\nType = Package\nTarget = linux*\n\n[Action]\nDepends = rsync\nDescription = Backing up /boot/ directory when Linux kernel gets updated\nWhen = PReTransaction\nExec = /usr/bin/rsync -a delete /boot/ /.bootbackup/" > /usr/share/libalpm/hooks/50_bootbackup.hook
	$EDITOR /usr/share/libalpm/hooks/50_bootbackup.hook

	chmod a+rx /.snapshots/

	systemctl enable --now snapper-timeline.timer
	systemctl enable --now snapper-cleanup.timer
	systemctl enable --now grub-btrfs.path

	#exit
	#reboot
}

tools_backup_snapper_create(){
	tools_backup_snapper_list
	snapper -c root create -c timeline --description "$1"
	tools_backup_snapper_list
}

tools_backup_snapper_list(){
	snapper -c root list
	#snapper list -t pre-post
}

tools_backup_snapper_restore(){
	mount $PARTITION_ROOT /mnt/
	$EDITOR /mnt/@snapshots/*/info.xml

	#rm -fr /mnt/@/

	#Restoring
	#btrfs subvol snapshots /mnt/@snapshots/2/snapshot /mnt/@/
	#reboot

	#Check
	#btrfs property list -ts /.snapshots/3/snapshot/
	#Set
	#btrfs property set -ts /.snapshots/3/snapshot/ ro false

	#reboot
}

tools_repository_pacman(){
	cd /etc/pacman.d/

	if [[ -f /etc/pacman.d/mirrorlist ]]; then
		rm /etc/pacman.d/mirrorlist
	fi

	curl -L -O "https://archlinux.org/mirrorlist/?country=all&protocol=http&protocol=https&ip_version=4"

	mv \
		"/etc/pacman.d/?country=all&protocol=http&protocol=https&ip_version=4" \
		/etc/pacman.d/mirrorlist_original

	tools_string_remove_first_character_from_each_line_in_a_file "/etc/pacman.d/mirrorlist_original" "/etc/pacman.d/mirrorlist"
	$EDITOR /etc/pacman.d/mirrorlist
	cd -

	pacman -Sy archlinux-keyring
	pacman -Syyuu
}

##############################
#Functions - normal
##############################

part_01(){
	#tools_repository_pacman
	pacman -Syyuu

	#pacman -S reflector
	#reflector -c Brazil -a 24 --sort rate --save /etc/pacman.d/mirrorlist
	#reflector -c Brazil --sort rate --save /etc/pacman.d/mirrorlist

	timedatectl set-ntp true
	lsblk
	cfdisk

	mkfs.fat -F32 /dev/sda1
	mkfs.btrfs -f /dev/sda2

	mount $PARTITION_ROOT /mnt/
	btrfs su cr /mnt/@/
	btrfs su cr /mnt/@boot/
	btrfs su cr /mnt/@home/
	btrfs su cr /mnt/@var/
	btrfs su cr /mnt/@snapshots/
	btrfs su cr /mnt/@swap/
	umount $PARTITION_ROOT

	#mount -o noatime,compress=lzo,space_cache,subvol=@ $PARTITION_ROOT /mnt/
	#mount -o subvol=@snapshots $PARTITION_ROOT /.snapshots
	mount -o compress=lzo,subvol=@ $PARTITION_ROOT /mnt/

	mkdir -p /mnt/{boot,home,var,.snapshots,swap}/

	mount -o compress=lzo,subvol=@boot $PARTITION_BOOT /mnt/boot/
	mount -o compress=lzo,subvol=@home $PARTITION_ROOT /mnt/home/
	mount -o compress=lzo,subvol=@var $PARTITION_ROOT /mnt/var/
	mount -o compress=lzo,subvol=@snapshots $PARTITION_ROOT /mnt/snapshots/
	mount -o compress=lzo,subvol=@swap $PARTITION_ROOT /mnt/swap/

	mount $PARTITION_BOOT /mnt/boot/
	pacstrap /mnt/ base linux linux-firmware $EDITOR snapper
	genfstab -U /mnt/ >> /mnt/etc/fstab

	cp $0 /mnt/usr/bin/archlinux_snapper.sh
	chmod +x /mnt/usr/bin/archlinux_snapper.sh

	arch-chroot /mnt/
}

part_02(){
	#ln -sf /usr/share/zoneinfo/Europe/Zurich /etc/localtime
	ln -sf /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime
	hwclock --systohc

	$EDITOR /etc/locale.gen #Uncomment #en_US.UTF-8 UTF-8
	locale-gen
	
	echo -e "LANG=en_US.UTF-8" > /etc/locale.conf
	echo -e "$QUESTION_HOST" > /etc/hostname
	echo -e "127.0.0.1\t\tlocalhost\n::1\t\t\tlocalhost\n127.0.0.1\t\t$QUESTION_HOST.localdomain\t\t$QUESTION_HOST" > /etc/hosts

	passwd
	EDITOR=vim visudo #Uncomment the: # %wheel ALL=(ALL) ALL

	tools_repository_pacman

	#Installation
	pacman -S \
		grub \
		grub-btrfs \
		efibootmgr \
		networkmanager \
		network-manager-applet \
		wireless_tools \
		wpa_supplicant \
		dialog \
		os-prober \
		mtools \
		dosfstools \
		base-devel \
		linux-headers \
		reflector

	systemctl enable NetworkManager

	#grub-install --target=x86_84-efi --efi-directory=/boot/efi/ --bootloader-id=GRUB
	grub-install --target=x86_84-efi --efi-directory=/boot/ --bootloader-id=GRUB
	grub-mkconfig -o /boot/grub/grub.cfg

	echo -e "Type: exit ; then: umount -a && reboot"
}

part_03(){
	nmtui

	tools_backup_snapper_configure

	tools_backup_snapper_create "After basic ArchLinux installation setup"

	flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

	tools_backup_snapper_create "After Flatpak installation setup"

	#Desktop environment: KDE Plasma
	pacman -S \
		xorg \
		xorg-server \
		xdg-utils \
		xf86-video-qxl \
		xf86-video-intel \
		sddm \
		plasma \
		materia-kde
		#xf86-video-amdgpu \
		#nvidia \
		#nvidia-utils xorg \
		#plasma-wayland-session

	#Desktop environment: Gnome
	#pacman -S \
		#gdm \
		#gnome \
		#gnome-extra
	#systemctl enable gdm

	tools_backup_snapper_create "After KDE Plasma desktop environment installation setup"

	useradd -mG wheel $QUESTION_USERNAME
	passwd $QUESTION_USERNAME

	pacman -S alacritty

	systemctl enable --now sddm

	tools_backup_snapper_create "After Creating a user and terminal emulator installation setup"

	#paru -S snapper-gui-git
	#git clone https://aur.archlinux.org/snapper-gui-git.git
	#cd ./snapper-gui-git.git
	#makepkg -si PKGBUILD
}

##############################
#Calling the functions
##############################

case $AUX1 in
	"" | "-h" | "--help" | "-?") echo -e "$MESSAGE_HELP" ;;
	"-e" | "--edit") $EDITOR $0 ;;
	"-p1") part_01 ;;
	"-p2") part_02 ;;
	"-p3") part_03 ;;
	*) echo -e "$MESSAGE_ERROR" ;;
esac
