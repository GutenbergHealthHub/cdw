# ETL for all icd from 2007 to 2021
icdversions="/home/$USER/cdw/ICD/icd_versions/"
icdcodes="${icdversions}codes/"
bash ../../utils/unziper.sh $icdversions
bash ../../utils/copy_codes.sh $icdversions
bash ../../utils/extra_info.sh $icdversions
bash ../../utils/iso_2_utf8.sh $icdcodes
cd
echo "End!"
exit
