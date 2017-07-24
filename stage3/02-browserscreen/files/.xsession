#!/bin/sh

address=http://www.ptrdata.com/randomdashboard/
ntp='0.debian.pool.ntp.org 1.debian.pool.ntp.org 2.debian.pool.ntp.org'
locale=sv_SE.UTF-8
chromium_args=''

if [ -f /boot/browserscreen.txt ]; then
	. /boot/browserscreen.txt
fi

# On Wi-Fi with weak signal, the network connection might not be up when this
# script is started. Giving the network up to 20 extra seconds to come up
# should hopefully prevent ntpdate from failing and Chromium from showing an
# error message.
tries=10
until [ $tries -eq 0 ]; do
	wget --spider --no-check-certificate --tries=1 "$address" > /dev/null 2>&1 && break
	sleep 2
	tries=`expr $tries - 1`
done

# Quickly set the time and date by polling the NTP server once.
sudo ntpdate -p 1 $ntp

# Disable screen blanking and power saving.
xset s off -dpms

LANG=$locale /usr/bin/chromium-browser --kiosk --incognito --noerrdialogs --disable-cloud-import --disable-infobars --disable-sync --disable-translate --load-extension=/usr/local/share/browserscreen-extension --window-position=0,0 --window-size=7000,7000 $chromium_args --app=$address
