#!/usr/bin/env sh

##############################
#References
##############################
#
#- [How to install Arch Linux with BTRFS & Snapper](https://www.youtube.com/watch?v=sm_fuBeaOqE)
##############################

#USERNAME=""
USERNAME="henrikbeck95"

#EDITOR="nano"
EDITOR="vim"

PARTITION_BOOT="/dev/sda1"
PARTITION_ROOT="/dev/sda2"

QUESTION_HOST="biomachine"

#pacman -S reflector
#reflector -c Brazil -a 24 --sort rete --save /etc/pacman.d/mirrorlist
#reflector -c Brazil --sort rete --save /etc/pacman.d/mirrorlist
pacman -Syyy

timedatectl set-ntp true
lsblk
cfdisk

#mkfs.fat -F32 /dev/sda1
mkfs.btrfs -f /dev/sda1
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

arch-chroot /mnt/

##############################
#Part 02
##############################

##############################
#Tested so far
#$EDITOR
#$PARTITION_BOOT
#$PARTITION_ROOT
##############################

#ln -sf /usr/share/zoneinfo/Europe/Zurich /etc/localtime
ln -sf /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime
hwclock --systohc

$EDITOR /etc/locale.gen #Uncomment #en_US.UTF-8 UTF-8
locale-gen
$EDITOR /etc/locale.conf #Insert line: LANG=en_US.UTF-8

echo -e "$QUESTION_HOST" >> /etc/hostname
$EDITOR /etc/hostname #biomachine

echo -e "
127.0.0.1\t\tlocalhost
::1\t\t\tlocalhost
127.0.0.1\t\t$QUESTION_HOST.localdomain\t\t$QUESTION_HOST" >> /etc/hosts
$EDITOR /etc/hosts

passwd

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

#grub-install --target=x86_84-efi --efi-directory=/boot/ --bootloader-id=GRUB
grub-install --target=x86_84-efi --efi-directory=/boot/efi/ --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg

#useradd -mG wheel $USERNAME
#passwd $USERNAME

EDITOR=vim visudo #Uncomment the: # %wheel ALL=(ALL) ALL

exit
umount -a
reboot

##############################
#Part 03
#Login as root
##############################

nmtui

pacman -S \
	xdg-utils

pacman -S xf86-video-qxl xf86-video-intel xf86-video-amdgpu nvidia nvidia-utils xorg

#pacman -S gdm gnome gnome-extra
#systemctl enable gdm



#systemctl enable 
