#!/bin/sh

#=====================================================================
# clear.sh, v1.0
# Created 2016 by Florian Brandstetter
#
# (1) Clears the log-file which writes every minute in order to keep
#     the disk usage at a appropriate level.
#=====================================================================
LOGFILE=/var/log/bounceLine.log

rm -rf $LOGFILE
touch $LOGFILE
echo `date +%Y%m%d.%H%M%S` "LOG FILE RESETTED" >> $LOGFILE
