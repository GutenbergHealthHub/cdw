cd $1
echo $1
ls -l $1
echo "Unziping files..."
for z in *.zip; do
   di=`echo $z | sed -e 's/\.zip//'` # delete .zip of name of directory
   mkdir -p $di
   unzip -q $z -d $di
done
cd
exit
