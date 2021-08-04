# Count number of columns in csv (with ";") files

#cd $1
cd /home/$USER/cdw/ICD/icd_versions/codes
echo "Count columns in code files..."

for t in *.txt; do
  col=`awk -F';' 'NR==1{print NF}' $t`
  [[ $t =~ [0-9]{4} ]] && ver=${BASH_REMATCH[0]}
  echo "$t $col"
  [[ $col == "27" ]] && awk -v y="$ver" -F ';' '{OFS = ";"}{print $1, $2, $3, $4, $5, $6, $7, $8, $9, "", "", "", $10, $11, $12, $13, $14, $15, $16, $17, $18, $20, $22, $23, $24, $25, $26, $27, y}' $t | head -1
  [[ $col == "30" ]] && awk -F ';' '{OFS = ";"}{print $1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14, $15, $16, $17, $18, $19, $20, $21, $23, $25, $26, $27, $28, $29, $30}' $t | head -1
  [[ $col == "28" ]] && head -1 $t
done
cd
exit

