. /boot/browserscreen.txt

sudo ntpdate -p 1 $ntp

xset s off -dpms

/usr/bin/chromium-browser --kiosk --incognito --noerrdialogs --disable-cloud-import --disable-extensions --disable-infobars --disable-sync --disable-translate --window-position=0,0 --window-size=7000,7000 $chromium_args --app=$address
