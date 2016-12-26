# bounceLine
A script that resets an interface if Internet goes down.
## Why?
After I've got a new modem for my internet connection, things started going weird sometimes and the connection does not work anymore after some time. A solution for that was, writing a script that automatically resets the interface in order to request a new DHCP lease.
## How?
Just run the cron.sh every minute and the clear.sh at the time you want to clear the logfile.
