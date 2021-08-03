# Convert files format from ISO-8859 to UTF-8

cd $1
echo "from ISO-8859 to UTF-8..."

for t in *.txt; do
  fo=`file $t`
  if [[ $fo =~ ISO ]]; then
    mv $t ${t}.old
    iconv -f ISO-8859-15 -t UTF-8//TRANSLIT < ${t}.old > $t
    rm ${t}.old
  fi
done
cd
exit
