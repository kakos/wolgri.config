#!/bin/bash

# Create an new TAP interface for the user 'vbox' and remember its name.
interface=`VBoxTunctl -b -u grishka`

# If for some reason the interface could not be created, return 1 to
# tell this to VirtualBox.
if [ -z "$interface" ]; then
exit 1
fi

# Write the name of the interface to the standard output.
echo $interface

# Bring up the interface.
/sbin/ifconfig $interface up

# And add it to the bridge.
/usr/sbin/brctl addif br0 $interface
