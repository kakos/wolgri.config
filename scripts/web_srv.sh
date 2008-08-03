case $1 in
 start)
     sudo invoke-rc.d mysql start
 #    sudo invoke-rc.d php-cgi start
     sudo invoke-rc.d lighttpd start
  ;;
 stop)
     sudo invoke-rc.d mysql stop
#     sudo invoke-rc.d php-cgi stop
     sudo invoke-rc.d lighttpd stop
;;
 *)
  echo "usage: $0 (start|stop)"
  echo "lighttpd:`ps aux |grep lighttpd|grep -v grep | wc -l`"
  echo "mysqld:`ps aux |grep mysqld|grep -v grep| wc -l`"
  exit 1
esac

