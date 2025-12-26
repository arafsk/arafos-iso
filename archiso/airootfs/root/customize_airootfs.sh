#!/usr/bin/env bash
set -Eeuo pipefail

## -------------------------------------------------------------- ##

## Delete ISO specific init files
# rm -rf /etc/mkinitcpio.conf.d
# rm -rf /etc/mkinitcpio.d/linux-nvidia.preset

## -------------------------------------------------------------- ##

## Set zsh as default shell for new user
#sed -i -e 's#SHELL=.*#SHELL=/bin/zsh#g' /etc/default/useradd

## -------------------------------------------------------------- ##

## Enable apparmor on boot
sed -i -e 's/vt.global_cursor_default=0/vt.global_cursor_default=0 lsm=landlock,lockdown,yama,integrity,apparmor,bpf/g' /etc/default/grub

## -------------------------------------------------------------- ##
## Copy Few Configs Into Root Dir
rdir="/root/.config"
sdir="/etc/skel"
if [[ ! -d "$rdir" ]]; then
	mkdir "$rdir"
fi

rconfig=(geany gtk-3.0 Kvantum fastfetch qt5ct qt6ct ranger Thunar xfce4)
for cfg in "${rconfig[@]}"; do
	if [[ -e "$sdir/.config/$cfg" ]]; then
		cp -rf "$sdir"/.config/"$cfg" "$rdir"
	fi
done

rcfg=('.gtkrc-2.0' '.oh-my-zsh' '.zshrc')
for cfile in "${rcfg[@]}"; do
	if [[ -e "$sdir/$cfile" ]]; then
		cp -rf "$sdir"/"$cfile" /root
	fi
done

## -------------------------------------------------------------- ##
## Update xdg-user-dirs for bookmarks in thunar and pcmanfm
#runuser -l araf -c 'xdg-user-dirs-update'
#runuser -l araf -c 'xdg-user-dirs-gtk-update'
xdg-user-dirs-update
xdg-user-dirs-gtk-update

## Make it executable
#chmod +x ~/.config/autostart/xrandr.sh

# Make calamares.desktop executable
chmod +x /usr/local/bin/arafos.bios
chmod +x /usr/local/bin/arafos.uefi
chmod +x /usr/local/bin/grubinstall
chmod +x /usr/local/bin/maintenance
chmod +x /usr/local/bin/before
chmod +x /usr/local/bin/final
chmod +x /usr/local/bin/calamares_polkit

chmod +x /usr/share/applications/maintenance.desktop
chmod +x /etc/xdg/autostart/calamares.desktop

## Delete stupid gnome backgrounds
gndir='/usr/share/backgrounds/xfce'
if [[ -d "$gndir" ]]; then
	rm -rf "$gndir"
fi

## -------------------------------------------------------------- ##
