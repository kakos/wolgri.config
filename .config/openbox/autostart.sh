# Run the system-wide support stuff
. $GLOBALAUTOSTART
export PATH=$PATH:$HOME/bin:$HOME/scripts
# Programs that will run after Openbox has started
#xfce-mcs-manager&
conky&
#lxpanel&
xsetroot -solid \#192024
xscreensaver-command -lock
#xfce4-panel&
#/home/wolgri/stuff/visibility/visibility.py&
#/home/wolgri/scripts/logterm&
$HOME/bin/stalonetray  -i 16 -w -p -geometry 16x16 -v & 
#$HOME/bin/stalonetray  -i 16 --skip-taskbar   -w --dbg-level 0 --respect-icon-hints 0 --fuzzy-edges 3 -geometry 64x64&
$HOME/bin/doctime&
