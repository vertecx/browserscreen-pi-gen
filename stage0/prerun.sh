#!/bin/bash -e
if [ ! -d ${ROOTFS_DIR} ]; then
	bootstrap --exclude=apt-utils,aptitude,aptitude-common,bsdmainutils,dmidecode,groff-base,info,install-info,iptables,isc-dhcp-client,isc-dhcp-common,libapt-inst1.5,libboost-iostreams1.49.0,libboost-iostreams1.50.0,libboost-iostreams1.53.0,libboost-iostreams1.54.0,libboost-iostreams1.55.0,libdns-export100,libident,libirs-export91,libisc-export95,libisccfg-export90,libpipeline1,libsigc++-1.2-5c2,libsysfs2,libudev0,libxapian22,libxtables10,man-db,manpages,nano,netcat-openbsd,netcat-traditional,tasksel,tasksel-data jessie ${ROOTFS_DIR} http://mirrordirector.raspbian.org/raspbian/
fi
