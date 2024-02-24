# /bin/sh

# while xsetroot -name "`date` `uptime | sed 's/.*,//'`"
# do
# 	sleep 1
# done &
exec slstatus &
exec startdwm
