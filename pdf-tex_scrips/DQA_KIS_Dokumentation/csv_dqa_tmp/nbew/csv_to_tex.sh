echo "\\chapter{Bewegungen (NBEW)}"
  echo "  Die Bewegungen der Fälle während der Hospitalisierung."
  echo ""

while read tables
do
  echo "  \\section{$tables}" | sed -e 's/_/\\_/g'
  echo ""
  echo "  \\begin{table}[ht]"
  echo "    \\centering"
  echo "    \\caption{View $tables}" | sed -e 's/_/\\_/g'
  echo "    \\label{tab:$tables}" | sed -e 's/_//g' -e 's/[A-Z]/\L&/g'
  echo "    \\begin{tabular}{||l|l|p{10cm}||}"
  echo "      \\hline"
  echo "      Spalte & Datentyp & Beschreibung \\\\ [0.5ex] \\hline \\hline"
  while IFS=';' read -r tab col ty
  do 
#    awk -F ";" 'NR>1 {print $1, $2}' acro_areas_all.csv | sed -e 's/ / \& /'
    # tab=`awk -F ";" 'NR>1 {print $1}' columns.csv`
     if [ "$tables" = "$tab" ]
     then
       if [ "$ty" = "bigint" ]
       then 
         echo "$col & $ty & Menge an Bewegungen mit eine bestimmten $tables in der Tabelle NBEW \\\\ \\hline"  | sed -e 's/DQA_NBEW_//g' # -e 's///'
       else
	       echo "$col & $ty & ... (NULL bei nicht existierende $col)\\\\ \\hline" | sed -e 's/_/\\_/g'
       fi
     fi
  done < columns.csv
  echo "    \\end{tabular}"
  echo "  \\end{table}"
  echo " \\clearpage"
 # echo $tables
done < tables.csv
