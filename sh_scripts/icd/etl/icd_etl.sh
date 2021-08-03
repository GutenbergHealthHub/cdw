# ETL for all icd from 2007 to 2021
icdversions="/home/$USER/cdw/ICD/icd_versions/"
icdcodes="${icdversions}codes/"
bash unziper.sh $icdversions
bash copy_codes.sh $icdversions
bash iso_2_utf8.sh $icdcodes
cd
echo "End!"
exit
