#!/bin/bash -e

install -m 644 files/.xsession	${ROOTFS_DIR}/home/pi/

on_chroot << EOF
chown pi:pi /home/pi/.xsession
EOF
