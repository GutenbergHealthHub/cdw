# Insert into db
cd $1

dbpass=`pass cdwadmin`
export PGPASSWORD=$dbpass
echo "Inserting into database..."
for file in *.csv; do
  echo $file
  /usr/local/pgtde/bin/psql -p 5433 -w -d test_icd -U clinicuser -c "COPY $2 FROM '$1$file' WITH DELIMITER E';' CSV QUOTE E'\b';"
#  /usr/local/pgtde/bin/psql -p 5433 -w -d test_icd -U clinicuser -c "TRUNCATE $2 CASCADE;"
done
cd
exit
