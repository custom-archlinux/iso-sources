#!/usr/bin/env bash
#
# SPDX-License-Identifier: GPL-3.0-or-later

set -e -u

# Warning: customize_airootfs.sh is deprecated! Support for it will be removed in a future archiso version.

sed -i 's/#\(en_US\.UTF-8\)/\1/' /etc/locale.gen
locale-gen

cp -aT /etc/skel/ /root/

sed -i 's/#\(PermitRootLogin \).\+/\1yes/' /etc/ssh/sshd_config
sed -i "s/#Server/Server/g" /etc/pacman.d/mirrorlist
sed -i 's/#\(Storage=\)auto/\1volatile/' /etc/systemd/journald.conf

sed -i 's/#\(HandleSuspendKey=\)suspend/\1ignore/' /etc/systemd/logind.conf
sed -i 's/#\(HandleHibernateKey=\)hibernate/\1ignore/' /etc/systemd/logind.conf
sed -i 's/#\(HandleLidSwitch=\)suspend/\1ignore/' /etc/systemd/logind.conf

systemctl enable pacman-init.service choose-mirror.service systemd-networkd.service systemd-resolved.service
systemctl set-default graphical.target
# systemctl enable reflector.service
systemctl enable lightdm.service

pacman-key --init
pacman-key --populate archlinux customarchlinux
pacman-key --lsign-key 6ED455BE5F7323B1

userGroups="adm,audio,disk,floppy,log,network,optical,rfkill,storage,video,wheel,sys"
useradd -m -g users -G $userGroups -s /bin/bash liveuser
passwd -d liveuser
# enable autologin
groupadd -r autologin
gpasswd -a liveuser autologin
groupadd -r nopasswdlogin
gpasswd -a liveuser nopasswdlogin
echo "The account liveuser with no password has been created"

#set permissions
chmod 750 /etc/sudoers.d
chmod 750 /etc/polkit-1/rules.d
chgrp polkitd /etc/polkit-1/rules.d
