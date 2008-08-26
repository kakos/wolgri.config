do_start (){
 sudo invoke-rc.d mysql start
 sudo invoke-rc.d lighttpd start
}
do_stop (){
 sudo invoke-rc.d mysql stop
 sudo invoke-rc.d lighttpd stop
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


