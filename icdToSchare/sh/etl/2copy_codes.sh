# Copy the icd10gm codes into the directory codes
# if directory with files with codes exists remove content of directory
# cd ~/cdw/ICD/icd_versions
cd $1

[ -d codes  ] && rm -rf codes/*

# if directory codes not exists create directroy
[ ! -d codes ] &&  mkdir -p codes

echo "Coping files with icd10gm codes into codes directory..."

# ver='icd10gm[0-9]{4}' # icd version
ver=$2
# copy files with icd10gm codes into codes directory

# from 2007 to 2020
for d in */*/*/*s20*.txt */*/*/*[sS].txt */*/*[sS].txt */*/*s20*.txt;do # iteration in directory with codes
  if [[ $d =~ $ver ]]; then # name in directory for version
    icdcodes=`echo $d | sed -e 's/\.txt//g'` # remove .txt
    cp $d codes/${BASH_REMATCH[0]}.txt # copy to directory codes
    # chmod -w codes/${BASH_REMATCH[0]}.txt
  fi
done


