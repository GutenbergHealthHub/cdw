cd $1

echo "Unziping files..."
for z in *.zip; do
   di=`echo $z | sed -e 's/\.zip//'`
   mkdir -p $di
   unzip -q $z -d $di
done
cd
exit
