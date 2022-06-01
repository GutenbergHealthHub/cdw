
if [[ $USER =~ abel ]]; then
  dircsv=/home/abel/git_repos/cdw/DIZ_Dachboard/csv_files
  dirtex=/home/abel/git_repos/cdw/DIZ_Dachboard/tex_files
else
  dbpass=`pass db/her11a_admin`
  db_user="her11a_admin"
  export PGPASSWORD=$dbpass
  dirpsql="/usr/local/pg14_2/bin/psql"
  proxy=5432
  dircsv=/media/db/cdw_database/git_repos/covid_test_app/csv_files
  dirtex=/media/db/cdw_database/git_repos/covid_test_app/tex_files
fi


echo "creating structure for reports by areas..."

exit
