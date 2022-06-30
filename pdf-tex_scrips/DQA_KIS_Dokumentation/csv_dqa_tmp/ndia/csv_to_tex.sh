echo "\\chapter{Diagnosen - Tabelle NDIA}"
  echo "  Die Diagnosen der Fällen befinden sich in der Tabelle \\texttt{NDIA}."
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
         echo "$col & $ty & Menge an Diagnosen mit eine bestimmten $tables \\\\ \\hline"  | sed -e 's/DQA_NDIA_//g'  -e 's/_/\\_/'
       else
	       echo "$col & $ty & $col (NULL bei nicht existierende $col)\\\\ \\hline" | sed -e 's/_/\\_/g'
       fi
     fi
  done < columns.csv
  echo "    \\end{tabular}"
  echo "  \\end{table}"
  echo " \\clearpage"
 # echo $tables
done < tables.csv
