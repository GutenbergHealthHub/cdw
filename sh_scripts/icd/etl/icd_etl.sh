# ETL for all icd from 2007 to 2021
#icdversions="/home/$USER/cdw/ICD/icd_versions/" # derectory with all information of icd
icdversions="/media/db/cdw_files/ICD/icd_versions/"
icdcodes="${icdversions}codes/" # directory with codes
dat=${icdcodes}icd10gm_versions.dat # releases
tb="icd_metainfo.kodes" # kode table in database
tr="tr_icd10gm_insert_from_bfarm"
ver='icd10gm[0-9]{4}'
#bash ../../utils/unziper.sh $icdversions # unzip icd files from bfarm
#bash ../../utils/copy_codes.sh $icdversions $ver # make a copy of the files with codes in another folder
#bash ../../utils/extra_info.sh $icdversions $dat # copy the release information in a file (version and date)
#bash ../../utils/iso_2_utf8.sh $icdcodes # transform files from iso format to utf 8 
#bash ../../utils/select_columns.sh $icdcodes # select columns to import in the database's table
#awk -v y="2021" -F ';' '{OFS = ";"}{print y, $0}' ${icdversions}icd10gm2021syst-meta-20201111/Klassifikationsdateien/icd10gm2021syst_kodes.txt > ${icdcodes}icd10gm2021.csv # insert version in current version file
#bash ../../utils/insert_into_db.sh $icdcodes $tb $tr # insert into the database
cd
echo "End!"
exit
