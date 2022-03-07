# Insert into db
cd $1
db=icd # your database
dbpass=`pass cdwadmin` # tool pass in Linux managers the password
db_user="clinicuser" # your user
export PGPASSWORD=$dbpass 
echo "Inserting into database..."
table_release=$4
releases=$3
table_kodes=$2
trigger_new=$5
trigger_upd=$6
trigger_del=$7
trigger_reu=$8
currentmetadata=$9
schema=${10}


# You can substitute the commands "/usr/local/pgtde/bin/psql -p 5433" to psql if you have a standard installation of postgres

# Insert another current metadata

# Truncate metadata tables
 metadata="/home/$USER/cdw/ICD/$currentmetadata/Klassifikationsdateien/"
for trunc in mortl4 mortl3 mortl3grp mortl2 mortl1 mortl1grp morbl gruppen kapitel; do
  /usr/local/pgtde/bin/psql -p 5433 -w -d $db -U $db_user -c "TRUNCATE $schema$trunc CASCADE;"
done

# Insert into metadata tables
for meta in kapitel gruppen morbl mortl1grp mortl1_ mortl2 mortl3grp mortl3_ mortl4; do
  for fileMeta in `ls -1 $metadata`; do
    if [[ $fileMeta =~ $meta ]];then
      metaCopy=`echo $meta | sed -e 's/_//'`
      echo $metaCopy
      # echo "/usr/local/pgtde/bin/psql -p 5433 -w -d $db -U $db_user -c COPY $schema$metaCopy from '$metadata$fileMeta' WITH DELIMITER E';' CSV QUOTE E'\b';"
      /usr/local/pgtde/bin/psql -p 5433 -w -d $db -U $db_user -c "COPY $schema$metaCopy from '$metadata$fileMeta' WITH DELIMITER E';' CSV QUOTE E'\b';"
    fi
  done
done

# Insert into version and release date into table
/usr/local/pgtde/bin/psql -p 5433 -w -d $db -U $db_user -c "TRUNCATE $schema$table_release CASCADE;"
/usr/local/pgtde/bin/psql -p 5433 -w -d $db -U $db_user -c "COPY $schema$table_release FROM '$releases' WITH DELIMITER E';' HEADER CSV QUOTE E'\b';"

# Disable all triggers in the table kode to insert all info
/usr/local/pgtde/bin/psql -p 5433 -w -d $db -U $db_user -c "ALTER TABLE $schema$table_kodes DISABLE TRIGGER ALL;"

# Enable trigger to insert and management the new data
/usr/local/pgtde/bin/psql -p 5433 -w -d $db -U $db_user -c "ALTER TABLE $schema$table_kodes ENABLE TRIGGER $trigger_new;"
/usr/local/pgtde/bin/psql -p 5433 -w -d $db -U $db_user -c "ALTER TABLE $schema$table_kodes ENABLE TRIGGER $trigger_upd;"
/usr/local/pgtde/bin/psql -p 5433 -w -d $db -U $db_user -c "ALTER TABLE $schema$table_kodes ENABLE TRIGGER $trigger_del;"
/usr/local/pgtde/bin/psql -p 5433 -w -d $db -U $db_user -c "ALTER TABLE $schema$table_kodes ENABLE TRIGGER $trigger_reu;"

for file in *.csv; do
  echo $file
  /usr/local/pgtde/bin/psql -p 5433 -w -d $db -U $db_user -c "TRUNCATE $schema$table_kodes CASCADE;"
  /usr/local/pgtde/bin/psql -p 5433 -w -d $db -U $db_user -c "COPY $schema$table_kodes FROM '$1$file' WITH DELIMITER E';' CSV QUOTE E'\b';"
done



# Enable all triggers again
/usr/local/pgtde/bin/psql -p 5433 -w -d $db -U $db_user -c "ALTER TABLE $schema$table_kodes ENABLE TRIGGER ALL;"
cd
exit
