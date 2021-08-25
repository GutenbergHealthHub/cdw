# Insert into db
cd $1
#db=$test_icd
db=staging_test
dbpass=`pass db_pass`
export PGPASSWORD=$dbpass
echo "Inserting into database..."

# Disable all triggers in the table kode to insert all info
/usr/local/pgtde/bin/psql -p 5433 -w -d $db -U db_user -c "ALTER TABLE $2 DISABLE TRIGGER ALL;"

# Enable trigger to insert and management the new data
/usr/local/pgtde/bin/psql -p 5433 -w -d $db -U db_user -c "ALTER TABLE $2 ENABLE TRIGGER $3;"

for file in *.csv; do
  echo $file
  /usr/local/pgtde/bin/psql -p 5433 -w -d $db -U db_user -c "TRUNCATE $2 CASCADE;"
  /usr/local/pgtde/bin/psql -p 5433 -w -d $db -U db_user -c "COPY $2 FROM '$1$file' WITH DELIMITER E';' CSV QUOTE E'\b';"
done

# Enable all triggers again
/usr/local/pgtde/bin/psql -p 5433 -w -d $db -U db_user -c "ALTER TABLE $2 ENABLE TRIGGER ALL;"
cd
exit
