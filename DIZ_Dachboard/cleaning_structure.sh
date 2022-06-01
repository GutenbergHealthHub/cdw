if [[ $USER =~ abel ]]; then
  dircsv=/home/abel/git_repos/cdw/DIZ_Dachboard/csv_files
  dirtex=/home/abel/git_repos/cdw/DIZ_Dachboard/tex_files
else
  dirtex=/media/db/cdw_database/git_repos/cdw/pdf-tex_scripts/DIZ_Dachboard
fi

cd $dirtex
echo "cleanin..."
pwd
rm *.out *.log *.aux

cd
exit
