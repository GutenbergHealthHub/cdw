#!/bin/bash
# (Re)Start the database instance
# It is configured in crontab to automatic start the instance when the server reboot.
cd /media/db/cdw_database/
/usr/local/pg12tde/bin/pg_ctl -D clinic_instance restart -l clinic_instance_log
cd
exit
