export PATH=$PATH:$HOME/bin:$HOME/scripts
export DISPLAY=":0"
export LANG=uk_UA.UTF-8
export LC_ALL=uk_UA.UTF-8

xrdb $HOME/.Xdefaults
xmodmap $HOME/.Xmodmap
# Launch DBUS
if test -z "$DBUS_SESSION_BUS_ADDRESS" ; then
 dbus-launch --sh-syntax --with-session
fi
awesome >> $HOME/awesome.err &
exec bash $HOME/.autostart
