#!/bin/bash
cd
cd /home/$USER/cdw/OPS/to_import
echo "-- insert into ops..." > /home/$USER/cdw/sql_scripts_general/tde_sql/ops_insert_code-titel.sql
opsDir=`pwd`
for i in {2008..2020} ; do 
    cd $i
    awk -F ';' 'BEGIN{OFS = ";"}{print $5,$6}' "ops"$i"_tr.txt" > "ops"$i"_tr_2c.txt"
    echo "COPY metadata_repository.tmp_ops from '$opsDir/$i/ops${i}_tr_2c.txt' WITH DELIMITER E';' CSV QUOTE E'\b';" >> /home/$USER/cdw/sql_scripts_general/tde_sql/ops_insert_code-titel.sql
    cd ..
  done
cd

