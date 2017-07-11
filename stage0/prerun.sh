#!/bin/bash -e
if [ ! -d ${ROOTFS_DIR} ]; then
	bootstrap --exclude=aptitude,aptitude-common,bsdmainutils,dmidecode,man-db,manpages,nano,netcat-openbsd,netcat-traditional jessie ${ROOTFS_DIR} http://mirrordirector.raspbian.org/raspbian/
fi
