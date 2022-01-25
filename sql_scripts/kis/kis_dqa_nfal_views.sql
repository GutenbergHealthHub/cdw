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

-- Abrechnungskennzeichen
--drop view if exists kis.dqa_nfal_abrkz;
create or replace view kis.dqa_nfal_abrkz
as
select 
  count(falnr) quantity, 
  case 
    when abrkz ~'^\w' then abrkz 
    else null
  end abrkz 
from kis.nfal n 
group by n.abrkz 
order by quantity desc
;

create or replace view kis.dqa_nfal_abrkz_jahr
as
select 
  case 
    when erdat isnull then date_part('year', updat)
    else date_part('year', erdat)
  end jahr,
  count(falnr) quantity, 
  case 
    when abrkz ~'^\w' then abrkz 
    else null
  end abrkz 
from kis.nfal n 
group by jahr, n.abrkz 
order by jahr, quantity desc
;

-- Kennzeichen für Sicherheitsverwahrung
--drop view if exists kis.dqa_nfal_sichv;
create or replace view kis.dqa_nfal_sichv
as
select 
  count(falnr) quantity, 
  sichv 
from kis.nfal n 
group by n.sichv 
order by quantity desc
;

create or replace view kis.dqa_nfal_sichv_jahr
as
select 
  case 
    when erdat isnull then date_part('year', updat)
    else date_part('year', erdat)
  end jahr,
  count(falnr) quantity, 
  sichv 
from kis.nfal n 
group by jahr, n.sichv 
order by jahr, quantity desc
;

-- Fallstatus
--drop view if exists kis.dqa_nfal_statu;
create or replace view kis.dqa_nfal_statu
as
select 
  count(falnr) quantity, 
  case 
    when statu ~'^\w' then statu 
    else null
  end statu 
from kis.nfal n 
group by n.statu 
order by quantity desc
;

create or replace view kis.dqa_nfal_statu_jahr
as
select
  case 
    when erdat isnull then date_part('year', updat)
    else date_part('year', erdat)
  end jahr,
  count(falnr) quantity, 
  case 
    when statu ~'^\w' then statu 
    else null
  end statu 
from kis.nfal n 
group by jahr, n.statu 
order by jahr, quantity desc
;

-- Notaufnahmekennzeichen
--drop view if exists kis.dqa_nfal_notan;
create or replace view kis.dqa_nfal_notan
as
select 
  count(falnr) quantity, 
  notan 
from kis.nfal n 
group by n.notan 
order by quantity desc
;

create or replace view kis.dqa_nfal_notan_jahr
as
select
  case 
    when erdat isnull then date_part('year', updat)
    else date_part('year', erdat)
  end jahr,
  count(falnr) quantity, 
  notan 
from kis.nfal n
group by jahr, n.notan 
order by jahr, quantity desc
;

-- Kurzaufnahmekennzeichen
create or replace view kis.dqa_nfal_krzan
as
select 
  count(falnr) quantity, 
  krzan 
from kis.nfal n
group by n.krzan 
order by quantity desc
;

create or replace view kis.dqa_nfal_krzan_jahr
as
select
  case 
    when erdat isnull then date_part('year', updat)
    else date_part('year', erdat)
  end jahr,
  count(falnr) quantity, 
  krzan 
from kis.nfal n
group by jahr, krzan 
order by jahr, quantity desc
;

-- Datum der Entbindung
--drop view if exists kis.dqa_nfal_endat;
create or replace view kis.dqa_nfal_endat
as
select 
  count(falnr) quantity, 
  endat
from kis.nfal n
group by endat 
order by quantity desc
;

create or replace view kis.dqa_nfal_endat_jahr
as
select
  case 
    when erdat isnull then date_part('year', updat)
    else date_part('year', erdat)
  end jahr,
  count(falnr) quantity, 
  endat 
from kis.nfal n
group by jahr, endat 
order by jahr, quantity desc
;

-- Entbindungstyp
--drop view if exists kis.dqa_nfal_fgtyp;
create or replace view kis.dqa_nfal_fgtyp
as
select
  count(falnr) quantity, 
  case 
    when fgtyp ~'^\w' then fgtyp 
    else null
  end fgtyp 
from kis.nfal n
group by fgtyp 
order by quantity desc
;

create or replace view kis.dqa_nfal_fgtyp_jahr
as
select
  case 
    when erdat isnull then date_part('year', updat)
    else date_part('year', erdat)
  end jahr,
  count(falnr) quantity,
  case 
    when fgtyp ~'^\w' then fgtyp 
    else null
  end fgtyp 
from kis.nfal n
group by jahr, fgtyp 
order by jahr, quantity desc
;

-- Kennzeichen Komplikationen
--drop view if exists kis.dqa_nfal_kzkom;
create or replace view kis.dqa_nfal_kzkom
as
select
  count(falnr) quantity, 
  kzkom 
from kis.nfal n
group by kzkom 
order by quantity desc
;

create or replace view kis.dqa_nfal_kzkom_jahr
as
select
  case 
    when erdat isnull then date_part('year', updat)
    else date_part('year', erdat)
  end jahr,
  count(falnr) quantity, 
  kzkom 
from kis.nfal n
group by jahr, kzkom 
order by jahr, quantity desc
;

-- Endedatum des Falls
--drop view if exists kis.dqa_nfal_enddt;
create or replace view kis.dqa_nfal_enddt
as
select
  count(falnr) quantity, 
  enddt 
from kis.nfal n
group by enddt 
order by quantity desc
;

create or replace view kis.dqa_nfal_enddt_jahr
as
select
  case 
    when erdat isnull then date_part('year', updat)
    else date_part('year', erdat)
  end jahr,
  count(falnr) quantity, 
  enddt 
from kis.nfal n
group by jahr, enddt 
order by jahr, quantity desc
;

-- Datum, an dem der Datensatz erstellt wurde
-- drop view if exists kis.dqa_nfal_erdat
create or replace view kis.dqa_nfal_erdat
as
select 
  count(falnr) quantity, 
  erdat 
from kis.nfal n 
group by erdat 
order by quantity desc
;

create or replace view kis.dqa_nfal_erdat_jahr
as
select 
  case 
    when erdat isnull then date_part('year', updat)
    else date_part('year', erdat)
  end jahr,
  count(falnr) quantity, 
  erdat 
from kis.nfal n 
group by jahr, erdat 
order by jahr, quantity desc
;

-- Änderungsdatum
-- drop view if exists kis.dqa_nfal_updat;
create or replace view kis.dqa_nfal_updat
as
select
  count(falnr) quantity, 
  updat 
from kis.nfal n
group by updat 
order by quantity desc
;

--drop view if exists kis.dqa_nfal_updat_jahr;
create or replace view kis.dqa_nfal_updat_jahr
as
select
  case 
    when erdat isnull then date_part('year', updat)
    else date_part('year', erdat)
  end jahr,
  count(falnr) quantity, 
  updat 
from kis.nfal n
group by jahr, updat 
order by jahr, quantity desc
;

-- Stornokennzeichen
-- drop view if exists kis.dqa_nfal_storn;
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
  case 
    when erdat isnull then date_part('year', updat)
    else date_part('year', erdat)
  end jahr,
  count(falnr) quantity, 
  storn 
from kis.nfal n
group by jahr, storn 
order by jahr, quantity desc
;

-- Stornierungsdatum
--drop view if exists kis.dqa_nfal_stdat;
create or replace view kis.dqa_nfal_stdat
as
select 
  count(falnr) quantity,
  stdat
from kis.nfal n 
group by stdat 
order by quantity desc
;

create or replace view kis.dqa_nfal_stdat_jahr
as
select
  case 
    when erdat isnull then date_part('year', updat)
    else date_part('year', erdat)
  end jahr,
  count(falnr) quantity, 
  stdat 
from kis.nfal n
group by jahr, stdat 
order by jahr, quantity desc
;

-- Beginndatum des Falls
--drop view if exists kis.dqa_nfal_begdt;
create or replace view kis.dqa_nfal_begdt
as
select 
  count(falnr) quantity,
  begdt 
from kis.nfal n 
group by begdt 
order by quantity desc
;

create or replace view kis.dqa_nfal_begdt_jahr
as
select
  case 
    when erdat isnull then date_part('year', updat)
    else date_part('year', erdat)
  end jahr,
  count(falnr) quantity, 
  begdt 
from kis.nfal n
group by jahr, begdt 
order by jahr, quantity desc
;

-- Falltyp
--drop view if exists kis.dqa_nfal_fatyp;
create or replace view kis.dqa_nfal_fatyp
as
select 
  count(falnr) quantity,
  case 
    when fatyp ~'^\w' then fatyp 
    else null
  end fatyp 
from kis.nfal n 
group by fatyp 
order by quantity desc
;

create or replace view kis.dqa_nfal_fatyp_jahr
as
select
  case 
    when erdat isnull then date_part('year', updat)
    else date_part('year', erdat)
  end jahr,
  count(falnr) quantity, 
  case 
    when fatyp ~'^\w' then fatyp 
    else null
  end fatyp 
from kis.nfal n
group by jahr, fatyp 
order by jahr, quantity desc
;

-- Fachrichtung für Organisationseinheit
--drop view if exists kis.dqa_nfal_fachr;
create or replace view kis.dqa_nfal_fachr
as
select 
  count(falnr) quantity,
  case 
    when fachr ~'^\w' then fachr 
    else null
  end fachr,
  f.fachrichtung 
from kis.nfal n
left join metadata_repository.fachrichtung f 
  on n.fachr = f.sourceid 
group by n.fachr, f.fachrichtung 
order by quantity desc
;

create or replace view kis.dqa_nfal_fachr_jahr
as
select
  case 
    when erdat isnull then date_part('year', updat)
    else date_part('year', erdat)
  end jahr,
  count(falnr) quantity, 
  case 
    when fachr ~'^\w' then fachr 
    else null
  end fachr,
  f.fachrichtung
from kis.nfal n
left join metadata_repository.fachrichtung f 
  on f.sourceid = n.fachr 
group by jahr, n.fachr, f.fachrichtung 
order by jahr, quantity desc
;
-------------------------------------------------------

-- Art des Fallendes
--drop view if exists kis.dqa_nfal_endtyp cascade;
create or replace view kis.dqa_nfal_endtyp
as
select
  count(falnr) quantity,
  case
    when n.endtyp ~'^\w' then n.endtyp
    else null
  end endtyp,
  f.fallendes 
from kis.nfal n
left join metadata_repository.fallendes f 
  on n.endtyp = f.sourceid 
group by n.endtyp, f.fallendes 
order by quantity desc
;

--drop view if exists kis.dqa_nfal_endtyp_jahr cascade;
create or replace view kis.dqa_nfal_endtyp_jahr
as
select
  case
    when erdat isnull then date_part('year', updat)
    else date_part('year', erdat)
  end jahr,
  count(falnr) quantity,
  case
    when n.endtyp ~'^\w' then n.endtyp
    else null
  end endtyp,
  f.fallendes
from kis.nfal n
left join metadata_repository.fallendes f
  on f.sourceid = n.endtyp 
group by jahr, n.endtyp, f.fallendes 
order by jahr, quantity desc
;

-- Kennzeichen Einweisung auf Patientenwunsch
--drop view if exists kis.dqa_nfal_patw cascade;
create or replace view kis.dqa_nfal_patw
as
select
  count(falnr) quantity,
  patw
from kis.nfal n
group by n.patw
order by quantity desc
;

--drop view if exists kis.dqa_nfal_patw_jahr cascade;
create or replace view kis.dqa_nfal_patw_jahr
as
select
  case
    when erdat isnull then date_part('year', updat)
    else date_part('year', erdat)
  end jahr,
  count(falnr) quantity,
  patw
from kis.nfal n
group by jahr, n.patw
order by jahr, quantity desc
;

-- Gewicht des Patienten bei Aufnahme
--drop view if exists kis.dqa_nfal_patgew cascade;
create or replace view kis.dqa_nfal_patgew
as
select
  count(falnr) quantity,
  patgew
from kis.nfal n
group by n.patgew
order by quantity desc
;

--drop view if exists kis.dqa_nfal_patgew_jahr cascade;
create or replace view kis.dqa_nfal_patgew_jahr
as
select
  case
    when erdat isnull then date_part('year', updat)
    else date_part('year', erdat)
  end jahr,
  count(falnr) quantity,
  patgew
from kis.nfal n
group by jahr, n.patgew
order by jahr, quantity desc
;

-- Maßeinheit Gewicht Patient
drop view if exists kis.dqa_nfal_gwein cascade;
create or replace view kis.dqa_nfal_gwein
as
select
  count(falnr) quantity,
  gwein,
  u.unitid ,
  u.unitname
from kis.nfal n
left join metadata_repository.units u
  on n.gwein = u.sourceid
group by n.gwein, u.unitid, u.unitname 
order by quantity desc
;

drop view if exists kis.dqa_nfal_gwein_jahr cascade;
create or replace view kis.dqa_nfal_gwein_jahr
as
select
  case
    when erdat isnull then date_part('year', updat)
    else date_part('year', erdat)
  end jahr,
  count(falnr) quantity,
  case
    when n.gwein ~'^\w' then n.gwein
    else null
  end gwein,
  u.unitid,
  u.unitname
from kis.nfal n
left join metadata_repository.units u
  on n.gwein = u.sourceid
group by jahr, n.gwein, u.unitid, u.unitname  
order by jahr, quantity desc
;

-- Größe des Patienten bei Aufnahme
--drop view if exists kis.dqa_nfal_patgro cascade;
create or replace view kis.dqa_nfal_patgro
as
select
  count(falnr) quantity,
  patgro
from kis.nfal n
group by n.patgro
order by quantity desc
;

--drop view if exists kis.dqa_nfal_patgro_jahr cascade;
create or replace view kis.dqa_nfal_patgro_jahr
as
select
  case
    when erdat isnull then date_part('year', updat)
    else date_part('year', erdat)
  end jahr,
  count(falnr) quantity,
  patgro
from kis.nfal n
group by jahr, n.patgro
order by jahr, quantity desc
;
-----------------------------------------------------------------------------
-- Maßeinheit Größe Patient
--drop view if exists kis.dqa_nfal_grein;
create or replace view kis.dqa_nfal_grein
as
select
  count(falnr) quantity,
  case
    when n.grein ~'^\w' then n.grein
    else null
  end grein,
  u.unitid,
  u.unitname 
from kis.nfal n
left join metadata_repository.units u 
  on u.sourceid = n.grein 
group by n.grein, u.unitid ,u.unitname 
order by quantity desc
;

--drop view if exists kis.dqa_nfal_grein_jahr cascade;
create or replace view kis.dqa_nfal_grein_jahr
as
select
  case
    when erdat isnull then date_part('year', updat)
    else date_part('year', erdat)
  end jahr,
  count(falnr) quantity,
  case
    when n.grein ~'^\w' then n.grein
    else null
  end grein,
  u.unitid,
  u.unitname 
from kis.nfal n
left join metadata_repository.units u
  on u.sourceid = n.grein 
group by jahr, n.grein, u.unitid, u.unitname  
order by jahr, quantity desc
;

-- Beatmungsdauer in Stunden
--drop view if exists kis.dqa_nfal_resp cascade;
create or replace view kis.dqa_nfal_resp
as
select
  count(falnr) quantity,
  resp
from kis.nfal n
group by n.resp
order by quantity desc
;

--drop view if exists kis.dqa_nfal_resp_jahr cascade;
create or replace view kis.dqa_nfal_resp_jahr
as
select
  case
    when erdat isnull then date_part('year', updat)
    else date_part('year', erdat)
  end jahr,
  count(falnr) quantity,
  resp
from kis.nfal n
group by jahr, n.resp
order by jahr, quantity desc
;

-- Schwangerschaftswoche bei Geburt
--drop view if exists kis.dqa_nfal_delgw cascade;
create or replace view kis.dqa_nfal_delgw
as
select
  count(falnr) quantity,
  delgw
from kis.nfal n
group by n.delgw
order by quantity desc
;

--drop view if exists kis.dqa_nfal_delgw_jahr cascade;
create or replace view kis.dqa_nfal_delgw_jahr
as
select
  case
    when erdat isnull then date_part('year', updat)
    else date_part('year', erdat)
  end jahr,
  count(falnr) quantity,
  delgw
from kis.nfal n
group by jahr, n.delgw
order by jahr, quantity desc
;

-- Schweregrad-Score (SAPS)
--drop view if exists kis.dqa_nfal_saps_c cascade;
create or replace view kis.dqa_nfal_saps_c
as
select
  count(falnr) quantity,
  saps_c
from kis.nfal n
group by n.saps_c
order by quantity desc
;

--drop view if exists kis.dqa_nfal_saps_c_jahr cascade;
create or replace view kis.dqa_nfal_saps_c_jahr
as
select
  case
    when erdat isnull then date_part('year', updat)
    else date_part('year', erdat)
  end jahr,
  count(falnr) quantity,
  saps_c
from kis.nfal n
group by jahr, n.saps_c
order by jahr, quantity desc
;

-- Schweregrad-Score (PIM2)
--drop view if exists kis.dqa_nfal_pim2_c cascade;
create or replace view kis.dqa_nfal_pim2_c
as
select
  count(falnr) quantity,
  pim2_c
from kis.nfal n
group by n.pim2_c
order by quantity desc
;

--drop view if exists kis.dqa_nfal_pim2_c_jahr cascade;
create or replace view kis.dqa_nfal_pim2_c_jahr
as
select
  case
    when erdat isnull then date_part('year', updat)
    else date_part('year', erdat)
  end jahr,
  count(falnr) quantity,
  pim2_c
from kis.nfal n
group by jahr, n.pim2_c
order by jahr, quantity desc
;

-- Schweregrad-Score (CRIB)
--drop view if exists kis.dqa_nfal_crib_c cascade;
create or replace view kis.dqa_nfal_crib_c
as
select
  count(falnr) quantity,
  crib_c
from kis.nfal n
group by n.crib_c
order by quantity desc
;

--drop view if exists kis.dqa_nfal_crib_c_jahr cascade;
create or replace view kis.dqa_nfal_crib_c_jahr
as
select
  case
    when erdat isnull then date_part('year', updat)
    else date_part('year', erdat)
  end jahr,
  count(falnr) quantity,
  crib_c
from kis.nfal n
group by jahr, n.crib_c
order by jahr, quantity desc
;

-- Total aller Schichten (NEMS)
--drop view if exists kis.dqa_nfal_nems_c cascade;
create or replace view kis.dqa_nfal_nems_c
as
select
  count(falnr) quantity,
  nems_c
from kis.nfal n
group by n.nems_c
order by quantity desc
;

--drop view if exists kis.dqa_nfal_nems_c_jahr cascade;
create or replace view kis.dqa_nfal_nems_c_jahr
as
select
  case
    when erdat isnull then date_part('year', updat)
    else date_part('year', erdat)
  end jahr,
  count(falnr) quantity,
  nems_c
from kis.nfal n
group by jahr, n.nems_c
order by jahr, quantity desc
;

-- Schweregrad-Score (SAPS) – Intermediate Care
--drop view if exists kis.dqa_nfal_saps_imc cascade;
create or replace view kis.dqa_nfal_saps_imc
as
select
  count(falnr) quantity,
  saps_imc
from kis.nfal n
group by n.saps_imc
order by quantity desc
;

--drop view if exists kis.dqa_nfal_saps_imc_jahr cascade;
create or replace view kis.dqa_nfal_saps_imc_jahr
as
select
  case
    when erdat isnull then date_part('year', updat)
    else date_part('year', erdat)
  end jahr,
  count(falnr) quantity,
  saps_imc
from kis.nfal n
group by jahr, n.saps_imc
order by jahr, quantity desc
;

-- Schweregrad-Score (PIM2) – Intermediate Care
--drop view if exists kis.dqa_nfal_pim2_imc cascade;
create or replace view kis.dqa_nfal_pim2_imc
as
select
  count(falnr) quantity,
  pim2_imc
from kis.nfal n
group by n.pim2_imc
order by quantity desc
;

--drop view if exists kis.dqa_nfal_pim2_imc_jahr cascade;
create or replace view kis.dqa_nfal_pim2_imc_jahr
as
select
  case
    when erdat isnull then date_part('year', updat)
    else date_part('year', erdat)
  end jahr,
  count(falnr) quantity,
  pim2_imc
from kis.nfal n
group by jahr, n.pim2_imc
order by jahr, quantity desc
;

-- Schweregrad-Score (CRIB) – Intermedaite Care
--drop view if exists kis.dqa_nfal_crib_imc cascade;
create or replace view kis.dqa_nfal_crib_imc
as
select
  count(falnr) quantity,
  crib_imc
from kis.nfal n
group by n.crib_imc
order by quantity desc
;

--drop view if exists kis.dqa_nfal_crib_imc_jahr cascade;
create or replace view kis.dqa_nfal_crib_imc_jahr
as
select
  case
    when erdat isnull then date_part('year', updat)
    else date_part('year', erdat)
  end jahr,
  count(falnr) quantity,
  crib_imc
from kis.nfal n
group by jahr, n.crib_imc
order by jahr, quantity desc
;

-- Total aller Schichten (NEMS) – Intermediate Care
--drop view if exists kis.dqa_nfal_nems_imc cascade;
create or replace view kis.dqa_nfal_nems_imc
as
select
  count(falnr) quantity,
  nems_imc
from kis.nfal n
group by n.nems_imc
order by quantity desc
;

--drop view if exists kis.dqa_nfal_nems_imc_jahr cascade;
create or replace view kis.dqa_nfal_nems_imc_jahr
as
select
  case
    when erdat isnull then date_part('year', updat)
    else date_part('year', erdat)
  end jahr,
  count(falnr) quantity,
  nems_imc
from kis.nfal n
group by jahr, n.nems_imc
order by jahr, quantity desc
;

-- Beatmungsdauer in Stunden – Intermedaite Care
--drop view if exists kis.dqa_nfal_respi_imc cascade;
create or replace view kis.dqa_nfal_respi_imc
as
select
  count(falnr) quantity,
  respi_imc
from kis.nfal n
group by n.respi_imc
order by quantity desc
;

--drop view if exists kis.dqa_nfal_respi_imc_jahr cascade;
create or replace view kis.dqa_nfal_respi_imc_jahr
as
select
  case
    when erdat isnull then date_part('year', updat)
    else date_part('year', erdat)
  end jahr,
  count(falnr) quantity,
  respi_imc
from kis.nfal n
group by jahr, n.respi_imc
order by jahr, quantity desc
;

-- Kennzeichen möglicher Wiederkehrerfall
--drop view if exists kis.dqa_nfal_readm cascade;
create or replace view kis.dqa_nfal_readm
as
select
  count(falnr) quantity,
  readm
from kis.nfal n
group by n.readm
order by quantity desc
;

--drop view if exists kis.dqa_nfal_readm_jahr cascade;
create or replace view kis.dqa_nfal_readm_jahr
as
select
  case
    when erdat isnull then date_part('year', updat)
    else date_part('year', erdat)
  end jahr,
  count(falnr) quantity,
  readm
from kis.nfal n
group by jahr, n.readm
order by jahr, quantity desc
;

/*
*/
