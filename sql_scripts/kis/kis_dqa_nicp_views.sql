-- DQA for NICP 

-- all null values
create or replace view kis.dqa_nicp_null_values
as
select
  count(falnr) quantities,
  'einri' "columns"
from kis.nicp n
where einri isnull or einri !~'^\w'
  union
select
  count(falnr) quantities,
  'falnr' "columns"
from kis.nicp n
where falnr isnull or falnr !~'^\w'
  union
select
  count(falnr) quantities,
  'lnric' "columns"
from kis.nicp n
where lnric isnull or lnric !~'^\w'
  union
select
  count(falnr) quantities,
  'lfdbew' "columns"
from kis.nicp n
where lfdbew isnull
  union
select
  count(falnr) quantities,
  'icpmk' "columns"
from kis.nicp n
where icpmk isnull or icpmk !~'^\w'
  union
select
  count(falnr) quantities,
  'icpml' "columns"
from kis.nicp n
where icpml isnull or icpml !~'^\w'
  union
select
  count(falnr) quantities,
  'icphc' "columns"
from kis.nicp n
where icphc isnull
  union
select
  count(falnr) quantities,
  'anzop' "columns"
from kis.nicp n
where anzop isnull
  union
select
  count(falnr) quantities,
  'bgdop' "columns"
from kis.nicp n
where bgdop isnull
  union
select
  count(falnr) quantities,
  'bztop' "columns"
from kis.nicp n
where bztop isnull
  union
select
  count(falnr) quantities,
  'eztop' "columns"
from kis.nicp n
where eztop isnull
  union
select
  count(falnr) quantities,
  'lslok' "columns"
from kis.nicp n
where lslok isnull or lslok !~'^\w'
  union
select
  count(falnr) quantities,
  'opart' "columns"
from kis.nicp n
where opart isnull or opart !~'^\w'
  union
select
  count(falnr) quantities,
  'updat' "columns"
from kis.nicp n
where updat isnull
  union
select
  count(falnr) quantities,
  'storn' "columns"
from kis.nicp n
where storn isnull
  union
select
  count(falnr) quantities,
  'stdat' "columns"
from kis.nicp n
where stdat isnull
  union
select
  count(falnr) quantities,
  'drg_category' "columns"
from kis.nicp n
where drg_category isnull or drg_category !~'^\w'
  union
select
  count(falnr) quantities,
  'drg_relevant' "columns"
from kis.nicp n
where drg_relevant isnull
  union
select
  count(falnr) quantities,
  'orgfa' "columns"
from kis.nicp n
where orgfa isnull or orgfa !~'^\w'
  union
select
  count(falnr) quantities,
  'orgpf' "columns"
from kis.nicp n
where orgpf isnull or orgpf !~'^\w'
  union
select
  count(falnr) quantities,
  'endop' "columns"
from kis.nicp n
where endop isnull
  union
select
  count(falnr) quantities,
  'prtyp' "columns"
from kis.nicp n
where prtyp isnull or prtyp !~'^\w'
  union
select
  count(falnr) quantities,
  'quantity' "columns"
from kis.nicp n
where quantity isnull
  union
select
  count(falnr) quantities,
  'unit' "columns"
from kis.nicp n
where unit isnull or unit !~'^\w'
  union
select
  count(falnr) quantities,
  'ccl' "columns"
from kis.nicp n
where ccl isnull or ccl !~'^\w'
  union
select
  count(falnr) quantities,
  'oplebspen' "columns"
from kis.nicp n
where oplebspen isnull
order by quantities, "columns"
;

-- Einrichtung
--drop view if exists kis.dqa_nicp_einri cascade;
create or replace view kis.dqa_nicp_einri
as
select
  count(falnr) quantities,
  case
    when n.einri ~'^\w' then n.einri
    else null
  end einri
from kis.nicp n
group by n.einri
order by quantities desc
;

--drop view if exists kis.dqa_nicp_einri_jahr cascade;
create or replace view kis.dqa_nicp_einri_jahr
as
select
  date_part('year', updat) jahr,
  count(falnr) quantities,
  case
    when n.einri ~'^\w' then n.einri
    else null
  end einri
from kis.nicp n
group by jahr, n.einri
order by jahr, quantities desc
;

-- Fallnummer
--drop view if exists kis.dqa_nicp_falnr cascade;
create or replace view kis.dqa_nicp_falnr
as
select
  count(falnr) quantities,
  case
    when n.falnr ~'^\w' then n.falnr
    else null
  end falnr
from kis.nicp n
group by n.falnr
order by quantities desc
;

--drop view if exists kis.dqa_nicp_falnr_jahr cascade;
create or replace view kis.dqa_nicp_falnr_jahr
as
select
  date_part('year', updat) jahr,
  count(falnr) quantities,
  case
    when n.falnr ~'^\w' then n.falnr
    else null
  end falnr
from kis.nicp n
group by jahr, n.falnr
order by jahr, quantities desc
;

-- Laufende Nummer des Operationscodes
--drop view if exists kis.dqa_nicp_lnric cascade;
create or replace view kis.dqa_nicp_lnric
as
select
  count(falnr) quantities,
  case
    when n.lnric ~'^\w' then n.lnric
    else null
  end lnric
from kis.nicp n
group by n.lnric
order by quantities desc
;

--drop view if exists kis.dqa_nicp_lnric_jahr cascade;
create or replace view kis.dqa_nicp_lnric_jahr
as
select
  date_part('year', updat) jahr,
  count(falnr) quantities,
  case
    when n.lnric ~'^\w' then n.lnric
    else null
  end lnric
from kis.nicp n
group by jahr, n.lnric
order by jahr, quantities desc
;

-- Laufende Nummer einer Bewegung
--drop view if exists kis.dqa_nicp_lfdbew cascade;
create or replace view kis.dqa_nicp_lfdbew
as
select
  count(falnr) quantities,
  n.lfdbew 
from kis.nicp n
group by n.lfdbew
order by quantities desc
;

--drop view if exists kis.dqa_nicp_lfdbew_jahr cascade;
create or replace view kis.dqa_nicp_lfdbew_jahr
as
select
  date_part('year', updat) jahr,
  count(falnr) quantities,
  lfdbew
from kis.nicp n
group by jahr, n.lfdbew
order by jahr, quantities desc
;

-- Identifikation eines Operationsleistungskataloges
--drop view if exists kis.dqa_nicp_icpmk cascade;
create or replace view kis.dqa_nicp_icpmk
as
select
  count(falnr) quantities,
  case
    when n.icpmk ~'^\w' then n.icpmk
    else null
  end icpmk,
  ok.operation_katalog
from kis.nicp n
left join metadata_repository.operation_katalog ok 
  on ok.sourceid = n.icpmk 
group by n.icpmk, ok.operation_katalog
order by quantities desc
;

--drop view if exists kis.dqa_nicp_icpmk_jahr cascade;
create or replace view kis.dqa_nicp_icpmk_jahr
as
select
  date_part('year', updat) jahr,
  count(falnr) quantities,
  case
    when n.icpmk ~'^\w' then n.icpmk
    else null
  end icpmk,
  ok.operation_katalog
from kis.nicp n
left join metadata_repository.operation_katalog ok 
  on ok.sourceid = n.icpmk 
group by jahr, n.icpmk, ok.operation_katalog
order by jahr, quantities desc
;

-- Identifikation eines Operationscodes (Leistung)
--drop view if exists kis.dqa_nicp_icpml cascade;
create or replace view kis.dqa_nicp_icpml
as
select
  count(falnr) quantities,
  case
    when n.icpml ~'^\w' then n.icpml
    else null
  end icpml,
  o.titel 
from kis.nicp n
left join ops_metainfo.ops o 
  on upper(o.kode) = upper(n.icpml) 
group by n.icpml, o.titel 
order by quantities desc
;

--drop view if exists kis.dqa_nicp_icpml_jahr cascade;
create or replace view kis.dqa_nicp_icpml_jahr
as
select
  date_part('year', updat) jahr,
  count(falnr) quantities,
  case
    when n.icpml ~'^\w' then n.icpml
    else null
  end icpml,
  o.titel 
from kis.nicp n
left join ops_metainfo.ops o 
  on upper(o.kode) = upper(n.icpml)
group by jahr, n.icpml, o.titel 
order by jahr, quantities desc
;

-- Kennzeichen, ob Operation Hauptcode ist
--drop view if exists kis.dqa_nicp_icphc cascade;
create or replace view kis.dqa_nicp_icphc
as
select
  count(falnr) quantities,
  icphc
from kis.nicp n
group by n.icphc
order by quantities desc
;

--drop view if exists kis.dqa_nicp_icphc_jahr cascade;
create or replace view kis.dqa_nicp_icphc_jahr
as
select
  date_part('year', updat) jahr,
  count(falnr) quantities,
  icphc
from kis.nicp n
group by jahr, n.icphc
order by jahr, quantities desc
;

-- Anzahl weiterer Operationen
--drop view if exists kis.dqa_nicp_anzop cascade;
create or replace view kis.dqa_nicp_anzop
as
select
  count(falnr) quantities,
  anzop
from kis.nicp n
group by n.anzop
order by quantities desc
;

--drop view if exists kis.dqa_nicp_anzop_jahr cascade;
create or replace view kis.dqa_nicp_anzop_jahr
as
select
  date_part('year', updat) jahr,
  count(falnr) quantities,
  anzop
from kis.nicp n
group by jahr, n.anzop
order by jahr, quantities desc
;

-- Datum, an dem der Operationscode erbracht wurde
--drop view if exists kis.dqa_nicp_bgdop cascade;
create or replace view kis.dqa_nicp_bgdop
as
select
  count(falnr) quantities,
  bgdop
from kis.nicp n
group by n.bgdop
order by quantities desc
;

--drop view if exists kis.dqa_nicp_bgdop_jahr cascade;
create or replace view kis.dqa_nicp_bgdop_jahr
as
select
  date_part('year', updat) jahr,
  count(falnr) quantities,
  bgdop
from kis.nicp n
group by jahr, n.bgdop
order by jahr, quantities desc
;

-- Beginnuhrzeit, zu der ein Operationscode erbracht wurde
--drop view if exists kis.dqa_nicp_bztop cascade;
create or replace view kis.dqa_nicp_bztop
as
select
  count(falnr) quantities,
  bztop
from kis.nicp n
group by n.bztop
order by quantities desc
;

--drop view if exists kis.dqa_nicp_bztop_jahr cascade;
create or replace view kis.dqa_nicp_bztop_jahr
as
select
  date_part('year', updat) jahr,
  count(falnr) quantities,
  bztop
from kis.nicp n
group by jahr, n.bztop
order by jahr, quantities desc
;

-- Endeuhrzeit, zu der ein Operationscode beendet wurde
--drop view if exists kis.dqa_nicp_eztop cascade;
create or replace view kis.dqa_nicp_eztop
as
select
  count(falnr) quantities,
  eztop
from kis.nicp n
group by n.eztop
order by quantities desc
;

--drop view if exists kis.dqa_nicp_eztop_jahr cascade;
create or replace view kis.dqa_nicp_eztop_jahr
as
select
  date_part('year', updat) jahr,
  count(falnr) quantities,
  eztop
from kis.nicp n
group by jahr, n.eztop
order by jahr, quantities desc
;

-- Lokalisation einer Prozedur
--drop view if exists kis.dqa_nicp_lslok cascade;
create or replace view kis.dqa_nicp_lslok
as
select
  count(falnr) quantities,
  case
    when n.lslok ~'^\w' then n.lslok
    else null
  end lslok,
  bl.localisation 
from kis.nicp n
left join metadata_repository.body_localisation bl 
  on n.lslok = bl.sourceid 
group by n.lslok, bl.localisation 
order by quantities desc
;

--drop view if exists kis.dqa_nicp_lslok_jahr cascade;
create or replace view kis.dqa_nicp_lslok_jahr
as
select
  date_part('year', updat) jahr,
  count(falnr) quantities,
  case
    when n.lslok ~'^\w' then n.lslok
    else null
  end lslok,
  bl.localisation 
from kis.nicp n
left join metadata_repository.body_localisation bl 
  on bl.sourceid = n.lslok 
group by jahr, n.lslok, bl.localisation 
order by jahr, quantities desc
;

-- Art der Operation
--drop view if exists kis.dqa_nicp_opart cascade;
create or replace view kis.dqa_nicp_opart
as
select
  count(falnr) quantities,
  case
    when n.opart ~'^\w' then n.opart
    else null
  end opart
from kis.nicp n
group by n.opart
order by quantities desc
;

--drop view if exists kis.dqa_nicp_opart_jahr cascade;
create or replace view kis.dqa_nicp_opart_jahr
as
select
  date_part('year', updat) jahr,
  count(falnr) quantities,
  case
    when n.opart ~'^\w' then n.opart
    else null
  end opart
from kis.nicp n
group by jahr, n.opart
order by jahr, quantities desc
;

-- Änderungsdatum
--drop view if exists kis.dqa_nicp_updat cascade;
create or replace view kis.dqa_nicp_updat
as
select
  count(falnr) quantities,
  updat
from kis.nicp n
group by n.updat
order by quantities desc
;

--drop view if exists kis.dqa_nicp_updat_jahr cascade;
create or replace view kis.dqa_nicp_updat_jahr
as
select
  date_part('year', updat) jahr,
  count(falnr) quantities,
  updat
from kis.nicp n
group by jahr, n.updat
order by jahr, quantities desc
;

-- Stornokennzeichen
--drop view if exists kis.dqa_nicp_storn cascade;
create or replace view kis.dqa_nicp_storn
as
select
  count(falnr) quantities,
  storn
from kis.nicp n
group by n.storn
order by quantities desc
;

--drop view if exists kis.dqa_nicp_storn_jahr cascade;
create or replace view kis.dqa_nicp_storn_jahr
as
select
  date_part('year', updat) jahr,
  count(falnr) quantities,
  storn
from kis.nicp n
group by jahr, n.storn
order by jahr, quantities desc
;

-- Stornierungsdatum
--drop view if exists kis.dqa_nicp_stdat cascade;
create or replace view kis.dqa_nicp_stdat
as
select
  count(falnr) quantities,
  stdat
from kis.nicp n
group by n.stdat
order by quantities desc
;

--drop view if exists kis.dqa_nicp_stdat_jahr cascade;
create or replace view kis.dqa_nicp_stdat_jahr
as
select
  date_part('year', updat) jahr,
  count(falnr) quantities,
  stdat
from kis.nicp n
group by jahr, n.stdat
order by jahr, quantities desc
;

-- Kategorie einer DRG-Prozedur (Haupt- Nebenprozedur)
--drop view if exists kis.dqa_nicp_drg_category cascade;
create or replace view kis.dqa_nicp_drg_category
as
select
  count(falnr) quantities,
  case
    when n.drg_category ~'^\w' then n.drg_category
    else null
  end drg_category,
  case 
    when n.drg_category ~'^\w' then dp.drg_prozedur
    else 'keine DRG-Prozedur'
  end drg_prozedur
from kis.nicp n
left join metadata_repository.drg_prozedur dp 
  on dp.sourceid = n.drg_category 
group by n.drg_category, drg_prozedur
order by quantities desc
;

--drop view if exists kis.dqa_nicp_drg_category_jahr cascade;
create or replace view kis.dqa_nicp_drg_category_jahr
as
select
  date_part('year', updat) jahr,
  count(falnr) quantities,
  case
    when n.drg_category ~'^\w' then n.drg_category
    else null
  end drg_category,
  case 
    when n.drg_category ~'^\w' then dp.drg_prozedur
    else 'keine DRG-Prozedur'
  end drg_prozedur
from kis.nicp n
left join metadata_repository.drg_prozedur dp 
  on dp.sourceid = n.drg_category 
group by jahr, n.drg_category, drg_prozedur
order by jahr, quantities desc
;

-- Kennzeichen für DRG-Ermittlung verwendet
--drop view if exists kis.dqa_nicp_drg_relevant cascade;
create or replace view kis.dqa_nicp_drg_relevant
as
select
  count(falnr) quantities,
  drg_relevant
from kis.nicp n
group by n.drg_relevant
order by quantities desc
;

--drop view if exists kis.dqa_nicp_drg_relevant_jahr cascade;
create or replace view kis.dqa_nicp_drg_relevant_jahr
as
select
  date_part('year', updat) jahr,
  count(falnr) quantities,
  drg_relevant
from kis.nicp n
group by jahr, n.drg_relevant
order by jahr, quantities desc
;

-- Fachliche Organisationseinheit der Prozedur
--drop view if exists kis.dqa_nicp_orgfa cascade;
create or replace view kis.dqa_nicp_orgfa
as
select
  count(falnr) quantities,
  case
    when n.orgfa ~'^\w' then n.orgfa
    else null
  end orgfa,
  ng.orgna
from kis.nicp n
left join kis.norg ng 
  on n.orgfa = ng.orgid 
group by n.orgfa, ng.orgna 
order by quantities desc
;

--drop view if exists kis.dqa_nicp_orgfa_jahr cascade;
create or replace view kis.dqa_nicp_orgfa_jahr
as
select
  date_part('year', updat) jahr,
  count(falnr) quantities,
  case
    when n.orgfa ~'^\w' then n.orgfa
    else null
  end orgfa,
  ng.orgna 
from kis.nicp n
left join kis.norg ng 
  on ng.orgid = n.orgfa 
group by jahr, n.orgfa, ng.orgna 
order by jahr, quantities desc
;

-- Erbringende Organisationseinheit der Prozedur
--drop view if exists kis.dqa_nicp_orgpf cascade;
create or replace view kis.dqa_nicp_orgpf
as
select
  count(falnr) quantities,
  case
    when n.orgpf ~'^\w' then n.orgpf
    else null
  end orgpf,
  ng.orgna 
from kis.nicp n
left join kis.norg ng 
  on ng.orgid = n.orgpf 
group by n.orgpf, ng.orgna 
order by quantities desc
;

--drop view if exists kis.dqa_nicp_orgpf_jahr cascade;
create or replace view kis.dqa_nicp_orgpf_jahr
as
select
  date_part('year', updat) jahr,
  count(falnr) quantities,
  case
    when n.orgpf ~'^\w' then n.orgpf
    else null
  end orgpf,
  ng.orgna 
from kis.nicp n
left join kis.norg ng 
  on ng.orgid = n.orgpf 
group by jahr, n.orgpf, ng.orgna 
order by jahr, quantities desc
;

-- Datum, an dem der Operationscode beendet wurde
--drop view if exists kis.dqa_nicp_endop cascade;
create or replace view kis.dqa_nicp_endop
as
select
  count(falnr) quantities,
  endop
from kis.nicp n
group by n.endop
order by quantities desc
;

--drop view if exists kis.dqa_nicp_endop_jahr cascade;
create or replace view kis.dqa_nicp_endop_jahr
as
select
  date_part('year', updat) jahr,
  count(falnr) quantities,
  endop
from kis.nicp n
group by jahr, n.endop
order by jahr, quantities desc
;
---------------------------------------------------------------
-- Prozedurtyp
--drop view if exists kis.dqa_nicp_prtyp cascade;
--create or replace view kis.dqa_nicp_prtyp
--as
select
  count(falnr) quantities,
  case
    when n.prtyp ~'^\w' then n.prtyp
    else null
  end prtyp
from kis.nicp n
group by n.prtyp
order by quantities desc
;

--drop view if exists kis.dqa_nicp_prtyp_jahr cascade;
--create or replace view kis.dqa_nicp_prtyp_jahr
--as
select
  date_part('year', updat) jahr,
  count(falnr) quantities,
  case
    when n.prtyp ~'^\w' then n.prtyp
    else null
  end prtyp
from kis.nicp n
group by jahr, n.prtyp
order by jahr, quantities desc
;
------------------------------------------------------------------
-- Prozedurenmenge
--drop view if exists kis.dqa_nicp_quantity cascade;
create or replace view kis.dqa_nicp_quantity
as
select
  count(falnr) quantities,
  quantity
from kis.nicp n
group by n.quantity
order by quantities desc
;

--drop view if exists kis.dqa_nicp_quantity_jahr cascade;
create or replace view kis.dqa_nicp_quantity_jahr
as
select
  date_part('year', updat) jahr,
  count(falnr) quantities,
  quantity
from kis.nicp n
group by jahr, n.quantity
order by jahr, quantities desc
;
---------------------------------------------------------------
-- Mengeneinheit der Prozedur
--drop view if exists kis.dqa_nicp_unit cascade;
--create or replace view kis.dqa_nicp_unit
--as
select
  count(falnr) quantities,
  case
    when n.unit ~'^\w' then n.unit
    else null
  end unit
from kis.nicp n
group by n.unit
order by quantities desc
;

--drop view if exists kis.dqa_nicp_unit_jahr cascade;
--create or replace view kis.dqa_nicp_unit_jahr
--as
select
  date_part('year', updat) jahr,
  count(falnr) quantities,
  case
    when n.unit ~'^\w' then n.unit
    else null
  end unit
from kis.nicp n
group by jahr, n.unit
order by jahr, quantities desc
;
-----------------------------------------------------------------
-- Komplikationslevel der Prozedur (für DRGs)
--drop view if exists kis.dqa_nicp_ccl cascade;
create or replace view kis.dqa_nicp_ccl
as
select
  count(falnr) quantities,
  case
    when n.ccl ~'^\w' then n.ccl
    else null
  end ccl,
  cl.complication_level 
from kis.nicp n
left join metadata_repository.complication_level cl 
  on cl.sourceid = n.ccl 
group by n.ccl, cl.complication_level 
order by quantities desc
;

--drop view if exists kis.dqa_nicp_ccl_jahr cascade;
create or replace view kis.dqa_nicp_ccl_jahr
as
select
  date_part('year', updat) jahr,
  count(falnr) quantities,
  case
    when n.ccl ~'^\w' then n.ccl
    else null
  end ccl,
  cl.complication_level 
from kis.nicp n
left join metadata_repository.complication_level cl 
  on cl.sourceid = n.ccl 
group by jahr, n.ccl, cl.complication_level 
order by jahr, quantities desc
;

-- OPS-Kz. Lebendspende
--drop view if exists kis.dqa_nicp_oplebspen cascade;
create or replace view kis.dqa_nicp_oplebspen
as
select
  count(falnr) quantities,
  oplebspen
from kis.nicp n
group by n.oplebspen
order by quantities desc
;

--drop view if exists kis.dqa_nicp_oplebspen_jahr cascade;
create or replace view kis.dqa_nicp_oplebspen_jahr
as
select
  date_part('year', updat) jahr,
  count(falnr) quantities,
  oplebspen
from kis.nicp n
group by jahr, n.oplebspen
order by jahr, quantities desc
;
