# Count number of columns in csv (with ";") files

cd $1
#cd /home/$USER/cdw/ICD/icd_versions/codes
echo "Count columns in code files and copy to csv files..."

for t in *.txt; do
  csv=`echo $t | sed -e 's/txt/csv/'` # csv file
  col=`awk -F';' 'NR==1{print NF}' $t` # number of columns in file
  [[ $t =~ [0-9]{4} ]] && ver=${BASH_REMATCH[0]} # year of version of ICDs
  
  # selecting important columns
  # versions from 2007 to 2011
  [[ $col == "27" ]] && awk -v y="$ver" -F ';' '{OFS = ";"}{print y, $1, $2, $3, $4, $5, $6, $7, $8, $9, "", "", "", $10, $11, $12, $13, $14, $15, $16, $17, $18, $20, $22, $23, $24, $25, $26, $27}' $t > $csv

  # versions from 2012 to 2016
  [[ $col == "30" ]] && awk -v y="$ver" -F ';' '{OFS = ";"}{print y, $1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14, $15, $16, $17, $18, $19, $20, $21, $23, $25, $26, $27, $28, $29, $30}' $t > $csv
  
  # versions from 2017 till now
  [[ $col == "28" ]] && awk -v y="$ver" -F ';' '{OFS = ";"}{print y, $0}' $t > $csv

  chmod -w $csv # delete write permissions
done
cd
exit

