# Insert into db
cd $1

dbpass=`pass cdwadmin`
export PGPASSWORD=$dbpass
echo "Inserting into database..."
for icd in *.csv; do
  echo $icd
  /usr/local/pgtde/bin/psql -p 5433 -w -d test_icd -U clinicuser -c "COPY $2 FROM '$1$icd' WITH DELIMITER E';' CSV QUOTE E'\b';"
done
cd
exit
