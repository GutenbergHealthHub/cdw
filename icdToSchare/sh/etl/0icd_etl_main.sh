# ETL for all icd from 2007 to 2021
icdversions="/home/$USER/cdw/ICD/" # derectory with all information of icd
icdcodes="${icdversions}codes/" # directory with codes
dat=${icdcodes}icd10gm_versions.dat # releases
tbrelease="icd10gm_release_info"
tbicd="kodes" # kode table in database
sch="icd_metainfo."

# triggers in kode
tr_kode_newicd="tr_insert_newicd10gm_into_icd10gm"
tr_kode_update="tr_update_icd10gm"
tr_kode_delete="tr_deleted_icd10gm_to_history"
tr_kode_reused="tr_insert_reused_icd10gm_to_history"

# current metadata
currentICD=`date +"icd10gm%Y"`

ver='icd10gm[0-9]{4}'
bash 1unziper.sh $icdversions # unzip icd files from bfarm
bash 2copy_codes.sh $icdversions $ver # make a copy of the files with codes in another folder
bash 3extra_info.sh $icdversions $dat # copy the release information in a file (version and date)
bash 4iso_2_utf8.sh $icdcodes # transform files from iso format to utf 8 
bash 5select_columns.sh $icdcodes # select columns to import in the database's table
bash 6insert_into_db_test.sh $icdcodes $tbicd $dat $tbrelease $tr_kode_newicd $tr_kode_update $tr_kode_delete $tr_kode_reused $currentICD $sch # insert into the database
cd
echo "End!"
exit
