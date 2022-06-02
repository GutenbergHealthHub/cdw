drop view diz_intern.dashboard_general;
create or replace view diz_intern.dashboard_general
as
select count("PATNR") "Anzahl", 'Patienten' "Tabelle" from kis."NPAT" p
  union 
select count("FALNR"), 'Fälle' from kis."NFAL" f
  union
select count(distinct "LNRIC"), 'Prozeduren' from kis."NICP" pr
  union
select count(distinct ("FALNR", "LFDNR")), 'Diagnosen' from kis."NDIA" d
  union
select count(distinct ("FALNR", "PATNR", "FNAME", "LFDNR")), 'Einwilligungen' from kis."/HSROM/NV_PERIOD" np
  union
select count("PERNR"), 'Personen' from kis."NPER" pe
  union 
select count(distinct ("FALNR", "LFDNR")), 'Bewegungen' from kis."NBEW" be
  union
select count("BAUID"), 'Bauliche Einheiten' from kis."NBAU" bau
  union
select count("ORGID"), 'Organisatorische Einheiten' from kis."NORG" o 
order by "Anzahl"
;

drop view diz_intern.dashboard_patient;
create or replace view diz_intern.dashboard_patient
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

drop view diz_intern.dashboard_cases_details;
create or replace view diz_intern.dashboard_cases_details
as
select count(*) "Anzahl", 
case
	when "BEKAT" !~'^\w' then null
	else "BEKAT"
end "BEKAT",
"FALAR",
t.bltxt "Fall Art"
from kis."NFAL" n 
left join metadata_repository.tn24 t 
  on "FALAR" = t.falar::varchar 
  and "BEKAT" = t.bekat
group by "FALAR", "BEKAT", t.bltxt
order by "Anzahl" desc;

create or replace view diz_intern.dashboard_cases
as
select count(*) "Anzahl", 
"FALAR",
f.falar "Fall Art"
from kis."NFAL" n 
left join metadata_repository.falar f  
  on "FALAR" = f.sourceid 
group by "FALAR", f.falar
order by "Anzahl" desc;


create or replace view diz_intern.dashboard_cases_by_years
as
select count("FALNR") "Fälle", y "Jahr" 
from (
select 
  f."FALNR",
  extract (year from min(b."BWIDT")) y
from kis."NFAL" f 
join kis."NBEW" b
  on f."FALNR" = b."FALNR" 
group by f."FALNR"
) as t
group by y 
order by "Jahr"
;


create or replace view diz_intern.dashboard_diagnosis_by_years
as
select 
  count(distinct ("FALNR", "LFDNR")) "Anzahl",
  date_part('year', "DIADT") "Jahr"
from kis."NDIA" n 
group by "Jahr"
order by "Jahr"
;


