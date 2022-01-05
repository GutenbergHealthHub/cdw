--DQA for kis.nfal

-- Null values in nfal.
--drop view if exists kis.dqa_nfal_null_values;
create or replace view kis.dqa_nfal_null_values
as
  select 
    count(falnr) quantity, 
    'einri' "columns"
  from kis.nfal n 
  where einri isnull or einri !~'^\w'
    union 
  select 
    count(falnr),
    'falnr'
  from kis.nfal
  where falnr isnull or falnr !~'^\w'
    union 
    select 
    count(falnr),
    'falar'
  from kis.nfal
  where falar isnull or falar !~'^\d'
    union 
  select 
    count(falnr),
    'patnr'
  from kis.nfal
  where patnr isnull or patnr !~'^\w'
    union 
  select
    count(falnr),
    'bekat'
  from kis.nfal
  where bekat isnull or bekat !~'^\w'
    union 
  select 
    count(falnr),
    'abrkz' 
  from kis.nfal
  where abrkz isnull or abrkz !~'^\d'
    union 
  select 
    count(falnr),
    'sichv' 
  from kis.nfal
  where sichv isnull
    union 
  select 
    count(falnr),
    'statu' 
  from kis.nfal
  where statu isnull or statu !~'^\w'
    union 
  select 
    count(falnr),
    'notan'
  from kis.nfal
  where notan isnull
    union 
   select 
    count(falnr),
    'krzan'
  from kis.nfal
  where krzan isnull
    union 
  select 
    count(falnr),
    'endat' 
  from kis.nfal
  where endat isnull
    union 
  select 
    count(falnr),
    'fgtyp'
  from kis.nfal
  where fgtyp isnull or fgtyp !~'^\w'
    union 
  select 
    count(falnr),
    'kzkom'
  from kis.nfal
  where kzkom isnull
    union 
  select 
    count(falnr),
    'enddt'
  from kis.nfal
  where enddt isnull
    union 
  select 
    count(falnr),
    'erdat'
  from kis.nfal
  where erdat isnull 
    union 
  select 
    count(falnr),
    'updat'
  from kis.nfal
  where updat isnull
    union 
  select 
    count(falnr),
    'storn'
  from kis.nfal
  where storn isnull
    union 
  select 
    count(falnr),
    'stdat'
  from kis.nfal
  where stdat isnull
    union 
  select 
    count(falnr),
    'begdt'
  from kis.nfal
  where begdt isnull
    union 
  select 
    count(falnr),
    'fatyp'
  from kis.nfal
  where fatyp isnull or fatyp !~'^\w'
    union
  select 
    count(falnr),
    'fachr'
  from kis.nfal
  where fachr isnull or fachr !~'^\w'
    union
  select 
    count(falnr),
    'endtyp'
  from kis.nfal
  where endtyp isnull or endtyp !~'^\w'
    union
  select 
    count(falnr),
    'patw'
  from kis.nfal
  where patw isnull
    union 
  select 
    count(falnr),
    'patgew'
  from kis.nfal
  where patgew isnull
    union
  select 
    count(falnr),
    'gwein'
  from kis.nfal
  where gwein isnull or gwein !~'^\w'
    union 
  select 
    count(falnr),
    'patgro'
  from kis.nfal
  where patgro isnull
   union 
  select 
    count(falnr),
    'grein'
  from kis.nfal
  where grein isnull or grein !~'^\w'
   union 
  select 
    count(falnr),
    'resp'
  from kis.nfal
  where resp isnull
    union 
  select 
    count(falnr),
    'delgw'
  from kis.nfal
  where delgw isnull
    union 
  select 
    count(falnr),
    'saps_c'
  from kis.nfal
  where saps_c isnull
    union 
  select 
    count(falnr),
    'pim2_c'
  from kis.nfal
  where pim2_c isnull
    union 
  select 
    count(falnr),
    'crib_c'
  from kis.nfal
  where crib_c isnull
    union 
  select
    count(falnr),
    'saps_imc'
  from kis.nfal n
  where saps_imc isnull 
    union
  select 
    count(falnr),
    'pim2_imc'
  from kis.nfal
  where pim2_imc isnull
    union 
  select 
    count(falnr),
    'crib_imc'
  from kis.nfal
  where crib_imc isnull
    union 
  select 
    count(falnr),
    'respi_imc'
  from kis.nfal
  where respi_imc isnull
    union 
  select 
    count(falnr),
    'readm'
  from kis.nfal n
  where readm isnull 
  order by quantity, "columns"
; 

------------------------------------------
-- Einrichtung
--drop view if exists kis.dqa_nfal_einri;
create or replace view kis.dqa_nfal_einri
as
select 
  count(falnr) quantity, 
  case 
    when n.einri ~'^\w' then n.einri 
    else null
  end einri
from kis.nfal n
left join metadata_repository.einrichtung e
  on n.einri = e.sourceid 
group by n.einri 
order by quantity desc
;

create or replace view kis.dqa_nfal_einri_jahr
as
select 
  case 
    when erdat isnull then date_part('year', updat)
    else date_part('year', erdat)
  end jahr, 
  count(falnr) quantity, 
  case 
    when n.einri ~'^\w' then n.einri 
    else null
  end einri 
from kis.nfal n
left join metadata_repository.einrichtung e
  on n.einri = e.sourceid 
group by n.einri, jahr 
order by jahr, quantity desc
;

-- Fallart
--drop view if exists kis.dqa_nfal_falar;
create or replace view kis.dqa_nfal_falar
as
select 
  count(falnr) quantity, 
  case 
    when falar ~'^\d' then falar
    else null 
  end falar
from kis.nfal n
group by n.falar 
order by quantity desc
;

--drop view if exists kis.dqa_nfal_falar_jahr;
create or replace view kis.dqa_nfal_falar_jahr
as
select 
  case 
    when erdat isnull then date_part('year', updat)
    else date_part('year', erdat)
  end jahr, 
  count(falnr) quantity, 
  case 
    when falar ~'^\d' then falar
    else null 
  end falar
from kis.nfal n
group by n.falar, jahr 
order by jahr, quantity desc
;

-- Patientennummer
--drop view if exists kis.dqa_nfal_patnr;
create or replace view kis.dqa_nfal_patnr
as
select 
  count(falnr) quantity, 
  case 
    when patnr ~'^\w' then patnr 
    else null
  end patnr 
from kis.nfal n
group by patnr 
order by quantity desc
;

create or replace view kis.dqa_nfal_patnr_jahr
as
select 
  case 
    when erdat isnull then date_part('year', updat)
    else date_part('year', erdat)
  end jahr, 
  count(falnr) quantity, 
  case 
    when patnr ~'^\w' then patnr 
    else null
  end patnr 
from kis.nfal n
group by patnr, jahr 
order by jahr, quantity desc
;

-- Behandlungskategorie
--drop view if exists kis.dqa_nfal_bekat;
create or replace view kis.dqa_nfal_bekat
as
select 
  count(falnr) quantity, 
  case 
    when bekat ~'^\w' then bekat 
    else null
  end bkat,
  b.behandlungskategorie
from kis.nfal n
left join metadata_repository.behandlungskategorie b 
  on n.bekat = b.sourceid
group by n.bekat, b.behandlungskategorie
order by quantity desc
;

create or replace view kis.dqa_nfal_bekat_jahr
as
select 
  case 
    when erdat isnull then date_part('year', updat)
    else date_part('year', erdat)
  end jahr,
  count(falnr) quantity, 
  case 
    when bekat ~'^\w' then bekat 
    else null
  end bkat,
  b.behandlungskategorie
from kis.nfal n
left join metadata_repository.behandlungskategorie b 
  on n.bekat = b.sourceid
group by n.bekat, b.behandlungskategorie, jahr 
order by jahr, quantity desc
;
---------------------------------------------------------------
-- Todesuhrzeit von
--drop view if exists kis.dqa_nfal_todzt;
create or replace view kis.dqa_nfal_todzt
as
select 
  count(falnr) quantity, 
  todzt 
from kis.nfal n 
group by n.todzt 
order by quantity desc
;

create or replace view kis.dqa_nfal_todzt_jahr
as
select 
  date_part('year', erdat) jahr,
  count(falnr) quantity, 
  todzt 
from kis.nfal n 
group by jahr, n.todzt 
order by jahr, quantity desc
;

-- Todesdatum bis
--drop view if exists kis.dqa_nfal_toddb;
create or replace view kis.dqa_nfal_toddb
as
select 
  count(falnr) quantity, 
  toddb 
from kis.nfal n 
group by n.toddb 
order by quantity desc
;

create or replace view kis.dqa_nfal_toddb_jahr
as
select 
  date_part('year', erdat) jahr,
  count(falnr) quantity, 
  toddb 
from kis.nfal n 
group by jahr, n.toddb 
order by jahr, quantity desc
;

-- Todesuhrzeit bis
--drop view if exists kis.dqa_nfal_todzb;
create or replace view kis.dqa_nfal_todzb
as
select 
  count(falnr) quantity, 
  todzb 
from kis.nfal n 
group by n.todzb 
order by quantity desc
;

create or replace view kis.dqa_nfal_todzb_jahr
as
select
  date_part('year', erdat) jahr,
  count(falnr) quantity, 
  todzb 
from kis.nfal n 
group by jahr, n.todzb 
order by jahr, quantity desc
;

-- Todesursache
--drop view if exists kis.dqa_nfal_todur;
create or replace view kis.dqa_nfal_todur
as
select 
  count(falnr) quantity, 
  case 
    when n.todur ~'^\w' then n.todur 
    else null
  end todur,
  d.deathcause 
from kis.nfal n
left join metadata_repository.deathcause d 
  on n.todur = d.sourceid 
group by n.todur, d.deathcause 
order by quantity desc
;

create or replace view kis.dqa_nfal_todur_jahr
as
select
  date_part('year', erdat) jahr,
  count(falnr) quantity, 
  case 
    when n.todur ~'^\w' then n.todur 
    else null
  end todur,
  d.deathcause 
from kis.nfal n
left join metadata_repository.deathcause d 
  on n.todur = d.sourceid 
group by jahr, n.todur, d.deathcause 
order by jahr, quantity desc
;

-- Land des Patientewohnortes
create or replace view kis.dqa_nfal_land
as
select 
  count(falnr) quantity, 
  case 
    when n.land ~'^\w' then n.land
    else null
  end land, 
  c.country
from kis.nfal n
left join metadata_repository.country c 
  on n.land = c.sourceid 
group by n.land, c.country 
order by quantity desc
;

create or replace view kis.dqa_nfal_land_jahr
as
select
  date_part('year', erdat) jahr,
  count(falnr) quantity, 
  case 
    when n.land ~'^\w' then n.land
    else null
  end land, 
  c.country
from kis.nfal n
left join metadata_repository.country c 
  on n.land = c.sourceid 
group by jahr, n.land, c.country 
order by jahr, quantity desc
;

-- Postleitzahl Patient
--drop view if exists kis.dqa_nfal_pstlz;
create or replace view kis.dqa_nfal_pstlz
as
select 
  count(falnr) quantity, 
  case 
    when n.pstlz ~'^\w' then n.pstlz 
    else null
  end pstlz,
  z.land bundesland
from kis.nfal n
left join metadata_repository.zipcode z
  on n.pstlz = z.zipcode
group by pstlz, bundesland
order by quantity desc
;

create or replace view kis.dqa_nfal_pstlz_jahr
as
select
  date_part('year', erdat) jahr,
  count(falnr) quantity, 
  case 
    when n.pstlz ~'^\w' then n.pstlz 
    else null
  end pstlz,
  z.land bundesland
from kis.nfal n
left join metadata_repository.zipcode z
  on n.pstlz = z.zipcode
group by jahr, pstlz, bundesland
order by jahr, quantity desc
;

-- Datum, an dem der Datensatz erstellt wurde
--drop view if exists kis.dqa_nfal_erdat;
create or replace view kis.dqa_nfal_erdat
as
select
  count(falnr) quantity, 
  erdat 
from kis.nfal n
group by erdat 
order by quantity desc
;

create or replace view kis.dqa_nfal_jahr
as
select
  date_part('year', erdat) jahr,
  count(falnr) quantity  
from kis.nfal n
group by jahr
order by jahr, quantity desc
;

create or replace view kis.dqa_nfal_erdat_jahr
as
select
  date_part('year', erdat) jahr,
  count(falnr) quantity, 
  erdat 
from kis.nfal n
group by jahr, erdat 
order by jahr, quantity desc
;


-- Änderungsdatum
--drop view if exists kis.dqa_nfal_updat;
create or replace view kis.dqa_nfal_updat
as
select
  count(falnr) quantity, 
  updat 
from kis.nfal n
group by updat 
order by quantity desc
;

create or replace view kis.dqa_nfal_updat_jahr
as
select
  date_part('year', erdat) jahr,
  count(falnr) quantity, 
  updat 
from kis.nfal n
group by jahr, updat 
order by jahr, quantity desc
;

-- Stornokennzeichen
--drop view if exists kis.dqa_nfal_storn;
create or replace view kis.dqa_nfal_storn
as
select
  count(falnr) quantity, 
  storn 
from kis.nfal n
group by storn 
order by quantity desc
;

create or replace view kis.dqa_nfal_storn_jahr
as
select
  date_part('year', erdat) jahr,
  count(falnr) quantity, 
  storn 
from kis.nfal n
group by jahr, storn 
order by jahr, quantity desc
;

-- Stornierungsdatum
-- drop view if exists kis.dqa_nfal_stdat
create or replace view kis.dqa_nfal_stdat
as
select 
  count(falnr) quantity, 
  stdat 
from kis.nfal n 
group by n.stdat 
order by quantity desc
;

create or replace view kis.dqa_nfal_stdat_jahr
as
select 
  date_part('year', erdat) jahr,
  count(falnr) quantity, 
  stdat 
from kis.nfal n 
group by jahr, n.stdat 
order by jahr, quantity desc
;

-- Ethnische Gruppe
-- drop view if exists kis.dqa_nfal_race;
create or replace view kis.dqa_nfal_race
as
select
  count(falnr) quantity, 
  case 
    when n.race ~'^\w' then n.race 
    else null
  end race
from kis.nfal n
group by race 
order by quantity desc
;

create or replace view kis.dqa_nfal_race_jahr
as
select
  date_part('year', erdat) jahr,
  count(falnr) quantity, 
  case 
    when n.race ~'^\w' then n.race 
    else null
  end race
from kis.nfal n
group by jahr, race 
order by jahr, quantity desc
;
/*
*/
