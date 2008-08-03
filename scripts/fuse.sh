case $1 in
 start)
    smbnetfs $HOME/mount/smb
    mountavfs
  ;;
 stop)
   fusermount -u $HOME/mount/smb 
   umountavfs
;;
 *)
  echo "usage: $0 (start|stop)"
  exit 1
esac
