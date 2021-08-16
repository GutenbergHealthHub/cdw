# ETL for all icd from 2007 to 2021
icdversions="/home/$USER/cdw/ICD/icd_versions/" # derectory with all information of icd
icdcodes="${icdversions}codes/" # directory with codes
dat=${icdcodes}icd10gm_versions.dat # releases
tb="icd_metainfo.icd_tmp" # temporary table in database
ver='icd10gm[0-9]{4}'
bash ../../utils/unziper.sh $icdversions
bash ../../utils/copy_codes.sh $icdversions $ver
bash ../../utils/extra_info.sh $icdversions $dat
bash ../../utils/iso_2_utf8.sh $icdcodes
bash ../../utils/select_columns.sh $icdcodes
bash ../../utils/insert_into_db.sh $icdcodes $tb
cd
echo "End!"
exit
