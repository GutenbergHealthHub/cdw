# Copy the icd10gm codes into the directory codes
# if directory codes exists remove content of directory
cd ~/cdw/ICD/icd_versions

[ -d codes  ] && rm codes/*

# if directory codes not exists create directroy
[ ! -d codes ] &&  mkdir -p codes

echo "Coping files with icd10gm codes into codes directory..."
# copy files with icd10gm codes into codes directory
for d in */*/*/*s20*.txt;do cp $d codes;done
for d in */*/*/*[sS].txt;do cp $d codes;done
cd
exit
