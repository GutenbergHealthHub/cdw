-- p21 2 Neo4j
create schema if not exists p21_neo;

-- patients
create materialized view p21_neo.patient as 
select distinct on (patientid) 
  'P'||md5(patientid) patientid, -- generated patientid 
  yearbirth, -- yearbirth (adults) 
  monthbirth, -- monthbirth (babies)
  floor(random()* (99999 - 10000 + 1) + 10000)::varchar zipcode, -- gerenated zipcode 
  gender
from p21.p21_encounter pe 
where id in (select encounterid from p21.p21_department pd) 
and id in (select encounterid from p21.p21_diagnosis pd2) 
and id in (select encounterid from p21.p21_operation po)
order by patientid;

--select * from p21_neo.patient;

/*copy (
  select 
    row_to_json(patient2neo4j) 
  from (
    select 
      * 
    from p21_neo.patient p 
  ) patient2neo4j) 
to '/home/abel/clinic_data_warehouse/p21patient.json';
*/

-- cases
select  
  'F'||md5("KH-internes-Kennzeichen") caseid,
  'P'||md5("Patientennummer") patientid, -- generated patientid 
  "Aufnahmedatum" , -- yearbirth (adults) 
  "Aufnahmeanlass" , -- monthbirth (babies)
  "Aufnahmegrund" , 
  "Aufnahmegewicht" ,
  "Entlassungsdatum" ,
  "Entlassungsgrund" 
from p21.fall pe 
where "KH-internes-Kennzeichen" in (select "KH-internes-Kennzeichen" from p21.p21_department pd) 
and "KH-internes-Kennzeichen" in (select "KH-internes-Kennzeichen" from p21.p21_diagnosis pd2) 
and "KH-internes-Kennzeichen" in (select "KH-internes-Kennzeichen" from p21.p21_operation po)
order by "Patientennummer" ;