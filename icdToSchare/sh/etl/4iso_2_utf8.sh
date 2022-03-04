# Convert files format from ISO-8859 to UTF-8

cd $1
echo "From ISO-8859 to UTF-8 and remove BOM..."

for t in *.txt; do
  fo=`file $t`
  if [[ $fo =~ ISO ]]; then
    mv $t ${t}.old
    iconv -f ISO-8859-15 -t UTF-8//TRANSLIT < ${t}.old > $t
    rm ${t}.old
  fi
  if [[ $fo =~ BOM ]]; then
    sed -i '1s/^\xEF\xBB\xBF//' $t
  fi
done
cd
exit
