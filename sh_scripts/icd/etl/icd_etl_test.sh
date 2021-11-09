# ETL for all icd from 2007 to 2021
icdversions="/home/$USER/cdw/ICD/icd_versions/" # derectory with all information of icd
#icdversions="/media/db/cdw_files/ICD/icd_versions/"
icdcodes="${icdversions}codes/" # directory with codes
dat=${icdcodes}icd10gm_versions.dat # releases
tbrelease="icd_metainfo.icd10gm_release_info"
tbicd="icd_metainfo.kodes" # kode table in database

# triggers in kode
tr_kode_newicd="tr_insert_newicd10gm_into_icd10gm"
tr_kode_update="tr_update_icd10gm"
tr_kode_delete="tr_deleted_icd10gm_to_history"
tr_kode_reused="tr_insert_reused_icd10gm_to_history"

ver='icd10gm[0-9]{4}'
#bash ../../utils/unziper.sh $icdversions # unzip icd files from bfarm
#bash ../../utils/copy_codes.sh $icdversions $ver # make a copy of the files with codes in another folder
#bash ../../utils/extra_info.sh $icdversions $dat # copy the release information in a file (version and date)
#bash ../../utils/iso_2_utf8.sh $icdcodes # transform files from iso format to utf 8 
#bash ../../utils/select_columns.sh $icdcodes # select columns to import in the database's table
#awk -v y="2021" -F ';' '{OFS = ";"}{print y, $0}' ${icdversions}icd10gm2021syst-meta-20201111/Klassifikationsdateien/icd10gm2021syst_kodes.txt > ${icdcodes}icd10gm2021.csv # insert version in current version file
bash ../../utils/insert_into_db_test.sh $icdcodes $tbicd $dat $tbrelease $tr_kode_newicd $tr_kode_update $tr_kode_delete $tr_kode_reused # insert into the database
cd
echo "End!"
exit
