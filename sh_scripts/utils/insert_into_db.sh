# Insert into db
cd $1
db="test_icd"
#db=staging_test
dbpass=`pass cdwadmin`
#dbpass=`pass db_pass`
db_user="clinicuser"
export PGPASSWORD=$dbpass
echo "Inserting into database..."
table_release=$4
releases=$3
table_kodes=$2
trigger_new=$5
trigger_upd=$6
trigger_del=$7
trigger_reu=$8

# Insert into version and release date into table
/usr/local/pgtde/bin/psql -p 5433 -w -d $db -U $db_user -c "TRUNCATE $table_release CASCADE;"
/usr/local/pgtde/bin/psql -p 5433 -w -d $db -U $db_user -c "COPY $table_release FROM '$releases' WITH DELIMITER E';' HEADER CSV QUOTE E'\b';"

# Disable all triggers in the table kode to insert all info
/usr/local/pgtde/bin/psql -p 5433 -w -d $db -U $db_user -c "ALTER TABLE $table_kodes DISABLE TRIGGER ALL;"

# Enable trigger to insert and management the new data
/usr/local/pgtde/bin/psql -p 5433 -w -d $db -U $db_user -c "ALTER TABLE $table_kodes ENABLE TRIGGER $trigger_new;"
/usr/local/pgtde/bin/psql -p 5433 -w -d $db -U $db_user -c "ALTER TABLE $table_kodes ENABLE TRIGGER $trigger_upd;"
/usr/local/pgtde/bin/psql -p 5433 -w -d $db -U $db_user -c "ALTER TABLE $table_kodes ENABLE TRIGGER $trigger_del;"
/usr/local/pgtde/bin/psql -p 5433 -w -d $db -U $db_user -c "ALTER TABLE $table_kodes ENABLE TRIGGER $trigger_reu;"

for file in *.csv; do
  echo $file
  /usr/local/pgtde/bin/psql -p 5433 -w -d $db -U $db_user -c "TRUNCATE $table_kodes CASCADE;"
  /usr/local/pgtde/bin/psql -p 5433 -w -d $db -U $db_user -c "COPY $table_kodes FROM '$1$file' WITH DELIMITER E';' CSV QUOTE E'\b';"
done

# Enable all triggers again
/usr/local/pgtde/bin/psql -p 5433 -w -d $db -U $db_user -c "ALTER TABLE $table_kodes ENABLE TRIGGER ALL;"
cd
exit
