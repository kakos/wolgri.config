
/sbin/iwconfig wlan0 |sed -e 's/[:=\/\"]/ /g'|awk '
 /Mode/ {print "Point: " $8":"$9":"$10":"$11":"$12":"$13} 
 /Bit Rate/ {print "Rate: " $3" "$4"/"$5}
 /Link Quality/ {print "Quality:" ($3/$4)*100}' 

