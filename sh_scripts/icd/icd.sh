#!/bin/bash
cd
cd /home/$USER/cdw/ICD/to_import
echo "-- insert into icd..." > /home/$USER/cdw/sql_scripts_general/tde_sql/icd_insert_code_titel.sql
icdDir=`pwd`
for i in {2008..2020} ; do 
    cd $i
    awk -F ';' 'BEGIN{OFS = ";"}{print $5, $6, $7}' "icd"$i"_tr.txt" > "icd"$i"_tr_3c.txt"
    echo "COPY metadata_repository.tmp_icd from '$icdDir/$i/icd${i}_tr_3c.txt' WITH DELIMITER E';' CSV QUOTE E'\b';" >> /home/$USER/cdw/sql_scripts_general/tde_sql/icd_insert_code_titel.sql
    cd ..
  done
cd

