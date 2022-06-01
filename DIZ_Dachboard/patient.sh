db=staging_test # database

if [[ $USER =~ abel ]]; then
  dbpass=`pass cdwadmin`
  db_user="clinicuser"
  export PGPASSWORD=$dbpass
  dirpsql="/usr/local/pgtde/bin/psql"
  proxy=5433
  dircsv=/home/abel/git_repos/cdw/DIZ_Dachboard/csv_files
  dirtex=/home/abel/git_repos/cdw/DIZ_Dachboard/tex_files
else
  dbpass=`pass db/her11a_admin`
  db_user="her11a_admin"
  export PGPASSWORD=$dbpass
  dirpsql="/usr/local/pg14_2/bin/psql"
  proxy=5432
  dircsv=/media/db/cdw_database/git_repos/covid_test_app/csv_files
  dirtex=/media/db/cdw_database/git_repos/covid_test_app/tex_files
fi

csvfile=patients.csv
texfile=patients.tex

$dirpsql -p $proxy -w -d $db -U $db_user -c "COPY (select * from diz_intern.dachboard_patient) to '$dircsv/$csvfile' WITH DELIMITER E';' HEADER CSV QUOTE E'\b';"

cd $dirtex
header_tab=`head -n1 $dircsv/$csvfile | sed -e 's/;/ \& /g'`
# echo $header_tab

echo "\\section{Patienten und Patientinnen in KIS}" > $dirtex/$texfile
cat $dirtex/pat >> $dirtex/$texfile
echo "\\rowcolor{lightgray} $header_tab \\\ \\hline" >> $dirtex/$texfile
echo "\\endhead" >> $dirtex/$texfile
sed -e '1d' -e 's/;/ \& /g' -e 's/$/ \\\\ \\hline/' $dircsv/$csvfile >> $dirtex/$texfile
cat $dirtex/tex_end >> $dirtex/$texfile

pdflatex --interaction=batchmode DIZ_Dachboard.tex 2>&1 /dev/null

rm *.log *.aux *.out $texfile
cd 
exit
