#!/bin/sh
/sbin/ifdown wlan0
/sbin/ifdown wlan1
/sbin/ifdown wlan2
/usr/local/bin/madwifi-unload
/sbin/modprobe ath_pci autocreate=none ath_debug=0 ieee80211_debug=0 outdoor=0 xchanmode=1
/sbin/wlanconfig wlan1 create wlandev wifi0 wlanmode ap   # wlan1 ap 
/sbin/wlanconfig wlan0 create wlandev wifi0 wlanmode sta # wlan0 managed 
#/sbin/wlanconfig wlan2 create wlandev wifi0 wlanmode monitor   # wlan2 monitor 
