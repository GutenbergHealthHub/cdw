create or replace view diz_intern.dachboard_general
as
select count(*) "Anzahl", 'Patienten' "Tabelle" from kis."NPAT" p
  union 
select count(*), 'Fälle' from kis."NFAL" f
  union
select count(*), 'Prozedure' from kis."NICP" pr
  union
select count(*), 'Diagnosen' from kis."NDIA" d
  union
select count(*), 'Einwiligungen' from kis."/HSROM/NV_PERIOD" np
  union
select count(*), 'Personen' from kis."NPER" pe
  union 
select count(*), 'Bewegungen' from kis."NBEW" be
  union
select count(*), 'Bauliche Einheiten' from kis."NBAU" bau
  union
select count(*), 'Organisatorische Einheiten' from kis."NORG" o 
order by "Anzahl"
;

create or replace view diz_intern.dachboard_patient
as
select 
  count("PATNR") "Anzahl", 
  "GSCHL",
  g.gender "Geschlecht"
from kis."NPAT" n
left join metadata_repository.gender g 
  on n."GSCHL" = g.sourceid 
where g."source" = 'kis' or g."source" isnull
group by "GSCHL", g.gender;

create or replace view diz_intern.dachboard_cases
as
select count(*) "Anzahl", 
"BEKAT",
"FALAR",
t.bltxt "Fall Art"
from kis."NFAL" n 
left join metadata_repository.tn24 t 
  on "FALAR" = t.falar::varchar 
  and "BEKAT" = t.bekat
group by "FALAR", "BEKAT", t.bltxt
order by "Anzahl" desc;
