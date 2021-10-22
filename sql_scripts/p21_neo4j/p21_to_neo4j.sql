-- p21 2 Neo4j
create schema if not exists p21_neo;

-- patients
--create materialized view p21_neo.patient as 
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
to '/home/abel/clinic_data_warehouse/patient.cypher';
*/

-- cause of admission
select id admissioncauseid, admissioncause from metadata_repository.p21_admission_cause pac;

/*copy (
  select 
    row_to_json(admissioncause2neo4j)
  from (
    select 
      id admissioncauseid, 
      admissioncause 
    from metadata_repository.p21_admission_cause
  ) admissioncause2neo4j
)
to '/home/abel/neo4j/admissioncause.cypher';
*/

-- reason of admission
select id admissionreasonid, position_1_2||'; '||position_3||'; '||position_4 admissionreason from metadata_repository.p21_admission_reason par ;

/*copy (
  select 
    row_to_json(admissionreason2neo4j)
  from (
    select 
      id admissionreasonid, 
      position_1_2||'; '||position_3||'; '||position_4 admissionreason
    from metadata_repository.p21_admission_reason par 
  ) admissionreason2neo4j
)
to '/home/abel/neo4j/admissionreason.cypher';
*/

-- department
select id departmentid, departmenttype, department from metadata_repository.p21_department pd;

/*copy (
  select 
    row_to_json(department2neo4j)
  from (
    select 
      id departmentid, 
      departmenttype, 
      department
    from metadata_repository.p21_department pd
  ) department2neo4j
)
to '/home/abel/neo4j/department.cypher';
*/

-- reason of discharge
select id dischargeid, position12 || '; '|| position3 discharge from metadata_repository.p21_remission_reason prr ;

/*copy (
  select 
    row_to_json(dischargereason2neo4j)
  from (
    select 
      id dischargereasonid, 
      position12 || '; '|| position3 dischargereason
    from metadata_repository.p21_remission_reason prr 
  ) dischargereason2neo4j
)
to '/home/abel/neo4j/dischargereason.cypher';
*/

-- cases

select 
  distinct 
  'F'||md5(pe.id) caseid,
  pe.admissiondate,
  pe.dischargedate
from p21.p21_encounter pe 
join p21.p21_department pd 
  on pe.id = pd.encounterid 
join p21.p21_operation po 
  on pd.encounterid = po.encounterid 
join p21.p21_diagnosis pdi
  on pdi.encounterid = pd.encounterid;

/*
copy (
  select 
    row_to_json(case2neo4j)
  from (
    select distinct
      'F'||md5(pe.id) caseid,
      pe.admissiondate,
      pe.dischargedate
    from p21.p21_encounter pe 
    join p21.p21_department pd 
      on pe.id = pd.encounterid 
    join p21.p21_operation po 
      on pd.encounterid = po.encounterid 
    join p21.p21_diagnosis pdi
      on pdi.encounterid = pd.encounterid 
  ) case2neo4j
)
to '/home/abel/neo4j/case.cypher';
*/

 
-- diagnosis

select 
  code,
  normcode,
  codeohnepunkt, 
  titel,
  p295,
  p301 
from icd_metainfo.icd10gm ig;

copy (
  select 
    row_to_json(diagnosis2neo4j)
  from (
    select 
      code,
      normcode,
      codeohnepunkt, 
      titel,
      p295,
      p301 
    from icd_metainfo.icd10gm ig  
  ) diagnosis2neo4j
)
to '/home/abel/neo4j/diagnosis.cypher';

select  
  'F'||md5("KH-internes-Kennzeichen") caseid,
  --'P'||md5("Patientennummer") patientid, -- generated patientid 
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

