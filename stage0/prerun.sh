#!/bin/bash -e
if [ ! -d ${ROOTFS_DIR} ]; then
	bootstrap --exclude=dmidecode jessie ${ROOTFS_DIR} http://mirrordirector.raspbian.org/raspbian/
fi
