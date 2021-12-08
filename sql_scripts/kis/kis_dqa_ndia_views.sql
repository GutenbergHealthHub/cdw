--DQA for kis.ndia

-- Null values in ndia.
--drop view if exists kis.dqa_ndia_null_values;
create or replace view kis.dqa_ndia_null_values
as
  select 
    count(falnr) quantity, 
    'einri' "columns"
  from kis.ndia n 
  where einri isnull or einri !~'^\w'
    union 
  select 
    count(falnr),
    'falnr'
  from kis.ndia
  where falnr isnull or falnr !~'^\w'
    union 
    select 
    count(falnr),
    'lfdnr'
  from kis.ndia
  where lfdnr isnull
    union 
  select 
    count(falnr),
    'lfdbew'
  from kis.ndia
  where lfdbew isnull
    union 
  select
    count(falnr),
    'dkat1'
  from kis.ndia
  where dkat1 isnull or dkat1 !~'^\w'
    union 
  select 
    count(falnr),
    'dkat2' 
  from kis.ndia
  where dkat2 isnull or dkat2 !~'^\w'
    union 
  select 
    count(falnr),
    'dkey1' 
  from kis.ndia
  where dkey1 isnull or dkey1 !~ '^\w'
    union 
  select 
    count(falnr),
    'dkey2' 
  from kis.ndia
  where dkey2 isnull or dkey2 !~ '^\w'
    union 
  select 
    count(falnr),
    'dkat_ref'
  from kis.ndia
  where dkat_ref isnull or dkat_ref !~ '^\w'
    union 
   select 
    count(falnr),
    'dkey_ref'
  from kis.ndia
  where dkey_ref isnull or dkey_ref !~ '^\w'
    union 
  select 
    count(falnr),
    'diadt' 
  from kis.ndia
  where diadt isnull
    union 
  select 
    count(falnr),
    'diazt'
  from kis.ndia
  where diazt isnull
    union 
  select 
    count(falnr),
    'anzop'
  from kis.ndia
  where anzop isnull
    union 
  select 
    count(falnr),
    'ewdia'
  from kis.ndia
  where ewdia isnull
    union 
  select 
    count(falnr),
    'bhdia'
  from kis.ndia
  where bhdia isnull 
    union 
  select 
    count(falnr),
    'afdia'
  from kis.ndia
  where afdia isnull
    union 
  select 
    count(falnr),
    'endia'
  from kis.ndia
  where endia isnull 
    union 
  select 
    count(falnr),
    'fhdia' 
  from kis.ndia
  where fhdia isnull
    union 
  select 
    count(falnr),
    'khdia' 
  from kis.ndia
  where khdia isnull
    union 
  select 
    count(falnr),
    'opdia' 
  from kis.ndia
  where opdia isnull
    union 
  select 
    count(falnr),
    'sperr' 
  from kis.ndia
  where sperr isnull
    union 
  select 
    count(falnr),
    'diasi' 
  from kis.ndia
  where diasi isnull or diasi !~'^\w'
    union 
  select 
    count(falnr),
    'erdat' 
  from kis.ndia
  where erdat isnull
    union 
  select 
    count(falnr),
    'updat' 
  from kis.ndia
  where updat isnull
    union 
  select 
    count(falnr),
    'storn' 
  from kis.ndia
  where storn isnull
    union 
  select 
    count(falnr),
    'stdat' 
  from kis.ndia
  where stdat isnull
    union 
  select 
    count(falnr),
    'ardia' 
  from kis.ndia
  where ardia isnull
    union 
  select 
    count(falnr),
    'podia' 
  from kis.ndia
  where podia isnull
    union 
   select 
    count(falnr),
    'tudia' 
  from kis.ndia
  where tudia isnull
    union 
  select 
    count(falnr),
    'stdat' 
  from kis.ndia
  where stdat isnull
    union 
  select 
    count(falnr),
    'diabz' 
  from kis.ndia
  where diabz isnull
    union 
  select 
    count(falnr),
    'diapr' 
  from kis.ndia
  where diapr isnull or diapr !~'^\w'
    union 
  select 
    count(falnr),
    'diagw' 
  from kis.ndia
  where diagw isnull or diagw !~'^\w'
    union 
  select 
    count(falnr),
    'diazr' 
  from kis.ndia
  where diazs isnull or diazs !~'^\w'
    union 
  select 
    count(falnr),
    'dialo' 
  from kis.ndia
  where dialo isnull or dialo !~'^\w'
    union 
  select 
    count(falnr),
    'diafp' 
  from kis.ndia
  where diafp isnull or diafp !~'^\w'
    union
  select 
    count(falnr),
    'drg_dia_seqno' 
  from kis.ndia
  where drg_dia_seqno isnull
    union 
  select 
    count(falnr),
    'drg_category' 
  from kis.ndia
  where drg_category isnull or drg_category !~'^\w'
    union 
  select 
    count(falnr),
    'drg_relevant' 
  from kis.ndia
  where drg_relvant isnull
    union 
  select 
    count(falnr),
    'dtyp1' 
  from kis.ndia
  where dtyp1 isnull or dtyp1 !~'^\w'
    union 
  select 
    count(falnr),
    'dtyp2' 
  from kis.ndia
  where dtyp2 isnull or dtyp2 !~'^\w'
    union 
  select 
    count(falnr),
    'dtype_ref' 
  from kis.ndia
  where dtype_ref isnull or dtype_ref !~'^\w'
    union 
  select 
    count(falnr),
    'dia_link' 
  from kis.ndia
  where dia_link isnull
    union 
  select 
    count(falnr),
    'ccl' 
  from kis.ndia
  where ccl isnull
    union 
  select 
    count(falnr),
    'dia_valdt' 
  from kis.ndia
  where dia_valdt isnull
    union 
  select 
    count(falnr),
    'dia_pia_som' 
  from kis.ndia
  where dia_pia_som isnull
    union 
  select 
    count(falnr),
    'retrievaldate' 
  from kis.ndia
  where retrievaldate isnull
  order by quantity, "columns"
; 


-- Diagnosekatalog 1. Diagnose
--drop view if exists kis.dqa_ndia_dkat1;
create or replace view kis.dqa_ndia_dkat1
as
select 
  count(falnr) quantity, 
  case 
    when n.dkat1 ~'^\w' then n.dkat1 
    else null
  end dkat1
from kis.ndia n
group by n.dkat1
order by quantity desc
;

create or replace view kis.dqa_ndia_dkat1_jahr
as
select 
  count(falnr) quantity,
  case
    when n.dkat1 ~'\w' then n.dkat1 
    else null
  end dkat1 ,
  date_part('year', erdat) jahr 
from kis.ndia n 
group by dkat1 , jahr
order by jahr desc, quantity desc
;

-- Diagnosekatalog 2. Diagnose
--drop view if exists kis.dqa_ndia_dkat2;
create or replace view kis.dqa_ndia_dkat2
as
select 
  count(falnr) quantity, 
  case 
    when n.dkat2 ~'^\w' then n.dkat2 
    else null
  end dkat2
from kis.ndia n
group by n.dkat2
order by quantity desc
;


create or replace view kis.dqa_ndia_dkat2_jahr
as
select 
  count(falnr) quantity,
  case
    when n.dkat2 ~'\w' then n.dkat2 
    else null
  end dkat2 ,
  date_part('year', erdat) jahr 
from kis.ndia n 
group by dkat2 , jahr
order by jahr desc, quantity desc
;
-- icd10gm 1. Diagnosedate_part('year', erdat) jahr
--drop view if exists kis.dqa_ndia_dkey1;
create or replace view kis.dqa_ndia_dkey1
as
select 
  count(falnr) quantity, 
  case 
    when n.dkey1 ~'^\w' then n.dkey1 
    else null
  end dkey1,
  normcode icd10gm,
  titel
from kis.ndia n
left join icd_metainfo.icd10gm ig
  on n.dkey1 = ig.normcode 
group by n.dkey1, titel, normcode 
order by quantity desc
;

create or replace view kis.dqa_ndia_dkey1_jahr
as
select 
  date_part('year', erdat) jahr,
  count(falnr) quantity, 
  case 
    when n.dkey1 ~'^\w' then n.dkey1 
    else null
  end dkey1, 
  normcode icd10gm,
  titel
from kis.ndia n
left join icd_metainfo.icd10gm ig
  on n.dkey1 = ig.normcode 
group by n.dkey1, titel, normcode, jahr 
order by jahr desc, quantity desc
;

-- icd10gm 2. Diagnose
--drop view if exists kis.dqa_ndia_dkey2;
create or replace view kis.dqa_ndia_dkey2
as
select 
  count(falnr) quantity, 
  case 
    when n.dkey2 ~'^\w' then n.dkey2 
    else null
  end dkey2,
  normcode icd10gm,
  titel
from kis.ndia n
left join icd_metainfo.icd10gm ig
  on n.dkey2 = ig.normcode 
group by n.dkey2, titel, normcode 
order by quantity desc
;

create or replace view kis.dqa_ndia_dkey2_jahr
as
select 
  date_part('year', erdat) jahr,
  count(falnr) quantity, 
  case 
    when n.dkey2 ~'^\w' then n.dkey2
    else null
  end dkey2, 
  normcode icd10gm,
  titel
from kis.ndia n
left join icd_metainfo.icd10gm ig
  on n.dkey2 = ig.normcode 
group by n.dkey2, titel, normcode, jahr 
order by jahr desc, quantity desc
;

-- Katalog-ID des Referenzkatalogs
create or replace view kis.dqa_ndia_dkat_ref
as
select 
  count(falnr) quantity, 
  case 
    when n.dkat_ref ~'^\w' then n.dkat_ref 
    else null
  end dkat_ref 
from kis.ndia n
group by n.dkat_ref 
order by quantity desc
;

create or replace view kis.dqa_ndia_dkat_ref_jahr
as
select 
  date_part('year', erdat) jahr,
  count(falnr) quantity, 
  case 
    when n.dkat_ref ~'^\w' then n.dkat_ref 
    else null
  end dkat_ref 
from kis.ndia n
group by n.dkat_ref, jahr 
order by jahr desc, quantity desc
;

-- Schlüsselung einer Referenzdiagnose für Statistiken
create or replace view kis.dqa_ndia_dkey_ref
as
select 
  count(falnr) quantity, 
  case 
    when n.dkey_ref ~'^\w' then n.dkey_ref 
    else null
  end dkey_ref ,
  normcode icd10gm,
  titel
from kis.ndia n
left join icd_metainfo.icd10gm ig
  on n.dkey_ref = ig.normcode 
group by n.dkey_ref , titel, normcode 
order by quantity desc
;

create or replace view kis.dqa_ndia_dkey_ref_jahr
as
select
  date_part('year', erdat) jahr,
  count(falnr) quantity, 
  case 
    when n.dkey_ref ~'^\w' then n.dkey_ref 
    else null
  end dkey_ref ,
  normcode icd10gm,
  titel
from kis.ndia n
left join icd_metainfo.icd10gm ig
  on n.dkey_ref = ig.normcode 
group by n.dkey_ref, titel, normcode, jahr 
order by jahr desc, quantity desc
;

-- Datum, an dem die Diagnose erstellt wurde
create or replace view kis.dqa_ndia_diadt
as
select 
  count(falnr) quantity, 
  diadt
from kis.ndia n
group by n.diadt 
order by quantity desc
;

create or replace view kis.dqa_ndia_diadt_jahr
as
select 
  date_part('year', erdat) jahr,
  count(falnr) quantity, 
  diadt
from kis.ndia n
group by n.diadt, jahr
order by jahr desc, quantity desc
;

-- Uhrzeit der Diagnoseerstellung
create or replace view kis.dqa_ndia_diazt
as
select 
  count(falnr) quantity, 
  diazt
from kis.ndia n
group by n.diazt 
order by quantity desc
;

create or replace view kis.dqa_ndia_diazt_jahr
as
select 
  date_part('year', erdat) jahr,
  count(falnr) quantity, 
  diazt
from kis.ndia n
group by n.diazt, jahr
order by jahr desc, quantity desc
;

-- Anzahl Operationen
create or replace view kis.dqa_ndia_anzop
as
select 
  count(falnr) quantity, 
  anzop 
from kis.ndia n
group by n.anzop 
order by quantity desc
;

create or replace view kis.dqa_ndia_anzop_jahr
as
select 
  date_part('year', erdat) jahr, 
  count(falnr) quantity, 
  anzop 
from kis.ndia n
group by n.anzop, jahr 
order by jahr desc, quantity desc
;

-- Kennzeichen Einweisungs- bzw. Überweisungsdiagnose
create or replace view kis.dqa_ndia_ewdia
as
select 
  count(falnr) quantity, 
  ewdia 
from kis.ndia n
group by n.ewdia 
order by quantity desc
;

create or replace view kis.dqa_ndia_ewdia_jahr
as
select 
  date_part('year', erdat) jahr, 
  count(falnr) quantity, 
  ewdia 
from kis.ndia n
group by n.ewdia, jahr 
order by jahr desc, quantity desc
;

-- Kennzeichen Behandlungsdiagnose
create or replace view kis.dqa_ndia_bhdia
as
select 
  count(falnr) quantity, 
  bhdia 
from kis.ndia n
group by n.bhdia 
order by quantity desc
;

create or replace view kis.dqa_ndia_bhdia_jahr
as
select 
  date_part('year', erdat) jahr, 
  count(falnr) quantity, 
  bhdia 
from kis.ndia n
group by n.bhdia, jahr 
order by jahr desc, quantity desc
;

-- Kennzeichen Aufnahmediagnose
create or replace view kis.dqa_ndia_afdia
as
select 
  count(falnr) quantity, 
  afdia 
from kis.ndia n
group by n.afdia 
order by quantity desc
;

create or replace view kis.dqa_ndia_afdia_jahr
as
select 
  date_part('year', erdat) jahr, 
  count(falnr) quantity, 
  afdia 
from kis.ndia n
group by n.afdia, jahr 
order by jahr desc, quantity desc
;

-- Kennzeichen Entlassungsdiagnose
create or replace view kis.dqa_ndia_endia
as
select 
  count(falnr) quantity, 
  endia 
from kis.ndia n
group by n.endia 
order by quantity desc
;

create or replace view kis.dqa_ndia_endia_jahr
as
select 
  date_part('year', erdat) jahr,
  count(falnr) quantity, 
  endia 
from kis.ndia n
group by jahr, n.endia 
order by jahr desc, quantity desc
;

-- Kennzeichen Fachabteilungshauptdiagnose
create or replace view kis.dqa_ndia_fhdia
as
select 
  count(falnr) quantity, 
  fhdia 
from kis.ndia n
group by n.fhdia 
order by quantity desc
;

create or replace view kis.dqa_ndia_fhdia_jahr
as
select 
  date_part('year', erdat) jahr, 
  count(falnr) quantity, 
  fhdia 
from kis.ndia n
group by jahr, n.fhdia 
order by jahr desc, quantity desc
;


-- Kennzeichen Krankenhaus-Hauptdiagnose
create or replace view kis.dqa_ndia_khdia
as
select 
  count(falnr) quantity, 
  khdia 
from kis.ndia n
group by n.khdia 
order by quantity desc
;

create or replace view kis.dqa_ndia_khdia_jahr
as
select 
  date_part('year', erdat) jahr, 
  count(falnr) quantity, 
  khdia 
from kis.ndia n
group by jahr, n.khdia 
order by jahr desc, quantity desc
;

-- Kennzeichen Operationsdiagnose
create or replace view kis.dqa_ndia_opdia
as
select 
  count(falnr) quantity, 
  opdia 
from kis.ndia n
group by n.opdia 
order by quantity desc
;

create or replace view kis.dqa_ndia_opdia_jahr
as
select 
  date_part('year', erdat) jahr, 
  count(falnr) quantity, 
  opdia 
from kis.ndia n
group by jahr, n.opdia 
order by jahr desc, quantity desc
;


-- Sperrkennzeichen
create or replace view kis.dqa_ndia_sperr
as
select 
  count(falnr) quantity, 
  sperr
from kis.ndia n
group by n.sperr 
order by quantity desc
;

create or replace view kis.dqa_ndia_sperr_jahr
as
select 
  date_part('year', erdat) jahr, 
  count(falnr) quantity, 
  sperr
from kis.ndia n
group by jahr, n.sperr 
order by jahr desc, quantity desc
;


-- Grad der Sicherheit der Diagnose
create or replace view kis.dqa_ndia_diasi
as
select 
  count(falnr) quantity, 
  case 
    when n.diasi ~'^\w' then n.diasi 
    else null
  end diasi 
from kis.ndia n
group by n.diasi 
order by quantity desc
;

create or replace view kis.dqa_ndia_diasi_jahr
as
select 
  date_part('year', erdat) jahr, 
  count(falnr) quantity, 
  case 
    when n.diasi ~'^\w' then n.diasi 
    else null
  end diasi 
from kis.ndia n
group by n.diasi, jahr 
order by jahr desc, quantity desc
;

-- Datum, an dem der Satz hinzugefügt wurde
create or replace view kis.dqa_ndia_erdat
as
select 
  count(falnr) quantity, 
  erdat 
from kis.ndia n
group by n.erdat 
order by quantity desc
;

create or replace view kis.dqa_ndia_erdat_jahr
as
select 
  date_part('year', erdat) jahr, 
  count(falnr) quantity, 
  erdat 
from kis.ndia n
group by jahr, n.erdat 
order by jahr desc, quantity desc
;

-- Änderungsdatum
create or replace view kis.dqa_ndia_updat
as
select 
  count(falnr) quantity, 
  updat 
from kis.ndia n
group by n.updat 
order by quantity desc
;

create or replace view kis.dqa_ndia_updat_jahr
as
select 
  date_part('year', erdat) jahr, 
  count(falnr) quantity, 
  updat 
from kis.ndia n
group by jahr, n.updat 
order by jahr desc, quantity desc
;

-- Stornokennzeichen
create or replace view kis.dqa_ndia_storn
as
select 
  count(falnr) quantity, 
  storn 
from kis.ndia n
group by n.storn 
order by quantity desc
;

create or replace view kis.dqa_ndia_storn_jahr
as
select 
  date_part('year', erdat) jahr, 
  count(falnr) quantity, 
  storn 
from kis.ndia n
group by jahr, n.storn 
order by jahr desc, quantity desc
;


-- Stornierungsdatum
create or replace view kis.dqa_ndia_stdat
as
select 
  count(falnr) quantity, 
  stdat 
from kis.ndia n
group by n.stdat 
order by quantity desc
;

create or replace view kis.dqa_ndia_stdat_jahr
as
select 
  date_part('year', erdat) jahr, 
  count(falnr) quantity, 
  stdat 
from kis.ndia n
group by jahr, n.stdat 
order by jahr desc, quantity desc
;


-- Kennzeichen Arbeitsdiagnose
create or replace view kis.dqa_ndia_ardia
as
select 
  count(falnr) quantity, 
  ardia 
from kis.ndia n
group by n.ardia 
order by quantity desc
;

create or replace view kis.dqa_ndia_ardia_jahr
as
select 
  date_part('year', erdat) jahr, 
  count(falnr) quantity, 
  ardia 
from kis.ndia n
group by jahr, n.ardia 
order by jahr desc, quantity desc
;

-- Kennzeichen Präoperative Diagnose
create or replace view kis.dqa_ndia_podia
as
select 
  count(falnr) quantity, 
  podia 
from kis.ndia n
group by n.podia 
order by quantity desc
;

create or replace view kis.dqa_ndia_podia_jahr
as
select 
  date_part('year', erdat) jahr, 
  count(falnr) quantity, 
  podia 
from kis.ndia n
group by jahr, n.podia 
order by jahr desc, quantity desc
;

-- Kennzeichen Todesursache
create or replace view kis.dqa_ndia_tudia
as
select 
  count(falnr) quantity, 
  tudia 
from kis.ndia n
group by n.tudia 
order by quantity desc
;

create or replace view kis.dqa_ndia_tudia_jahr
as
select 
  date_part('year', erdat) jahr, 
  count(falnr) quantity, 
  tudia 
from kis.ndia n
group by jahr, n.tudia 
order by jahr desc, quantity desc
;

-- Diagnosenbezug
create or replace view kis.dqa_ndia_diabz
as
select 
  count(falnr) quantity, 
  diabz 
from kis.ndia n
group by n.diabz 
order by quantity desc
;

create or replace view kis.dqa_ndia_diabz_jahr
as
select 
  date_part('year', erdat) jahr, 
  count(falnr) quantity, 
  diabz 
from kis.ndia n
group by jahr, n.diabz 
order by jahr desc, quantity desc
;

--  Kennzeichen Medizinische Nebendiagnose
create or replace view kis.dqa_ndia_diapr
as
select 
  count(falnr) quantity, 
  case 
    when n.diapr ~'^\w' then n.diapr
    else null
  end diapr 
from kis.ndia n
group by n.diapr 
order by quantity desc
;

create or replace view kis.dqa_ndia_diapr_jahr
as
select 
   date_part('year', erdat) jahr,
  count(falnr) quantity, 
  case 
    when n.diapr ~'^\w' then n.diapr
    else null
  end diapr 
from kis.ndia n
group by n.diapr, jahr
order by jahr desc, quantity desc
;

-- Diagnostische Gewissheit ------------------------------------------------------------------------
create or replace view kis.dqa_ndia_diagw
as
select 
  count(falnr) quantity, 
  case 
    when n.diagw ~'^\w' then n.diagw 
    else null
  end diagw
from kis.ndia n
group by n.diagw
order by quantity desc
;

create or replace view kis.dqa_ndia_diagw_jahr
as
select 
  date_part('year', erdat) jahr, 
  count(falnr) quantity, 
  case 
    when n.diagw ~'^\w' then n.diagw 
    else null
  end diagw
from kis.ndia n
group by n.diagw, jahr
order by jahr desc, quantity desc
;

-- Diagnosenzusatz ----------------------------------------------------------
create or replace view kis.dqa_ndia_diazs
as
select 
  count(falnr) quantity, 
  case 
    when n.diazs ~'^\w' then n.diazs 
    else null
  end diazs
from kis.ndia n
group by n.diazs
order by quantity desc
;

create or replace view kis.dqa_ndia_diazs_jahr
as
select 
  date_part('year', erdat) jahr,
  count(falnr) quantity, 
  case 
    when n.diazs ~'^\w' then n.diazs 
    else null
  end diazs
from kis.ndia n
group by n.diazs, jahr
order by jahr desc, quantity desc
;

-- Lokalisation einer Diagnose
create or replace view kis.dqa_ndia_dialo
as
select 
  count(falnr) quantity, 
  case 
    when n.dialo ~'^\w' then n.dialo
    else null
  end dialo
from kis.ndia n
group by n.dialo
order by quantity desc
;

create or replace view kis.dqa_ndia_dialo_jahr
as
select 
  date_part('year', erdat) jahr, 
  count(falnr) quantity, 
  case 
    when n.dialo ~'^\w' then n.dialo
    else null
  end dialo
from kis.ndia n
group by jahr, n.dialo
order by jahr desc, quantity desc
;

-- Fallpauschale
create or replace view kis.dqa_ndia_diafp
as
select 
  count(falnr) quantity, 
  case 
    when n.diafp ~'^\w' then n.diafp
    else null
  end diafp
from kis.ndia n
group by n.diafp
order by quantity desc
;

create or replace view kis.dqa_ndia_diafp_jahr
as
select 
  date_part('year', erdat) jahr, 
  count(falnr) quantity, 
  case 
    when n.diafp ~'^\w' then n.diafp
    else null
  end diafp
from kis.ndia n
group by jahr, n.diafp
order by jahr desc , quantity desc
;

-- Fortlaufende Nummer einer DRG-Diagnose
create or replace view kis.dqa_ndia_drg_dia_seqno
as
select 
  count(falnr) quantity, 
  drg_dia_seqno 
from kis.ndia n
group by n.drg_dia_seqno 
order by quantity desc
;

create or replace view kis.dqa_ndia_drg_dia_seqno_jahr
as
select 
  date_part('year', erdat) jahr, 
  count(falnr) quantity, 
  drg_dia_seqno 
from kis.ndia n
group by jahr, n.drg_dia_seqno 
order by jahr desc, quantity desc
;

-- Kategorie einer DRG-Diagnose (Haupt- Neben) ------------------------------------------------------
create or replace view kis.dqa_ndia_drg_category
as
select 
  count(falnr) quantity, 
  case 
    when n.drg_category ~'^\w' then n.drg_category 
    else null
  end drg_category 
from kis.ndia n
group by n.drg_category 
order by quantity desc
;

create or replace view kis.dqa_ndia_drg_category_jahr
as
select 
  date_part('year', erdat) jahr, 
  count(falnr) quantity, 
  case 
    when n.drg_category ~'^\w' then n.drg_category 
    else null
  end drg_category 
from kis.ndia n
group by jahr, n.drg_category 
order by jahr desc , quantity desc
;

-- Kennzeichen für DRG-Ermittlung verwendet
create or replace view kis.dqa_ndia_drg_relvant
as
select 
  count(falnr) quantity, 
  drg_relvant 
from kis.ndia n
group by n.drg_relvant 
order by quantity desc
;

create or replace view kis.dqa_ndia_drg_relvant_jahr
as
select 
  date_part('year', erdat) jahr, 
  count(falnr) quantity, 
  drg_relvant 
from kis.ndia n
group by jahr, n.drg_relvant 
order by jahr desc, quantity desc
;


-- Typ für ICD-10-Diagnosen 1. Diagnose
create or replace view kis.dqa_ndia_dtyp1
as
select 
  count(falnr) quantity, 
  case 
    when n.dtyp1 in('!', '*', '+') then n.dtyp1 
    else null
  end dtyp1 
from kis.ndia n
group by n.dtyp1 
order by quantity desc
;

create or replace view kis.dqa_ndia_dtyp1_jahr
as
select 
  date_part('year', erdat) jahr, 
  count(falnr) quantity, 
  case 
    when n.dtyp1 in('!', '*', '+') then n.dtyp1 
    else null
  end dtyp1 
from kis.ndia n
group by jahr, n.dtyp1 
order by jahr desc, quantity desc
;

-- Typ für ICD-10-Diagnosen 2. Diagnose
create or replace view kis.dqa_ndia_dtyp2
as
select 
  count(falnr) quantity, 
  case 
    when n.dtyp2 in('!', '*', '+') then n.dtyp2 
    else null
  end dtyp2
from kis.ndia n
group by n.dtyp2 
order by quantity desc
;

create or replace view kis.dqa_ndia_dtyp2_jahr
as
select 
  date_part('year', erdat) jahr, 
  count(falnr) quantity, 
  case 
    when n.dtyp2 in('!', '*', '+') then n.dtyp2 
    else null
  end dtyp2
from kis.ndia n
group by jahr, n.dtyp2 
order by jahr desc, quantity desc
;

-- Typ für ICD-10-Diagnosen
create or replace view kis.dqa_ndia_dtye_ref
as
select 
  count(falnr) quantity, 
  case 
    when n.dtype_ref in('!', '*', '+') then n.dtype_ref 
    else null
  end dtype_ref 
from kis.ndia n
group by n.dtype_ref 
order by quantity desc
;

create or replace view kis.dqa_ndia_dtye_ref_jahr
as
select 
  date_part('year', erdat) jahr, 
  count(falnr) quantity, 
  case 
    when n.dtype_ref in('!', '*', '+') then n.dtype_ref 
    else null
  end dtype_ref 
from kis.ndia n
group by jahr, n.dtype_ref 
order by jahr desc, quantity desc
;

-- Verweis auf eine andere Diagnose
create or replace view kis.dqa_ndia_dia_link
as
select 
  count(falnr) quantity, 
  dia_link 
from kis.ndia n
group by n.dia_link 
order by quantity desc
;

create or replace view kis.dqa_ndia_dia_link_jahr
as
select 
  date_part('year', erdat) jahr, 
  count(falnr) quantity, 
  dia_link 
from kis.ndia n
group by n.dia_link, jahr 
order by jahr desc, quantity desc
;

-- Komplikationslevel der Diagnosen (für DRFs) --------------------------------------------------------------------------
create or replace view kis.dqa_ndia_ccl
as
select 
  count(falnr) quantity, 
  ccl 
from kis.ndia n
group by n.ccl 
order by quantity desc
;

create or replace view kis.dqa_ndia_ccl_jahr
as
select 
  date_part('year', erdat) jahr, 
  count(falnr) quantity, 
  ccl 
from kis.ndia n
group by jahr, n.ccl 
order by jahr desc, quantity desc
;

-- Gültigkeit der Diagnose
create or replace view kis.dqa_ndia_dia_valdt
as
select 
  count(falnr) quantity, 
  dia_valdt 
from kis.ndia n
group by n.dia_valdt 
order by quantity desc
;

create or replace view kis.dqa_ndia_dia_valdt_jahr
as
select 
  date_part('year', erdat) jahr,
  count(falnr) quantity, 
  dia_valdt 
from kis.ndia n
group by jahr, n.dia_valdt 
order by jahr desc, quantity desc
;

-- PIA – Somatische Diagnose
create or replace view kis.dqa_ndia_dia_pia_som
as
select 
  count(falnr) quantity, 
  dia_pia_som 
from kis.ndia n
group by n.dia_pia_som 
order by quantity desc
;

create or replace view kis.dqa_ndia_dia_pia_som_jahr
as
select 
  date_part('year', erdat) jahr,
  count(falnr) quantity, 
  dia_pia_som 
from kis.ndia n
group by jahr, n.dia_pia_som 
order by jahr desc, quantity desc
;
/*
*/