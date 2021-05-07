copy
(
select * from 
 (select * from copra.co6_medic_data_patient order by id asc limit 1000) as idasc
   union
select * from 
 (select * from copra.co6_medic_data_patient order by id desc limit 1000) as iddesc)
to '/media/db/cdw_database/patient_test.csv';
