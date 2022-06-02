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
  dircsv=/media/db/cdw_database/git_repos/cdw/DIZ_Dachboard/csv_files
  dirtex=/media/db/cdw_database/git_repos/cdw/DIZ_Dachboard/tex_files
fi

for report in general patient cases
do
  echo $report
  csvfile=$report.csv
  texfile=$report.tex

  $dirpsql -p $proxy -w -d $db -U $db_user -c "COPY (select * from diz_intern.dachboard_$report) to '$dircsv/$csvfile' WITH DELIMITER E';' HEADER CSV QUOTE E'\b';"

  cd $dirtex
  header_tab=`head -n1 $dircsv/$csvfile | sed -e 's/;/ \& /g'`

  if [[ $report == "general" ]]
  then 
    echo "\\section{Zusammenfassung}" > $dirtex/$texfile
  elif [[ $report == "patient" ]]
  then
    echo "\\section{Patienten und Patientinnen}" > $dirtex/$texfile
  elif [[ $report == "cases" ]]
  then
    echo "\\section{Fälle}" > $dirtex/$texfile
  fi

  cat $dirtex/$report >> $dirtex/$texfile
  echo "\\rowcolor{lightgray} $header_tab \\\ \\hline" >> $dirtex/$texfile
  echo "\\endhead" >> $dirtex/$texfile
  sed -e '1d' -e 's/;/ \& /g' -e 's/$/ \\\\ \\hline/' $dircsv/$csvfile >> $dirtex/$texfile
  cat $dirtex/tex_end >> $dirtex/$texfile
done


pdflatex --interaction=batchmode DIZ_Dachboard.tex 2>&1 /dev/null

rm *.log *.aux *.out
cd 
exit
