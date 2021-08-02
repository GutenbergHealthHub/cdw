for z in *.zip; do
   di=`echo $z | sed -e 's/\.zip//'`
   #echo "$di end"
   mkdir -p $di
   unzip $z -d $di
done
