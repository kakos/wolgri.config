#!/bin/sh
. ~/secret/gmail
MCOUNT=`curl -s --user $AUTH https://mail.google.com/mail/feed/atom/unread| grep fullcount |sed -e 's/[a-z,<,>,\/]//g'`
echo $MCOUNT
