#!/bin/bash

# Transform date format and import the tranformed file in the directory to import.
echo -n "Please enter a year with data of p21: "
read year_to_import # take year to import (yyyy)
if [[ "$year_to_import" =~ ^20[0-9]{2}$ ]]; then # take year to import (yyyy)
  sql_import=sql_"$year_to_import"_p21_import.sql
  root_path="/home/$USER/cdw"
  p21_import_path="/home/$USER/cdw/P21/toImport"
  echo "SQL-script to import $sql_import"
  echo "" > $root_path/sql_scripts_general/$sql_import
  cd /home/$USER/cdw/P21/$year_to_import
  mkdir -p $p21_import_path/$year_to_import
  ls
  CSV=`ls -1 *.CSV 2>/dev/null | wc -l`
  if [[ $CSV != 0 ]]
    then
    # change extension CSV to csv
    echo "CSV found!"
    echo "CSV to csv..."
  for CSV in *.CSV; do 
    mv -- "$CSV" "${CSV%.CSV}.csv"
  done
  fi
  ls
  csv_dir=($(ls))
  for tranf in ${csv_dir[@]}; do
    # convert from ISO... to UTF-8
    tranf_utf=utf_$tranf
    iconv -f ISO-8859-15 -t UTF-8//TRANSLIT < $tranf > $tranf_utf
    upd=upd$tranf
    # transform date format from yyyymmddhhMM to yyyy-mm-dd hhMM
    p21_table=""
    echo $upd
    if [[ $upd == "updFAB.csv" ]]; then
      p21_table="p21_fab"
      awk -F ';' 'BEGIN{OFS = ";"}{print '$year_to_import', $4, $5,$6, $7}' $tranf_utf > $p21_import_path/$year_to_import/$upd
    fi
    if [[ $upd == "updFALL.csv" ]]; then
      p21_table="p21_fall"
      awk -F ';' 'BEGIN{OFS = ";"}{print '$year_to_import', $4, $8,$10, $11, $13, $14, $15, $16, $17, $18, $19, $20, $21, $23, $25}' $tranf_utf > $p21_import_path/$year_to_import/$upd
    fi
    if [[ $upd == "updICD.csv" ]]; then
      p21_table="p21_icd"
      awk -F ';' 'BEGIN{OFS = ";"}{print '$year_to_import', $4, $5,$6, $7, $8, $10, $11}' $tranf_utf > $p21_import_path/$year_to_import/$upd
      sed -i "s/\(Lokalisation\)\($\)/Lokalisation1$2/" $p21_import_path/$year_to_import/$upd      
    fi
    if [[ $upd == "updOPS.csv" ]]; then
      p21_table="p21_ops"
      awk -F ';' 'BEGIN{OFS = ";"}{print '$year_to_import', $4, $5,$6, $7, $8}' $tranf_utf > $p21_import_path/$year_to_import/$upd
    fi
    
    sed -i 's/\([[:digit:]]\{4\}\)\([[:digit:]]\{2\}\)\([[:digit:]]\{2\}\)\([[:digit:]]\{4\}\)/\1-\2-\3 \4/g' $p21_import_path/$year_to_import/$upd
    rm $tranf_utf
    # transform date format from yyyymmdd to yyyy-mm-dd
    sed -i 's/\(20[[:digit:]]\{2\}\)\([[:digit:]]\{2\}\)\([[:digit:]]\{2\}\)/\1-\2-\3/g' $p21_import_path/$year_to_import/$upd
    #sed -i "s/^/$year_to_import;/" /home/$USER/cdw/P21/toImport/$year_to_import/$upd
    header=`head -1 /home/$USER/cdw/P21/toImport/$year_to_import/$upd | sed -e 's/;/,/g'`
    header=`echo $header | sed -e 's/20[[:digit:]]*/Jahr/'`
    header=`echo $header | sed -e 's/ä\|ö\|ü\|-/_/g'`
    # echo $header
    
    echo "\copy sch_staging.$p21_table ($header) FROM '$p21_import_path/$year_to_import/$upd' WITH DELIMITER E';' CSV QUOTE E'\b' header;">> $root_path/sql_scripts_general/$sql_import
  done
  echo "The files are tranformed in: "
  echo "/home/$USER/cdw/P21/toImport/"
  ls $p21_import_path/$year_to_import
  cd
else
  echo "Input value is not a year." >&2
  exit 1
fi
exit
