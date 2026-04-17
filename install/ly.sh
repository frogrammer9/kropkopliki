#!/usr/bin/env bash

sudo sed -i 's/allow_empty_password =.*/allow_empty_password = false' /etc/ly/config.ini
sudo sed -i 's/battery_id =.*/battery_id = 0' /etc/ly/config.ini
sudo sed -i 's/session_log =.*/session_log = /var/log/ly.log' /etc/ly/config.ini
sudo sed -i 's/save =.*/save = true' /etc/ly/config.ini
sudo sed -i 's/numlock =.*/numlock = true' /etc/ly/config.ini

sudo systemctl enable --now ly@tty1.service
sudo systemctl disable --now getty@tty1.service
