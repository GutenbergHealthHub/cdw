-- Patient String Parameters
drop view if exists copra.patients_string_variables;
--create or replace view copra.patients_string_variables
--as
select 
 s.id,
  date_part('year', geb) geb,
  date_part('year', now()) - date_part('year', geb) "alter",
  geschlecht,
  patid,
  c.name param,
  val wert
from copra.co6_medic_data_patient p 
join copra.co6_data_string s 
  on s.parent_id = p.id
join copra.co6_config_variables c
  on c.id = s.varid 
where parent_varid = 1
and s.deleted = false
and val not like ''
;
