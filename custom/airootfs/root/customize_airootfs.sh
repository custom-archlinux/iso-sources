#!/usr/bin/env bash
#
# SPDX-License-Identifier: GPL-3.0-or-later

set -e -u

# Warning: customize_airootfs.sh is deprecated! Support for it will be removed in a future archiso version.

sed -i 's/#\(en_US\.UTF-8\)/\1/' /etc/locale.gen
locale-gen

cp -aT /etc/skel/ /root/

systemctl enable pacman-init.service choose-mirror.service systemd-networkd.service systemd-resolved.service
systemctl set-default graphical.target
# systemctl enable reflector.service
systemctl enable lightdm.service

pacman-key --init
pacman-key --populate archlinux customarchlinux
pacman-key --lsign-key 6ED455BE5F7323B1
