# ETL for all icd from 2007 to 2021
#icdversions="/home/$USER/cdw/ICD/icd_versions/" # derectory with all information of icd
icdversions="/media/db/cdw_files/ICD/icd_versions/"
icdcodes="${icdversions}codes/" # directory with codes
dat=${icdcodes}icd10gm_versions.dat # releases
tb="icd_metainfo.kodes" # kode table in database
tr="tr_icd10gm_insert_from_bfarm"
ver='icd10gm[0-9]{4}'
#bash ../../utils/unziper.sh $icdversions
#bash ../../utils/copy_codes.sh $icdversions $ver
#bash ../../utils/extra_info.sh $icdversions $dat
#bash ../../utils/iso_2_utf8.sh $icdcodes
#bash ../../utils/select_columns.sh $icdcodes
#awk -v y="2021" -F ';' '{OFS = ";"}{print y, $0}' ${icdversions}icd10gm2021syst-meta-20201111/Klassifikationsdateien/icd10gm2021syst_kodes.txt > ${icdcodes}icd10gm2021.csv
#bash ../../utils/insert_into_db.sh $icdcodes $tb $tr
cd
echo "End!"
exit
