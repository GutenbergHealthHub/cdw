# Count number of columns in csv (with ";") files

#cd $1
cd /home/$USER/cdw/ICD/icd_versions/codes
echo "Count columns in code files..."

for t in *.txt; do
  col=`awk -F';' 'NR==1{print NF}' $t`
  echo "$t $col"
done
cd
exit

