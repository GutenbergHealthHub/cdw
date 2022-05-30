echo "File with tables and columns: "
read file_to_read

echo "Directory for SQL-Scripts of DQA: "
read dqa_views

mkdir -p $dqa_views

while IFS=";" read -r SCHEMA TABLE COLUMN
do
  file_name=`echo "DQA_${TABLE}_${COLUMN}.sql" | sed -e s-/-_-g -e s/__/_/`

  echo "-- DQA_${TABLE}_${COLUMN}" > $dqa_views/$file_name
  echo "CREATE OR REPLACE VIEW ${SCHEMA}.\"DQA_${TABLE}_${COLUMN}\"" >> $dqa_views/$file_name
  echo "  AS" >> $dqa_views/$file_name
  echo "  SELECT count(n.\"RetrievalDate\") AS \"QUANTITY\"," >> $dqa_views/$file_name
  echo "    CASE" >> $dqa_views/$file_name
  echo "      WHEN n.\"$COLUMN\" ~ '\w' THEN n.\"$COLUMN\"" >> $dqa_views/$file_name
  echo "        ELSE NULL" >> $dqa_views/$file_name
  echo "    END AS \"$COLUMN\"/*," >> $dqa_views/$file_name
  echo "    m.long_name*/" >> $dqa_views/$file_name
  echo "  FROM kis.\"$TABLE\" n" >> $dqa_views/$file_name
  echo "  --LEFT JOIN metadata_repository.TABLE m ON n.\"$COLUMN\" = m.sourceid" >> $dqa_views/$file_name
  echo "  GROUP BY n.\"$COLUMN\"--, m.long_name" >> $dqa_views/$file_name
  echo "  ORDER BY \"QUANTITY\" DESC;" >> $dqa_views/$file_name
  echo "" >> $dqa_views/$file_name
done < $file_to_read
