#!/bin/bash -e

rm -f ${ROOTFS_DIR}/etc/cron.daily/apt
rm -f ${ROOTFS_DIR}/etc/cron.daily/dpkg

install -m 644 files/browserscreen.txt ${ROOTFS_DIR}/boot/
install -m 644 files/.xsession	${ROOTFS_DIR}/home/pi/
install -m 755 files/mount.roverlay	${ROOTFS_DIR}/usr/local/sbin/
install -m 755 files/hidcontroller	${ROOTFS_DIR}/usr/local/bin/
install -m 755 files/browserscreen	${ROOTFS_DIR}/usr/local/bin/
install -m 644 files/browserscreen.service	${ROOTFS_DIR}/etc/systemd/system/
install -m 644 files/master_preferences	${ROOTFS_DIR}/usr/lib/chromium-browser/
install -m 644 files/10-control-usb-hid.rules	${ROOTFS_DIR}/etc/udev/rules.d/
install -m 644 files/lsb-release	${ROOTFS_DIR}/etc/lsb-release

sed -i "s/%DATE%/$(date +%Y.%m.%d)/" ${ROOTFS_DIR}/etc/lsb-release

on_chroot << EOF
chown pi:pi /home/pi/.xsession

systemctl enable browserscreen
systemctl enable tmp.mount
systemctl disable hwclock-save
systemctl disable rpi-display-backlight
systemctl disable sshswitch

ln -s /dev/null /lib/systemd/system/display-manager.service

mkdir /overlay

echo -ne "\033[9;0]" >> /etc/issue

touch /var/lib/systemd/clock
chown systemd-timesync:systemd-timesync /var/lib/systemd/clock
EOF
