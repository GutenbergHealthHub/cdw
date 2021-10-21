-- p21 2 Neo4j
create schema p21_neo;

drop view p21_neo.patient;

create materialized view p21_neo.patient as 
select distinct on (patientid) 
  'P'||md5(patientid) patientid, 
  yearbirth, monthbirth, 
  floor(random()* (99999 - 10000 + 1) + 10000)::varchar zipcode,
  gender
from p21.p21_encounter pe 
where id in (select encounterid from p21.p21_department pd) 
and id in (select encounterid from p21.p21_diagnosis pd2) 
and id in (select encounterid from p21.p21_operation po)
order by patientid;

select * from p21_neo.patient;