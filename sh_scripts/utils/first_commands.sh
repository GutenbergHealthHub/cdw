#!/bin/sh
# Show
# - server updates
# - last date of reboot of server
# - recent backup of database
# - log files of database 

echo 'UPDATE...?'
sudo apt update
sudo apt list --upgradable
echo

echo 'REBOOT...?'
who -b
echo

echo 'DB DUMP...?'
ls -Alrt /media/db/cdw_database/dbBack/ | tail -n 2 # show newest backup files (yesterday and today)
cd /media/db/cdw_database/dbBack/
rm `ls -1rt /media/db/cdw_database/dbBack/ | head -n 1` # delete oldest backup file

echo 'Log Database...'
tail -20 /media/db/cdw_database/clinic_instance_log # last errors/warnings in the database
exit


