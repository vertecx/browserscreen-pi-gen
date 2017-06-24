#!/bin/bash -e

install -m 644 files/browserscreen.txt ${ROOTFS_DIR}/boot/
install -m 644 files/.xsession	${ROOTFS_DIR}/home/pi/

on_chroot << EOF
chown pi:pi /home/pi/.xsession
EOF
