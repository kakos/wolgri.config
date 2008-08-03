#!/bin/bash
#
# n770encode.sh
#
# Usage: n770encode.sh inputfile
#

FILE=$1
OUT=`echo -n "$FILE" | sed 's/\.[a-zA-Z0-9]\+$/-n770.avi/'`
ABR=128
VBR=400
RES='err'

echo "Processing input file $FILE..."
echo
echo "Aspect ratio?"
echo "(1) 4:3"
echo "(2) 16:9"
echo -n "Select [1]: "
read aspect
if [ "$aspect" = "1" ]; then
  RES='320:240'
else
  RES='352:208'
fi

echo -n "Video bitrate? [$VBR]: "
read vbr_in
if [ "$vbr_in" != "" ]; then
  VBR=$vbr_in
fi

echo -n "Audio bitrate? [$ABR]: "
read abr_in
if [ "$abr_in" != "" ]; then
  ABR=$abr_in
fi

rm -f divx2pass.log 2>/dev/null
echo $OUT
#nice -n 19 \
mencoder -oac mp3lame -lameopts abr:br=$ABR -ovc lavc -lavcopts vcodec=mpeg4:mbd=1:vbitrate=$VBR -vf scale=$RES,expand=$RES -ffourcc DIVX -ofps 15 "$FILE" -o "$OUT"
