#!/bin/sh

#=====================================================================
# cron.sh, v1.0
# Created 2016 by Florian Brandstetter
#
# (1) Attempts to ping several hosts to test connectivity.  After
#     first successful ping, script exits.
# (2) If all pings fail, resets interface and retries all pings.
# (3) If all pings fail again after reset, then reboots pfSense.
#=====================================================================

#=====================================================================
# USER SETTINGS
#
# Set multiple ping targets separated by space.  Include numeric IPs
# (e.g., remote office, ISP gateway, etc.) for DNS issues which
# reboot will not correct.
ALLDEST="8.8.8.8 8.8.4.4 4.4.4.1 4.4.4.2"
# Interface to reset, usually your WAN
BOUNCE=eth0
# Log file
LOGFILE=/var/log/bounceLine.log
#=====================================================================

COUNT=1
while [ $COUNT -le 2 ]
do

	for DEST in $ALLDEST
	do
		ping -c1 $DEST >/dev/null 2>/dev/null
		if [ $? -eq 0 ]
		then
			echo `date +%Y%m%d.%H%M%S` "LINE OK" >> $LOGFILE
			exit 0
		fi
	done

	if [ $COUNT -le 1 ]
	then
		echo `date +%Y%m%d.%H%M%S` "LINE DOWN" >> $LOGFILE
		/sbin/ifconfig $BOUNCE down
		# Give interface time to reset before bringing back up
		sleep 10
		/sbin/ifconfig $BOUNCE up
		# Give WAN time to establish connection
		sleep 60
	else
		echo `date +%Y%m%d.%H%M%S` "LINE CRITICAL" >> $LOGFILE
		/sbin/shutdown -r now >> $LOGFILE
		exit 1
	fi

	COUNT=`expr $COUNT + 1`
done
