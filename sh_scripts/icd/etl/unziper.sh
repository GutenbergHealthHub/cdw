cd ~/cdw/ICD/icd_versions

echo "Unziping files..."
for z in *.zip; do
   di=`echo $z | sed -e 's/\.zip//'`
   #echo "$di end"
   mkdir -p $di
   unzip -q $z -d $di
done
cd
exit
