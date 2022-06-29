echo "\\chapter{Bauliche Einheiten - Tabelle NBAU}"
  echo "  Die bauliche Einheiten befinden sich in der Tabelle \\texttt{NBAU}."
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
     if [ "$tables" = "$tab" ]
     then
       if [ "$ty" = "bigint" ]
       then 
         echo "$col & $ty & Menge an baulischen Einheiten mit eine bestimmten $tables \\\\ \\hline"  | sed -e 's/DQA_NBAU_//g' # -e 's///'
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
