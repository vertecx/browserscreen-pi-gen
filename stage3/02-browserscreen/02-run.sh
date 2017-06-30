#!/bin/bash -e

install -m 644 files/browserscreen.txt ${ROOTFS_DIR}/boot/
install -m 644 files/.xsession	${ROOTFS_DIR}/home/pi/
install -m 755 files/browserscreen	${ROOTFS_DIR}/usr/local/bin/
install -m 644 files/browserscreen.service	${ROOTFS_DIR}/etc/systemd/system/

on_chroot << EOF
chown pi:pi /home/pi/.xsession
systemctl enable browserscreen
EOF
