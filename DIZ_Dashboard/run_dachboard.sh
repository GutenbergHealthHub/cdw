#!/bin/bash

if [[ $USER =~ abel ]]; then
  # sh-files
  sh_files=/home/abel/git_repos/covid_test_app/sh_scripts
  # cd /home/abel/git_repos/covid_test_app/sh_scripts
else
  # sh-files
  sh_files=/media/db/cdw_database/git_repos/covid_test_app/sh_scripts
  # cd /media/db/cdw_database/git_repos/covid_test_app/sh_scripts
fi

echo "clinics_calender_weeks_x_y.sh..."
bash $sh_files/clinics_calender_weeks_x_y.sh
bash $sh_files/clinics_calender_weeks_x_y_by_percent.sh

echo "persons_with_uploaded_certificate.sh..."
bash $sh_files/persons_with_uploaded_certificate.sh 

echo "persons_with_valide_certificate.sh..."
bash $sh_files/persons_with_valide_certificate.sh 

echo "persons_without_valide_certificate.sh..."
bash $sh_files/persons_without_valide_certificate.sh

echo "calendar_weeks_x_y_resume.sh..."
bash $sh_files/calendar_weeks_x_y_resume.sh 

echo "months_x_y_resume.sh..."
bash $sh_files/months_x_y_resume.sh 

# echo "clinics_with_more_than_3_persons_with_uploaded_certificate.sh..."
# bash $sh_files/clinics_with_more_than_3_persons_with_uploaded_certificate.sh 

echo "clinics_with_more_than_3_persons_with_valide_certificate.sh..."
bash $sh_files/clinics_with_more_than_3_persons_with_valide_certificate.sh

echo "quantity_persons_and_frequency_using_apps.sh..."
bash $sh_files/quantity_persons_and_frequency_using_apps.sh 

echo "quantity_persons_with_valide_certificate_by_areas.sh..."
bash $sh_files/quantity_persons_with_valide_certificate_by_areas.sh


echo "quantity_persons_without_valide_certificate_by_areas.sh..."
bash $sh_files/quantity_persons_without_valide_certificate_by_areas.sh

current_month=`date +%-m`
# current_month=$(($current_month+0))

for realized_tests in 2 4 
do
  echo "quantity_persons_with_less_than_x_tests_by_areas_in_month.sh $realized_tests $current_month..."
  bash $sh_files/quantity_persons_with_less_than_x_tests_by_areas_in_month.sh $realized_tests $current_month 
done

current_cw=`date +%-U`
# current_cw=$(($current_cw+0))

echo "clinics_current_calender_week.sh $current_cw..."
bash $sh_files/clinics_current_calender_week.sh $current_cw

echo "clinics_current_calender_week_by_percent.sh $weeks..."
bash $sh_files/clinics_current_calender_week_by_percent.sh $current_cw

echo "init_areas_reports_current.sh..."
bash $sh_files/init_areas_reports_current.sh

echo "The reports by areas can take a while..."

echo "report_by_areas_persons_with_valide_certificate_current.sh..."
bash $sh_files/report_by_areas_persons_valide_certificate_current.sh


echo "report_by_areas_persons_without_valide_certificate_current.sh..."
bash $sh_files/report_by_areas_persons_without_valide_certificate_current.sh

echo "cleaning_areas_reports_current..."
bash $sh_files/cleaning_areas_reports_current.sh

cd
exit

