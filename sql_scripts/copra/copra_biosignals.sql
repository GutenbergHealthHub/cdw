-- Messungen Decimal
create or replace view copra.patient_decimal
as
select
  cmdp.id patsourceid,
  patid patdizid,
  d.uuid_id dizexternid,
  geschlecht,
  date_part('year', age(datetimeto, cmdp.geb)) "alter", 
  --cdd.varid,
  cb.displayname verfahren_messung,
  cdd.val wert,
  cb.unit,
  cdd.datetimeto zeitpunkt
from copra.co6_data_decimal_6_3 cdd 
join copra.co6_medic_data_patient cmdp 
  on cdd.parent_id = cmdp.id
join metadata_repository.copra_variables cb
  on cdd.varid = cb.varid 
join diz_intern.diziduuid d 
  on cmdp.patid = d.fall_pat_nummer 
where cdd.parent_varid = 1
  and cdd.deleted = false
  and cdd.flagcurrent = true
;

-- Messung String

create or replace view copra.patient_string
as
select
  cmdp.id patsourceid,
  patid patdizid,
  d.uuid_id dizexternid,
  geschlecht,
  date_part('year', age(datetimeto, cmdp.geb)) "alter", 
  --cdd.varid,
  cb.displayname verfahren_messung,
  cdd.val wert,
  unit,
  cdd.datetimeto zeitpunkt
from copra.co6_data_string cdd 
join copra.co6_medic_data_patient cmdp 
  on cdd.parent_id = cmdp.id
join metadata_repository.copra_variables cb
  on cdd.varid = cb.varid 
join diz_intern.diziduuid d 
  on cmdp.patid = d.fall_pat_nummer 
where cdd.parent_varid = 1
  and cdd.deleted = false
  and cdd.flagcurrent = true
  and cb.varid <> 5
  and cb.displayname !~'PACED|Dokumentation|angelegt'
;

-- Messung Object
create or replace view copra.patient_object
as
select
  p.id patsourceid,
  patid patdizid,
  d.uuid_id dizexternid,
  geschlecht,
  date_part('year', age(datetimeto, p.geb)) "alter",
--  s.varid,
  displayname verfahren_messung, 
  val wert,
  unit,
  datetimeto zeitpunkt
from copra.co6_data_string s
join copra.co6_data_object opu 
  on opu.varid = s.parent_varid 
  and opu.id = s.parent_id
join copra.co6_data_object opa 
  on opu.parent_varid = opa.varid 
  and opu.parent_id = opa.id
join copra.co6_medic_data_patient p 
  on p.id = opa.parent_id
join diz_intern.diziduuid d 
  on p.patid = d.fall_pat_nummer
join metadata_repository.copra_variables cb 
  on s.varid = cb.varid
where opa.parent_varid = 1
  and s.deleted = false 
  and s.flagcurrent = true
;

-- Messung Pressure
create or replace view copra.patient_pressure
as
select
  pa.id patsourceid,
  patid patdizid,
  d.uuid_id dizexternid,
  geschlecht,
  date_part('year', age(datetimeto, pa.geb)) "alter",
--  pr.varid,
  pr.systolic,
  pr.diastolic,
  pr.mean,
  cb.unit,
  displayname,
  datetimeto zeitpunkt
from copra.co6_medic_pressure pr
join  copra.co6_medic_data_patient pa 
  on pa.id = pr.parent_id 
join diz_intern.diziduuid d 
  on pa.patid = d.fall_pat_nummer
join metadata_repository.copra_variables cb 
  on pr.varid = cb.varid
where pr.deleted = false 
and pr.flagcurrent = true 
and pr.parent_varid = 1
;
