# ETL for all icd from 2007 to 2021
#icdversions="/home/$USER/cdw/ICD/icd_versions/" # derectory with all information of icd
icdversions="/media/db/cdw_files/ICD/icd_versions/"
icdcodes="${icdversions}codes/" # directory with codes
dat=${icdcodes}icd10gm_versions.dat # releases
tb="icd_metainfo.kodes" # kode table in database
tr="tr_icd10gm_insert_from_bfarm"
ver='icd10gm[0-9]{4}'
cd
echo "End!"
exit
