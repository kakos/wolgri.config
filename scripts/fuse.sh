do_start (){
    fusesmb $HOME/mount/smb
    mountavfs
}
do_stop (){
   fusermount -u $HOME/mount/smb 
   umountavfs
}

case $1 in
 start)
 do_start
  ;;
 stop)
 do_stop
  ;;
 restart)
 do_stop
 do_start
;;

 *)
  echo "usage: $0 (start|stop|restart)"
  exit 1
esac
