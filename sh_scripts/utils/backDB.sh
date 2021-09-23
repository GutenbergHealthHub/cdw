#!/bin/bash
# Data warehouse backup manager 

# Dump all server with timestamp with extenssion .bak
dua=($(date +"staging_%Y-%m-%d.all.bak"))

# Zip the dump file
dza=($(date +"staging_%Y-%m-%d.all.zip"))
dti=($(date +"staging_%Y-%m-%d"))
cd /media/db/cdw_database/

# Export the credential for der dbms
dbpass=`pass db/supadm`
export PGPASSWORD=$dbpass

# insert new IDs in diz_intern.diziduuid
/usr/local/pg12tde/bin/psql -p 5433 -w -d staging_test -c "call diz_intern.insert_new_id();"
/usr/local/pg12tde/bin/psql -p 5433 -w -d staging -c "call diz_intern.insert_new_id();"

# set sensible data to empty string in table co6_data_string
/usr/local/pg12tde/bin/psql -p 5433 -w -d staging -c "call copra.set_to_void_dsgvo();"

# Dump server
/usr/local/pg12tde/bin/pg_dumpall > /media/db/cdw_database/$dua -p 5433 -w

# Password for zip file
zipdump=`pass db/zipdb`
zip -P $zipdump $dza $dua

# remove .bak file
rm /media/db/cdw_database/$dua

# move zip file into backup directory
mv /media/db/cdw_database/$dza /media/db/cdw_database/dbBack/$dza

# copy the zip file in miradock vm
rsync -rav /media/db/cdw_database/dbBack/$dti.* miraroot@10.128.193.9:/home/miraroot/backCDW/
cd
exit
