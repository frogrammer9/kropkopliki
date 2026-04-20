#!/usr/bin/env bash

if [ -d '/boot/grub' ]; then
	read -p "Do you want to disable grub menu [Y/n]: " ans
	case "$ans" in 
		[nN]|[nN][oO]) ;;
		*)
			sudo sed -i 's/^GRUB_TIMEOUT=.*/GRUB_TIMEOUT=0' /etc/default/grub
			sudo grub-mkconfig -o /boot/grub/grub.cfg
		;;
	esac
fi
