# Installation

Clone the Repository

    git clone https://github.com/fbrandstetter/bounceLine.git /opt/bounceLine/
    
Create log file

    touch /var/log/bounceLine.log

Enter crontab

    crontab -e
    
Insert to end of file

    * * * * * /opt/bounceLine/cron.sh
    00 00 * * * /opt/bounceLine/clear.sh

Enjoy!
