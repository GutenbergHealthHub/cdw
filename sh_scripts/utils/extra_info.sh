# Copy the version and date of version in a csv file (;)

cd $1 # Directory with information about the version
da=$2 # Date of release
echo "Coping release date to file icd10gm_versions.dat..."
# echo "version;release" > $1codes/icd10gm_versions.dat
echo "version;release" > $da
verpatern='[0-9]{4}' # icd version
creationdate='([0-9]{2})(.[0-9]{2}.)([0-9]{4})' # date of creation of icd

for d in */*/*metadaten*.txt;do # iteration in directories with metadata (metadaten)
 [[ $d =~ $verpatern ]] && ver=${BASH_REMATCH[0]}
  tmpdat=`grep -E -o "$creationdate" $d | head -1`
  [[ $tmpdat =~ $creationdate ]] && dat="${BASH_REMATCH[3]}${BASH_REMATCH[2]}${BASH_REMATCH[1]}"
  echo "$ver;$dat" >> $da
done

