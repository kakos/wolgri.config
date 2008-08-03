#!/bin/sh
sudo madwifi-unload 
sudo modprobe ath_pci autocreate=none
sudo wlanconfig wlan create wlandev wifi0 wlanmode sta nosbeacon -bssid # wlan0 managed 
sudo wlanconfig wlan create wlandev wifi0 wlanmode ap   # wlan1 ap 


