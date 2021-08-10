# ETL for all icd from 2007 to 2021
icdversions="/home/$USER/cdw/ICD/icd_versions/"
icdcodes="${icdversions}codes/"
dat=${icdcodes}icd10gm_versions.dat
ver='icd10gm[0-9]{4}'
bash ../../utils/unziper.sh $icdversions
bash ../../utils/copy_codes.sh $icdversions $ver
bash ../../utils/extra_info.sh $icdversions $dat
bash ../../utils/iso_2_utf8.sh $icdcodes
bash ../../utils/column_count.sh $icdcodes
cd
echo "End!"
exit
