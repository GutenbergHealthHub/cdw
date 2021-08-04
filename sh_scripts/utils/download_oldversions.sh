# Download zip file of old versions
#cd /media/db/cdw_files/ICD/icd_versions
#cd /home/$USER/cdw/ICD/icd_versions/
cd /home/$USER/test/
cla=$1 # icd or ops
tilyear=`date -d "last year" +%Y`
for z in $( seq 2007 $tilyear); do
  [[ $cla=="icd" ]] &&  wget https://www.dimdi.de/dynamic/.downloads/klassifikationen/icd-10-gm/vorgaenger/icd10gm${z}.zip
                           #  https://www.dimdi.de/dynamic/.downloads/klassifikationen/icd-10-gm/vorgaenger/icd10gm2014.zip
done
cd
exit

