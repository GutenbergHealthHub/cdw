--DQA for kis.npat

-- Null values in npat.
--drop view if exists kis.dqa_npat_null_values;
create or replace view kis.dqa_npat_null_values
as
  select 
    count(patnr) quantity, 
    'einri' "columns"
  from kis.npat n 
  where einri isnull or einri !~'^\w'
    union 
  select 
    count(patnr),
    'patnr'
  from kis.npat
  where patnr isnull or patnr !~'^\w'
    union 
    select 
    count(patnr),
    'gschl'
  from kis.npat
  where gschl isnull or gschl !~'\d'
    union 
  select 
    count(patnr),
    'gbdat'
  from kis.npat
  where gbdat isnull
    union 
  select
    count(patnr),
    'todkz'
  from kis.npat
  where todkz isnull
    union 
  select 
    count(patnr),
    'toddt' 
  from kis.npat
  where toddt isnull
    union 
  select 
    count(patnr),
    'todzt' 
  from kis.npat
  where todzt isnull
    union 
  select 
    count(patnr),
    'toddb' 
  from kis.npat
  where toddb isnull
    union 
  select 
    count(patnr),
    'todzb'
  from kis.npat
  where todzb isnull
    union 
   select 
    count(patnr),
    'todur'
  from kis.npat
  where todur isnull or todur !~ '^\w'
    union 
  select 
    count(patnr),
    'land' 
  from kis.npat
  where land isnull or land !~'^\w'
    union 
  select 
    count(patnr),
    'pstlz'
  from kis.npat
  where pstlz isnull or pstlz !~'^\w'
    union 
  select 
    count(patnr),
    'erdat'
  from kis.npat
  where erdat isnull
    union 
  select 
    count(patnr),
    'updat'
  from kis.npat
  where updat isnull
    union 
  select 
    count(patnr),
    'storn'
  from kis.npat
  where storn isnull 
    union 
  select 
    count(patnr),
    'stdat'
  from kis.npat
  where stdat isnull
    union 
  select 
    count(patnr),
    'race'
  from kis.npat
  where race isnull or race !~'^\w'
  order by quantity, "columns"
; 


-- Geschlecht
--drop view if exists kis.dqa_npat_gschl;
create or replace view kis.dqa_npat_gschl
as
select 
  count(patnr) quantity, 
  case 
    when n.gschl ~'^\w' then n.gschl 
    else null
  end gschl,
  g.gender 
from kis.npat n
left join metadata_repository.gender g
  on n.gschl = g.sourceid 
group by n.gschl, gender 
order by quantity desc
;

-- Geburtsdatum
--drop view if exists kis.dqa_npat_gbdat;
create or replace view kis.dqa_npat_gbdat
as
select 
  count(patnr) quantity, 
  gbdat
from kis.npat n
group by n.gbdat 
order by quantity desc
;

-- Kennzeichen Patient verstorben
--drop view if exists kis.dqa_npat_todkz;
create or replace view kis.dqa_npat_todkz
as
select 
  count(patnr) quantity, 
  todkz
from kis.npat n
group by todkz 
order by quantity desc
;

-- Todesdatum von
--drop view if exists kis.dqa_npat_toddt;
create or replace view kis.dqa_npat_toddt
as
select 
  count(patnr) quantity, 
  toddt 
from kis.npat n 
group by n.toddt 
order by quantity desc
;

-- Todesuhrzeit von
--drop view if exists kis.dqa_npat_todzt;
create or replace view kis.dqa_npat_todzt
as
select 
  count(patnr) quantity, 
  todzt 
from kis.npat n 
group by n.todzt 
order by quantity desc
;

-- Todesdatum bis
--drop view if exists kis.dqa_npat_toddb;
create or replace view kis.dqa_npat_toddb
as
select 
  count(patnr) quantity, 
  toddb 
from kis.npat n 
group by n.toddb 
order by quantity desc
;

-- Todesuhrzeit bis
--drop view if exists kis.dqa_npat_todzb;
create or replace view kis.dqa_npat_todzb
as
select 
  count(patnr) quantity, 
  todzb 
from kis.npat n 
group by n.todzb 
order by quantity desc
;

-- Todesursache
--drop view if exists kis.dqa_npat_todur;
create or replace view kis.dqa_npat_todur
as
select 
  count(patnr) quantity, 
  case 
    when n.todur ~'^\w' then n.todur 
    else null
  end todur,
  d.deathcause 
from kis.npat n
left join metadata_repository.deathcause d 
  on n.todur = d.sourceid 
group by n.todur, d.deathcause 
order by quantity desc
;

-- Land des Patientewohnortes
create or replace view kis.dqa_npat_land
as
select 
  count(patnr) quantity, 
  case 
    when n.land ~'^\w' then n.land
    else null
  end land, 
  c.country
from kis.npat n
left join metadata_repository.country c 
  on n.land = c.sourceid 
group by n.land, c.country 
order by quantity desc
;

-- Postleitzahl Patient
--drop view if exists kis.dqa_npat_pstlz;
create or replace view kis.dqa_npat_pstlz
as
select 
  count(patnr) quantity, 
  case 
    when n.pstlz ~'^\w' then n.pstlz 
    else null
  end pstlz,
  z.land bundesland
from kis.npat n
left join metadata_repository.zipcode z
  on n.pstlz = z.zipcode
group by pstlz, bundesland
order by quantity desc
;

-- Datum, an dem der Datensatz erstellt wurde
--drop view if exists kis.dqa_npat_erdat;
create or replace view kis.dqa_npat_erdat
as
select
  count(patnr) quantity, 
  erdat 
from kis.npat n
group by erdat 
order by quantity desc
;

-- Änderungsdatum
--drop view if exists kis.dqa_npat_updat;
create or replace view kis.dqa_npat_updat
as
select
  count(patnr) quantity, 
  updat 
from kis.npat n
group by updat 
order by quantity desc
;

-- Stornokennzeichen
--drop view if exists kis.dqa_npat_storn;
create or replace view kis.dqa_npat_storn
as
select
  count(patnr) quantity, 
  storn 
from kis.npat n
group by storn 
order by quantity desc
;

-- Stornierungsdatum
-- drop view if exists kis.dqa_npat_stdat
create or replace view kis.dqa_npat_stdat
as
select 
  count(patnr) quantity, 
  stdat 
from kis.npat n 
group by n.stdat 
order by quantity desc
;

-- Ethnische Gruppe
-- drop view if exists kis.dqa_npat_race;
create or replace view kis.dqa_npat_race
as
select
  count(patnr) quantity, 
  case 
    when n.race ~'^\w' then n.race 
    else null
  end race
from kis.npat n
group by race 
order by quantity desc
;
/*
*/
