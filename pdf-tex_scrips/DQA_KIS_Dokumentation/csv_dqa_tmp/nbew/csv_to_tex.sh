while read tables
do
  echo "\\section{$tables}" | sed -e 's/_/\\_/g'
  echo ""
  echo $tables
done < tables.csv
