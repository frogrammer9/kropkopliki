#!/usr/bin/env bash

sudo sed -i 's/^HOOKS=(.*/HOOKS=(base udev autodetect microcode modconf kms plymouth keyboard keymap consolefont block filesystems fsck)/' /etc/mkinitcpio.conf
sudo mkinitcpio -P
sudo plymouth-set-default-theme -R arch-bgrt

if [ -d '/boot/grub' ]; then
	sudo sed -i \
		's/^GRUB_CMDLINE_LINUX_DEFAULT=.*/GRUB_CMDLINE_LINUX_DEFAULT="loglevel=3 rd.systemd.show_status=false quiet splash vt.global_cursor_default=0"/' \
		/etc/default/grub
	sudo grub-mkconfig -o /boot/grub/grub.cfg
else
	echo "This install script supports only grub, in order to have plymouth working add 'quiet splash' to boot options"
fi
