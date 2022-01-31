-- DQA Views für KIS.NBEW
--drop view if exists kis.dqa_nbew_null_values cascade;
create or replace view kis.dqa_nbew_null_values
as
select
  count(n.falnr) quantity,
  'einri' "columns"
from kis.nbew n
where einri isnull or einri !~'^\w'
  union
select
  count(n.falnr) quantity,
  'falnr' "columns"
from kis.nbew n
where falnr isnull or falnr !~'^\w'
  union
select
  count(n.falnr) quantity,
  'lfdbew' "columns"
from kis.nbew n
where lfdbew isnull
  union
select
  count(n.falnr) quantity,
  'bewty' "columns"
from kis.nbew n
where bewty isnull or bewty !~'^\w'
  union
select
  count(n.falnr) quantity,
  'bwart' "columns"
from kis.nbew n
where bwart isnull or bwart !~'^\w'
  union
select
  count(n.falnr) quantity,
  'bwidt' "columns"
from kis.nbew n
where bwidt isnull
  union
select
  count(n.falnr) quantity,
  'bwizt' "columns"
from kis.nbew n
where bwizt isnull
  union
select
  count(n.falnr) quantity,
  'planb' "columns"
from kis.nbew n
where planb isnull
  union
select
  count(n.falnr) quantity,
  'statu' "columns"
from kis.nbew n
where statu isnull or statu !~'^\w'
  union
select
  count(n.falnr) quantity,
  'bwedt' "columns"
from kis.nbew n
where bwedt isnull
  union
select
  count(n.falnr) quantity,
  'bwezt' "columns"
from kis.nbew n
where bwezt isnull
  union
select
  count(n.falnr) quantity,
  'plane' "columns"
from kis.nbew n
where plane isnull
  union
select
  count(n.falnr) quantity,
  'lfdref' "columns"
from kis.nbew n
where lfdref isnull
  union
select
  count(n.falnr) quantity,
  'notkz' "columns"
from kis.nbew n
where notkz isnull
  union
select
  count(n.falnr) quantity,
  'unfkz' "columns"
from kis.nbew n
where unfkz isnull or unfkz !~'^\w'
  union
select
  count(n.falnr) quantity,
  'orgfa' "columns"
from kis.nbew n
where orgfa isnull or orgfa !~'^\w'
  union
select
  count(n.falnr) quantity,
  'orgpf' "columns"
from kis.nbew n
where orgpf isnull or orgpf !~'^\w'
  union
select
  count(n.falnr) quantity,
  'zimmr' "columns"
from kis.nbew n
where zimmr isnull or zimmr !~'^\w'
  union
select
  count(n.falnr) quantity,
  'bett' "columns"
from kis.nbew n
where bett isnull or bett !~'^\w'
  union
select
  count(n.falnr) quantity,
  'planr' "columns"
from kis.nbew n
where planr isnull or planr !~'^\w'
  union
select
  count(n.falnr) quantity,
  'orgau' "columns"
from kis.nbew n
where orgau isnull or orgau !~'^\w'
  union
select
  count(n.falnr) quantity,
  'ezust' "columns"
from kis.nbew n
where ezust isnull or ezust !~'^\w'
  union
select
  count(n.falnr) quantity,
  'todur' "columns"
from kis.nbew n
where todur isnull or todur !~'^\w'
  union
select
  count(n.falnr) quantity,
  'erdat' "columns"
from kis.nbew n
where erdat isnull
  union
select
  count(n.falnr) quantity,
  'updat' "columns"
from kis.nbew n
where updat isnull
  union
select
  count(n.falnr) quantity,
  'storn' "columns"
from kis.nbew n
where storn isnull
  union
select
  count(n.falnr) quantity,
  'stdat' "columns"
from kis.nbew n
where stdat isnull
  union
select
  count(n.falnr) quantity,
  'bekat' "columns"
from kis.nbew n
where bekat isnull or bekat !~'^\w'
  union
select
  count(n.falnr) quantity,
  'nfgref' "columns"
from kis.nbew n
where nfgref isnull
  union
select
  count(n.falnr) quantity,
  'vgnref' "columns"
from kis.nbew n
where vgnref isnull
  union
select
  count(n.falnr) quantity,
  'stoid' "columns"
from kis.nbew n
where stoid isnull or stoid !~'^\w'
  union
select
  count(n.falnr) quantity,
  'dspty' "columns"
from kis.nbew n
where dspty isnull or dspty !~'^\w'
  union
select
  count(n.falnr) quantity,
  'visty' "columns"
from kis.nbew n
where visty isnull or visty !~'^\w'
  union
select
  count(n.falnr) quantity,
  'bwgr1' "columns"
from kis.nbew n
where bwgr1 isnull or bwgr1 !~'^\w'
  union
select
  count(n.falnr) quantity,
  'bwgr2' "columns"
from kis.nbew n
where bwgr2 isnull or bwgr2 !~'^\w'
  union
select
  count(n.falnr) quantity,
  'tpart' "columns"
from kis.nbew n
where tpart isnull or tpart !~'^\w'
  union
select
  count(n.falnr) quantity,
  'unfvs' "columns"
from kis.nbew n
where unfvs isnull
  union
select
  count(n.falnr) quantity,
  'insev' "columns"
from kis.nbew n
where insev isnull or insev !~'^\w'
  union
select
  count(n.falnr) quantity,
  'opart' "columns"
from kis.nbew n
where opart isnull or opart !~'^\w'
  union
select
  count(n.falnr) quantity,
  '"class"' "columns"
from kis.nbew n
where "class" isnull or "class" !~'^\w'
  union
select
  count(n.falnr) quantity,
  'rfsrc' "columns"
from kis.nbew n
where rfsrc isnull or rfsrc !~'^\w'
  union
select
  count(n.falnr) quantity,
  'fachr' "columns"
from kis.nbew n
where fachr isnull or fachr !~'^\w'
  union
select
  count(n.falnr) quantity,
  'unfrt' "columns"
from kis.nbew n
where unfrt isnull or unfrt !~'^\w'
  union
select
  count(n.falnr) quantity,
  'unfav' "columns"
from kis.nbew n
where unfav isnull or unfav !~'^\w'
order by quantity, "columns"
;

--Einrichtung
--drop view if exists kis.dqa_nbew_einri cascade;
create or replace view kis.dqa_nbew_einri
as
select
  count(falnr) quantity,
  case
    when n.einri ~'^\w' then n.einri
    else null
  end einri
from kis.nbew n
group by n.einri
--left join metadata_repository.einri mr
--  on mr.sourceid = n.einri
order by quantity desc
;

-- Einrichtung Jahr
--drop view if exists kis.dqa_nbew_einri_jahr cascade;
create or replace view kis.dqa_nbew_einri_jahr
as
select
  date_part('year', erdat) jahr,
  count(falnr) quantity,
  case
    when n.einri ~'^\w' then n.einri
    else null
  end einri
from kis.nbew n
-- left join metadata_repository.einri mr
--    on mr.sourceid = n.einri
group by jahr, n.einri
order by jahr, quantity desc
;

--Fallnummer
--drop view if exists kis.dqa_nbew_falnr cascade;
create or replace view kis.dqa_nbew_falnr
as
select
  count(falnr) quantity,
  case
    when n.falnr ~'^\w' then n.falnr
    else null
  end falnr
from kis.nbew n
group by n.falnr
--left join metadata_repository.falnr mr
--  on mr.sourceid = n.falnr
order by quantity desc
;

-- Fallnummer Jahr
--drop view if exists kis.dqa_nbew_falnr_jahr cascade;
create or replace view kis.dqa_nbew_falnr_jahr
as
select
  date_part('year', erdat) jahr,
  count(falnr) quantity,
  case
    when n.falnr ~'^\w' then n.falnr
    else null
  end falnr
from kis.nbew n
-- left join metadata_repository.falnr mr
--    on mr.sourceid = n.falnr
group by jahr, n.falnr
order by jahr, quantity desc
;

--Laufende Nummer einer Bewegung
--drop view if exists kis.dqa_nbew_lfdbew cascade;
create or replace view kis.dqa_nbew_lfdbew
as
select
  count(falnr) quantity,
  lfdbew
from kis.nbew n
group by n.lfdbew
order by quantity desc
;

-- Laufende Nummer einer Bewegung Jahr
--drop view if exists kis.dqa_nbew_lfdbew_jahr cascade;
create or replace view kis.dqa_nbew_lfdbew_jahr
as
select
  date_part('year', erdat) jahr,
  count(falnr) quantity,
  lfdbew
from kis.nbew n
group by jahr, n.lfdbew
order by jahr, quantity desc
;

-- Bewegungstyp
drop view if exists kis.dqa_nbew_bewty cascade;
create or replace view kis.dqa_nbew_bewty
as
select
  count(falnr) quantity,
  case
    when n.bewty ~'^\w' then n.bewty
    else null
  end bewty,
  mr.bewegunstyp bewegungstyp 
from kis.nbew n
left join metadata_repository.bewegunstyp mr
  on mr.bewty = n.bewty
group by n.bewty, mr.bewegunstyp 
order by quantity desc
;

-- Bewegungstyp Jahr
drop view if exists kis.dqa_nbew_bewty_jahr cascade;
create or replace view kis.dqa_nbew_bewty_jahr
as
select
  date_part('year', erdat) jahr,
  count(falnr) quantity,
  case
    when n.bewty ~'^\w' then n.bewty
    else null
  end bewty,
  mr.bewegunstyp bewegungstyp 
from kis.nbew n
left join metadata_repository.bewegunstyp mr
  on mr.bewty = n.bewty
group by jahr, n.bewty, mr.bewegunstyp 
order by jahr, quantity desc
;

-- Bewegungsart
--drop view if exists kis.dqa_nbew_bwart cascade;
--create or replace view kis.dqa_nbew_bwart
--as
select
  count(falnr) quantity,
  case
    when n.bwart ~'^\w' then n.bwart
    else null
  end bwart,
  mr.bewegunsart bewegunsgart 
from kis.nbew n
left join metadata_repository.bewegunsart mr
  on mr.bwart = n.bwart
group by n.bwart, mr.bewegunsart 
order by quantity desc
;

-- Bewegungsart Jahr
--drop view if exists kis.dqa_nbew_bwart_jahr cascade;
--create or replace view kis.dqa_nbew_bwart_jahr
--as
select
  date_part('year', erdat) jahr,
  count(falnr) quantity,
  case
    when n.bwart ~'^\w' then n.bwart
    else null
  end bwart
from kis.nbew n
-- left join metadata_repository.bwart mr
--    on mr.sourceid = n.bwart
group by jahr, n.bwart
order by jahr, quantity desc
;

--bwidt
--drop view if exists kis.dqa_nbew_bwidt cascade;
--create or replace view kis.dqa_nbew_bwidt
--as
select
  count(falnr) quantity,
  case
    when n.bwidt ~'^\w' then n.bwidt
    else null
  end bwidt
from kis.nbew n
group by n.bwidt
--left join metadata_repository.bwidt mr
--  on mr.sourceid = n.bwidt
order by quantity desc
;

-- bwidt Jahr
--drop view if exists kis.dqa_nbew_bwidt_jahr cascade;
--create or replace view kis.dqa_nbew_bwidt_jahr
--as
select
  date_part('year', erdat) jahr,
  count(falnr) quantity,
  case
    when n.bwidt ~'^\w' then n.bwidt
    else null
  end bwidt
from kis.nbew n
-- left join metadata_repository.bwidt mr
--    on mr.sourceid = n.bwidt
group by jahr, n.bwidt
order by jahr, quantity desc
;

--bwizt
--drop view if exists kis.dqa_nbew_bwizt cascade;
--create or replace view kis.dqa_nbew_bwizt
--as
select
  count(falnr) quantity,
  case
    when n.bwizt ~'^\w' then n.bwizt
    else null
  end bwizt
from kis.nbew n
group by n.bwizt
--left join metadata_repository.bwizt mr
--  on mr.sourceid = n.bwizt
order by quantity desc
;

-- bwizt Jahr
--drop view if exists kis.dqa_nbew_bwizt_jahr cascade;
--create or replace view kis.dqa_nbew_bwizt_jahr
--as
select
  date_part('year', erdat) jahr,
  count(falnr) quantity,
  case
    when n.bwizt ~'^\w' then n.bwizt
    else null
  end bwizt
from kis.nbew n
-- left join metadata_repository.bwizt mr
--    on mr.sourceid = n.bwizt
group by jahr, n.bwizt
order by jahr, quantity desc
;

--planb
--drop view if exists kis.dqa_nbew_planb cascade;
--create or replace view kis.dqa_nbew_planb
--as
select
  count(falnr) quantity,
  case
    when n.planb ~'^\w' then n.planb
    else null
  end planb
from kis.nbew n
group by n.planb
--left join metadata_repository.planb mr
--  on mr.sourceid = n.planb
order by quantity desc
;

-- planb Jahr
--drop view if exists kis.dqa_nbew_planb_jahr cascade;
--create or replace view kis.dqa_nbew_planb_jahr
--as
select
  date_part('year', erdat) jahr,
  count(falnr) quantity,
  case
    when n.planb ~'^\w' then n.planb
    else null
  end planb
from kis.nbew n
-- left join metadata_repository.planb mr
--    on mr.sourceid = n.planb
group by jahr, n.planb
order by jahr, quantity desc
;

--statu
--drop view if exists kis.dqa_nbew_statu cascade;
--create or replace view kis.dqa_nbew_statu
--as
select
  count(falnr) quantity,
  case
    when n.statu ~'^\w' then n.statu
    else null
  end statu
from kis.nbew n
group by n.statu
--left join metadata_repository.statu mr
--  on mr.sourceid = n.statu
order by quantity desc
;

-- statu Jahr
--drop view if exists kis.dqa_nbew_statu_jahr cascade;
--create or replace view kis.dqa_nbew_statu_jahr
--as
select
  date_part('year', erdat) jahr,
  count(falnr) quantity,
  case
    when n.statu ~'^\w' then n.statu
    else null
  end statu
from kis.nbew n
-- left join metadata_repository.statu mr
--    on mr.sourceid = n.statu
group by jahr, n.statu
order by jahr, quantity desc
;

--bwedt
--drop view if exists kis.dqa_nbew_bwedt cascade;
--create or replace view kis.dqa_nbew_bwedt
--as
select
  count(falnr) quantity,
  case
    when n.bwedt ~'^\w' then n.bwedt
    else null
  end bwedt
from kis.nbew n
group by n.bwedt
--left join metadata_repository.bwedt mr
--  on mr.sourceid = n.bwedt
order by quantity desc
;

-- bwedt Jahr
--drop view if exists kis.dqa_nbew_bwedt_jahr cascade;
--create or replace view kis.dqa_nbew_bwedt_jahr
--as
select
  date_part('year', erdat) jahr,
  count(falnr) quantity,
  case
    when n.bwedt ~'^\w' then n.bwedt
    else null
  end bwedt
from kis.nbew n
-- left join metadata_repository.bwedt mr
--    on mr.sourceid = n.bwedt
group by jahr, n.bwedt
order by jahr, quantity desc
;

--bwezt
--drop view if exists kis.dqa_nbew_bwezt cascade;
--create or replace view kis.dqa_nbew_bwezt
--as
select
  count(falnr) quantity,
  case
    when n.bwezt ~'^\w' then n.bwezt
    else null
  end bwezt
from kis.nbew n
group by n.bwezt
--left join metadata_repository.bwezt mr
--  on mr.sourceid = n.bwezt
order by quantity desc
;

-- bwezt Jahr
--drop view if exists kis.dqa_nbew_bwezt_jahr cascade;
--create or replace view kis.dqa_nbew_bwezt_jahr
--as
select
  date_part('year', erdat) jahr,
  count(falnr) quantity,
  case
    when n.bwezt ~'^\w' then n.bwezt
    else null
  end bwezt
from kis.nbew n
-- left join metadata_repository.bwezt mr
--    on mr.sourceid = n.bwezt
group by jahr, n.bwezt
order by jahr, quantity desc
;

--plane
--drop view if exists kis.dqa_nbew_plane cascade;
--create or replace view kis.dqa_nbew_plane
--as
select
  count(falnr) quantity,
  case
    when n.plane ~'^\w' then n.plane
    else null
  end plane
from kis.nbew n
group by n.plane
--left join metadata_repository.plane mr
--  on mr.sourceid = n.plane
order by quantity desc
;

-- plane Jahr
--drop view if exists kis.dqa_nbew_plane_jahr cascade;
--create or replace view kis.dqa_nbew_plane_jahr
--as
select
  date_part('year', erdat) jahr,
  count(falnr) quantity,
  case
    when n.plane ~'^\w' then n.plane
    else null
  end plane
from kis.nbew n
-- left join metadata_repository.plane mr
--    on mr.sourceid = n.plane
group by jahr, n.plane
order by jahr, quantity desc
;

--lfdref
--drop view if exists kis.dqa_nbew_lfdref cascade;
--create or replace view kis.dqa_nbew_lfdref
--as
select
  count(falnr) quantity,
  case
    when n.lfdref ~'^\w' then n.lfdref
    else null
  end lfdref
from kis.nbew n
group by n.lfdref
--left join metadata_repository.lfdref mr
--  on mr.sourceid = n.lfdref
order by quantity desc
;

-- lfdref Jahr
--drop view if exists kis.dqa_nbew_lfdref_jahr cascade;
--create or replace view kis.dqa_nbew_lfdref_jahr
--as
select
  date_part('year', erdat) jahr,
  count(falnr) quantity,
  case
    when n.lfdref ~'^\w' then n.lfdref
    else null
  end lfdref
from kis.nbew n
-- left join metadata_repository.lfdref mr
--    on mr.sourceid = n.lfdref
group by jahr, n.lfdref
order by jahr, quantity desc
;

--notkz
--drop view if exists kis.dqa_nbew_notkz cascade;
--create or replace view kis.dqa_nbew_notkz
--as
select
  count(falnr) quantity,
  case
    when n.notkz ~'^\w' then n.notkz
    else null
  end notkz
from kis.nbew n
group by n.notkz
--left join metadata_repository.notkz mr
--  on mr.sourceid = n.notkz
order by quantity desc
;

-- notkz Jahr
--drop view if exists kis.dqa_nbew_notkz_jahr cascade;
--create or replace view kis.dqa_nbew_notkz_jahr
--as
select
  date_part('year', erdat) jahr,
  count(falnr) quantity,
  case
    when n.notkz ~'^\w' then n.notkz
    else null
  end notkz
from kis.nbew n
-- left join metadata_repository.notkz mr
--    on mr.sourceid = n.notkz
group by jahr, n.notkz
order by jahr, quantity desc
;

--unfkz
--drop view if exists kis.dqa_nbew_unfkz cascade;
--create or replace view kis.dqa_nbew_unfkz
--as
select
  count(falnr) quantity,
  case
    when n.unfkz ~'^\w' then n.unfkz
    else null
  end unfkz
from kis.nbew n
group by n.unfkz
--left join metadata_repository.unfkz mr
--  on mr.sourceid = n.unfkz
order by quantity desc
;

-- unfkz Jahr
--drop view if exists kis.dqa_nbew_unfkz_jahr cascade;
--create or replace view kis.dqa_nbew_unfkz_jahr
--as
select
  date_part('year', erdat) jahr,
  count(falnr) quantity,
  case
    when n.unfkz ~'^\w' then n.unfkz
    else null
  end unfkz
from kis.nbew n
-- left join metadata_repository.unfkz mr
--    on mr.sourceid = n.unfkz
group by jahr, n.unfkz
order by jahr, quantity desc
;

--orgfa
--drop view if exists kis.dqa_nbew_orgfa cascade;
--create or replace view kis.dqa_nbew_orgfa
--as
select
  count(falnr) quantity,
  case
    when n.orgfa ~'^\w' then n.orgfa
    else null
  end orgfa
from kis.nbew n
group by n.orgfa
--left join metadata_repository.orgfa mr
--  on mr.sourceid = n.orgfa
order by quantity desc
;

-- orgfa Jahr
--drop view if exists kis.dqa_nbew_orgfa_jahr cascade;
--create or replace view kis.dqa_nbew_orgfa_jahr
--as
select
  date_part('year', erdat) jahr,
  count(falnr) quantity,
  case
    when n.orgfa ~'^\w' then n.orgfa
    else null
  end orgfa
from kis.nbew n
-- left join metadata_repository.orgfa mr
--    on mr.sourceid = n.orgfa
group by jahr, n.orgfa
order by jahr, quantity desc
;

--orgpf
--drop view if exists kis.dqa_nbew_orgpf cascade;
--create or replace view kis.dqa_nbew_orgpf
--as
select
  count(falnr) quantity,
  case
    when n.orgpf ~'^\w' then n.orgpf
    else null
  end orgpf
from kis.nbew n
group by n.orgpf
--left join metadata_repository.orgpf mr
--  on mr.sourceid = n.orgpf
order by quantity desc
;

-- orgpf Jahr
--drop view if exists kis.dqa_nbew_orgpf_jahr cascade;
--create or replace view kis.dqa_nbew_orgpf_jahr
--as
select
  date_part('year', erdat) jahr,
  count(falnr) quantity,
  case
    when n.orgpf ~'^\w' then n.orgpf
    else null
  end orgpf
from kis.nbew n
-- left join metadata_repository.orgpf mr
--    on mr.sourceid = n.orgpf
group by jahr, n.orgpf
order by jahr, quantity desc
;

--zimmr
--drop view if exists kis.dqa_nbew_zimmr cascade;
--create or replace view kis.dqa_nbew_zimmr
--as
select
  count(falnr) quantity,
  case
    when n.zimmr ~'^\w' then n.zimmr
    else null
  end zimmr
from kis.nbew n
group by n.zimmr
--left join metadata_repository.zimmr mr
--  on mr.sourceid = n.zimmr
order by quantity desc
;

-- zimmr Jahr
--drop view if exists kis.dqa_nbew_zimmr_jahr cascade;
--create or replace view kis.dqa_nbew_zimmr_jahr
--as
select
  date_part('year', erdat) jahr,
  count(falnr) quantity,
  case
    when n.zimmr ~'^\w' then n.zimmr
    else null
  end zimmr
from kis.nbew n
-- left join metadata_repository.zimmr mr
--    on mr.sourceid = n.zimmr
group by jahr, n.zimmr
order by jahr, quantity desc
;

--bett
--drop view if exists kis.dqa_nbew_bett cascade;
--create or replace view kis.dqa_nbew_bett
--as
select
  count(falnr) quantity,
  case
    when n.bett ~'^\w' then n.bett
    else null
  end bett
from kis.nbew n
group by n.bett
--left join metadata_repository.bett mr
--  on mr.sourceid = n.bett
order by quantity desc
;

-- bett Jahr
--drop view if exists kis.dqa_nbew_bett_jahr cascade;
--create or replace view kis.dqa_nbew_bett_jahr
--as
select
  date_part('year', erdat) jahr,
  count(falnr) quantity,
  case
    when n.bett ~'^\w' then n.bett
    else null
  end bett
from kis.nbew n
-- left join metadata_repository.bett mr
--    on mr.sourceid = n.bett
group by jahr, n.bett
order by jahr, quantity desc
;

--planr
--drop view if exists kis.dqa_nbew_planr cascade;
--create or replace view kis.dqa_nbew_planr
--as
select
  count(falnr) quantity,
  case
    when n.planr ~'^\w' then n.planr
    else null
  end planr
from kis.nbew n
group by n.planr
--left join metadata_repository.planr mr
--  on mr.sourceid = n.planr
order by quantity desc
;

-- planr Jahr
--drop view if exists kis.dqa_nbew_planr_jahr cascade;
--create or replace view kis.dqa_nbew_planr_jahr
--as
select
  date_part('year', erdat) jahr,
  count(falnr) quantity,
  case
    when n.planr ~'^\w' then n.planr
    else null
  end planr
from kis.nbew n
-- left join metadata_repository.planr mr
--    on mr.sourceid = n.planr
group by jahr, n.planr
order by jahr, quantity desc
;

--orgau
--drop view if exists kis.dqa_nbew_orgau cascade;
--create or replace view kis.dqa_nbew_orgau
--as
select
  count(falnr) quantity,
  case
    when n.orgau ~'^\w' then n.orgau
    else null
  end orgau
from kis.nbew n
group by n.orgau
--left join metadata_repository.orgau mr
--  on mr.sourceid = n.orgau
order by quantity desc
;

-- orgau Jahr
--drop view if exists kis.dqa_nbew_orgau_jahr cascade;
--create or replace view kis.dqa_nbew_orgau_jahr
--as
select
  date_part('year', erdat) jahr,
  count(falnr) quantity,
  case
    when n.orgau ~'^\w' then n.orgau
    else null
  end orgau
from kis.nbew n
-- left join metadata_repository.orgau mr
--    on mr.sourceid = n.orgau
group by jahr, n.orgau
order by jahr, quantity desc
;

--ezust
--drop view if exists kis.dqa_nbew_ezust cascade;
--create or replace view kis.dqa_nbew_ezust
--as
select
  count(falnr) quantity,
  case
    when n.ezust ~'^\w' then n.ezust
    else null
  end ezust
from kis.nbew n
group by n.ezust
--left join metadata_repository.ezust mr
--  on mr.sourceid = n.ezust
order by quantity desc
;

-- ezust Jahr
--drop view if exists kis.dqa_nbew_ezust_jahr cascade;
--create or replace view kis.dqa_nbew_ezust_jahr
--as
select
  date_part('year', erdat) jahr,
  count(falnr) quantity,
  case
    when n.ezust ~'^\w' then n.ezust
    else null
  end ezust
from kis.nbew n
-- left join metadata_repository.ezust mr
--    on mr.sourceid = n.ezust
group by jahr, n.ezust
order by jahr, quantity desc
;

--todur
--drop view if exists kis.dqa_nbew_todur cascade;
--create or replace view kis.dqa_nbew_todur
--as
select
  count(falnr) quantity,
  case
    when n.todur ~'^\w' then n.todur
    else null
  end todur
from kis.nbew n
group by n.todur
--left join metadata_repository.todur mr
--  on mr.sourceid = n.todur
order by quantity desc
;

-- todur Jahr
--drop view if exists kis.dqa_nbew_todur_jahr cascade;
--create or replace view kis.dqa_nbew_todur_jahr
--as
select
  date_part('year', erdat) jahr,
  count(falnr) quantity,
  case
    when n.todur ~'^\w' then n.todur
    else null
  end todur
from kis.nbew n
-- left join metadata_repository.todur mr
--    on mr.sourceid = n.todur
group by jahr, n.todur
order by jahr, quantity desc
;

--erdat
--drop view if exists kis.dqa_nbew_erdat cascade;
--create or replace view kis.dqa_nbew_erdat
--as
select
  count(falnr) quantity,
  case
    when n.erdat ~'^\w' then n.erdat
    else null
  end erdat
from kis.nbew n
group by n.erdat
--left join metadata_repository.erdat mr
--  on mr.sourceid = n.erdat
order by quantity desc
;

-- erdat Jahr
--drop view if exists kis.dqa_nbew_erdat_jahr cascade;
--create or replace view kis.dqa_nbew_erdat_jahr
--as
select
  date_part('year', erdat) jahr,
  count(falnr) quantity,
  case
    when n.erdat ~'^\w' then n.erdat
    else null
  end erdat
from kis.nbew n
-- left join metadata_repository.erdat mr
--    on mr.sourceid = n.erdat
group by jahr, n.erdat
order by jahr, quantity desc
;

--updat
--drop view if exists kis.dqa_nbew_updat cascade;
--create or replace view kis.dqa_nbew_updat
--as
select
  count(falnr) quantity,
  case
    when n.updat ~'^\w' then n.updat
    else null
  end updat
from kis.nbew n
group by n.updat
--left join metadata_repository.updat mr
--  on mr.sourceid = n.updat
order by quantity desc
;

-- updat Jahr
--drop view if exists kis.dqa_nbew_updat_jahr cascade;
--create or replace view kis.dqa_nbew_updat_jahr
--as
select
  date_part('year', erdat) jahr,
  count(falnr) quantity,
  case
    when n.updat ~'^\w' then n.updat
    else null
  end updat
from kis.nbew n
-- left join metadata_repository.updat mr
--    on mr.sourceid = n.updat
group by jahr, n.updat
order by jahr, quantity desc
;

--storn
--drop view if exists kis.dqa_nbew_storn cascade;
--create or replace view kis.dqa_nbew_storn
--as
select
  count(falnr) quantity,
  case
    when n.storn ~'^\w' then n.storn
    else null
  end storn
from kis.nbew n
group by n.storn
--left join metadata_repository.storn mr
--  on mr.sourceid = n.storn
order by quantity desc
;

-- storn Jahr
--drop view if exists kis.dqa_nbew_storn_jahr cascade;
--create or replace view kis.dqa_nbew_storn_jahr
--as
select
  date_part('year', erdat) jahr,
  count(falnr) quantity,
  case
    when n.storn ~'^\w' then n.storn
    else null
  end storn
from kis.nbew n
-- left join metadata_repository.storn mr
--    on mr.sourceid = n.storn
group by jahr, n.storn
order by jahr, quantity desc
;

--stdat
--drop view if exists kis.dqa_nbew_stdat cascade;
--create or replace view kis.dqa_nbew_stdat
--as
select
  count(falnr) quantity,
  case
    when n.stdat ~'^\w' then n.stdat
    else null
  end stdat
from kis.nbew n
group by n.stdat
--left join metadata_repository.stdat mr
--  on mr.sourceid = n.stdat
order by quantity desc
;

-- stdat Jahr
--drop view if exists kis.dqa_nbew_stdat_jahr cascade;
--create or replace view kis.dqa_nbew_stdat_jahr
--as
select
  date_part('year', erdat) jahr,
  count(falnr) quantity,
  case
    when n.stdat ~'^\w' then n.stdat
    else null
  end stdat
from kis.nbew n
-- left join metadata_repository.stdat mr
--    on mr.sourceid = n.stdat
group by jahr, n.stdat
order by jahr, quantity desc
;

--bekat
--drop view if exists kis.dqa_nbew_bekat cascade;
--create or replace view kis.dqa_nbew_bekat
--as
select
  count(falnr) quantity,
  case
    when n.bekat ~'^\w' then n.bekat
    else null
  end bekat
from kis.nbew n
group by n.bekat
--left join metadata_repository.bekat mr
--  on mr.sourceid = n.bekat
order by quantity desc
;

-- bekat Jahr
--drop view if exists kis.dqa_nbew_bekat_jahr cascade;
--create or replace view kis.dqa_nbew_bekat_jahr
--as
select
  date_part('year', erdat) jahr,
  count(falnr) quantity,
  case
    when n.bekat ~'^\w' then n.bekat
    else null
  end bekat
from kis.nbew n
-- left join metadata_repository.bekat mr
--    on mr.sourceid = n.bekat
group by jahr, n.bekat
order by jahr, quantity desc
;

--nfgref
--drop view if exists kis.dqa_nbew_nfgref cascade;
--create or replace view kis.dqa_nbew_nfgref
--as
select
  count(falnr) quantity,
  case
    when n.nfgref ~'^\w' then n.nfgref
    else null
  end nfgref
from kis.nbew n
group by n.nfgref
--left join metadata_repository.nfgref mr
--  on mr.sourceid = n.nfgref
order by quantity desc
;

-- nfgref Jahr
--drop view if exists kis.dqa_nbew_nfgref_jahr cascade;
--create or replace view kis.dqa_nbew_nfgref_jahr
--as
select
  date_part('year', erdat) jahr,
  count(falnr) quantity,
  case
    when n.nfgref ~'^\w' then n.nfgref
    else null
  end nfgref
from kis.nbew n
-- left join metadata_repository.nfgref mr
--    on mr.sourceid = n.nfgref
group by jahr, n.nfgref
order by jahr, quantity desc
;

--vgnref
--drop view if exists kis.dqa_nbew_vgnref cascade;
--create or replace view kis.dqa_nbew_vgnref
--as
select
  count(falnr) quantity,
  case
    when n.vgnref ~'^\w' then n.vgnref
    else null
  end vgnref
from kis.nbew n
group by n.vgnref
--left join metadata_repository.vgnref mr
--  on mr.sourceid = n.vgnref
order by quantity desc
;

-- vgnref Jahr
--drop view if exists kis.dqa_nbew_vgnref_jahr cascade;
--create or replace view kis.dqa_nbew_vgnref_jahr
--as
select
  date_part('year', erdat) jahr,
  count(falnr) quantity,
  case
    when n.vgnref ~'^\w' then n.vgnref
    else null
  end vgnref
from kis.nbew n
-- left join metadata_repository.vgnref mr
--    on mr.sourceid = n.vgnref
group by jahr, n.vgnref
order by jahr, quantity desc
;

--stoid
--drop view if exists kis.dqa_nbew_stoid cascade;
--create or replace view kis.dqa_nbew_stoid
--as
select
  count(falnr) quantity,
  case
    when n.stoid ~'^\w' then n.stoid
    else null
  end stoid
from kis.nbew n
group by n.stoid
--left join metadata_repository.stoid mr
--  on mr.sourceid = n.stoid
order by quantity desc
;

-- stoid Jahr
--drop view if exists kis.dqa_nbew_stoid_jahr cascade;
--create or replace view kis.dqa_nbew_stoid_jahr
--as
select
  date_part('year', erdat) jahr,
  count(falnr) quantity,
  case
    when n.stoid ~'^\w' then n.stoid
    else null
  end stoid
from kis.nbew n
-- left join metadata_repository.stoid mr
--    on mr.sourceid = n.stoid
group by jahr, n.stoid
order by jahr, quantity desc
;

--dspty
--drop view if exists kis.dqa_nbew_dspty cascade;
--create or replace view kis.dqa_nbew_dspty
--as
select
  count(falnr) quantity,
  case
    when n.dspty ~'^\w' then n.dspty
    else null
  end dspty
from kis.nbew n
group by n.dspty
--left join metadata_repository.dspty mr
--  on mr.sourceid = n.dspty
order by quantity desc
;

-- dspty Jahr
--drop view if exists kis.dqa_nbew_dspty_jahr cascade;
--create or replace view kis.dqa_nbew_dspty_jahr
--as
select
  date_part('year', erdat) jahr,
  count(falnr) quantity,
  case
    when n.dspty ~'^\w' then n.dspty
    else null
  end dspty
from kis.nbew n
-- left join metadata_repository.dspty mr
--    on mr.sourceid = n.dspty
group by jahr, n.dspty
order by jahr, quantity desc
;

--visty
--drop view if exists kis.dqa_nbew_visty cascade;
--create or replace view kis.dqa_nbew_visty
--as
select
  count(falnr) quantity,
  case
    when n.visty ~'^\w' then n.visty
    else null
  end visty
from kis.nbew n
group by n.visty
--left join metadata_repository.visty mr
--  on mr.sourceid = n.visty
order by quantity desc
;

-- visty Jahr
--drop view if exists kis.dqa_nbew_visty_jahr cascade;
--create or replace view kis.dqa_nbew_visty_jahr
--as
select
  date_part('year', erdat) jahr,
  count(falnr) quantity,
  case
    when n.visty ~'^\w' then n.visty
    else null
  end visty
from kis.nbew n
-- left join metadata_repository.visty mr
--    on mr.sourceid = n.visty
group by jahr, n.visty
order by jahr, quantity desc
;

--bwgr1
--drop view if exists kis.dqa_nbew_bwgr1 cascade;
--create or replace view kis.dqa_nbew_bwgr1
--as
select
  count(falnr) quantity,
  case
    when n.bwgr1 ~'^\w' then n.bwgr1
    else null
  end bwgr1
from kis.nbew n
group by n.bwgr1
--left join metadata_repository.bwgr1 mr
--  on mr.sourceid = n.bwgr1
order by quantity desc
;

-- bwgr1 Jahr
--drop view if exists kis.dqa_nbew_bwgr1_jahr cascade;
--create or replace view kis.dqa_nbew_bwgr1_jahr
--as
select
  date_part('year', erdat) jahr,
  count(falnr) quantity,
  case
    when n.bwgr1 ~'^\w' then n.bwgr1
    else null
  end bwgr1
from kis.nbew n
-- left join metadata_repository.bwgr1 mr
--    on mr.sourceid = n.bwgr1
group by jahr, n.bwgr1
order by jahr, quantity desc
;

--bwgr2
--drop view if exists kis.dqa_nbew_bwgr2 cascade;
--create or replace view kis.dqa_nbew_bwgr2
--as
select
  count(falnr) quantity,
  case
    when n.bwgr2 ~'^\w' then n.bwgr2
    else null
  end bwgr2
from kis.nbew n
group by n.bwgr2
--left join metadata_repository.bwgr2 mr
--  on mr.sourceid = n.bwgr2
order by quantity desc
;

-- bwgr2 Jahr
--drop view if exists kis.dqa_nbew_bwgr2_jahr cascade;
--create or replace view kis.dqa_nbew_bwgr2_jahr
--as
select
  date_part('year', erdat) jahr,
  count(falnr) quantity,
  case
    when n.bwgr2 ~'^\w' then n.bwgr2
    else null
  end bwgr2
from kis.nbew n
-- left join metadata_repository.bwgr2 mr
--    on mr.sourceid = n.bwgr2
group by jahr, n.bwgr2
order by jahr, quantity desc
;

--tpart
--drop view if exists kis.dqa_nbew_tpart cascade;
--create or replace view kis.dqa_nbew_tpart
--as
select
  count(falnr) quantity,
  case
    when n.tpart ~'^\w' then n.tpart
    else null
  end tpart
from kis.nbew n
group by n.tpart
--left join metadata_repository.tpart mr
--  on mr.sourceid = n.tpart
order by quantity desc
;

-- tpart Jahr
--drop view if exists kis.dqa_nbew_tpart_jahr cascade;
--create or replace view kis.dqa_nbew_tpart_jahr
--as
select
  date_part('year', erdat) jahr,
  count(falnr) quantity,
  case
    when n.tpart ~'^\w' then n.tpart
    else null
  end tpart
from kis.nbew n
-- left join metadata_repository.tpart mr
--    on mr.sourceid = n.tpart
group by jahr, n.tpart
order by jahr, quantity desc
;

--unfvs
--drop view if exists kis.dqa_nbew_unfvs cascade;
--create or replace view kis.dqa_nbew_unfvs
--as
select
  count(falnr) quantity,
  case
    when n.unfvs ~'^\w' then n.unfvs
    else null
  end unfvs
from kis.nbew n
group by n.unfvs
--left join metadata_repository.unfvs mr
--  on mr.sourceid = n.unfvs
order by quantity desc
;

-- unfvs Jahr
--drop view if exists kis.dqa_nbew_unfvs_jahr cascade;
--create or replace view kis.dqa_nbew_unfvs_jahr
--as
select
  date_part('year', erdat) jahr,
  count(falnr) quantity,
  case
    when n.unfvs ~'^\w' then n.unfvs
    else null
  end unfvs
from kis.nbew n
-- left join metadata_repository.unfvs mr
--    on mr.sourceid = n.unfvs
group by jahr, n.unfvs
order by jahr, quantity desc
;

--insev
--drop view if exists kis.dqa_nbew_insev cascade;
--create or replace view kis.dqa_nbew_insev
--as
select
  count(falnr) quantity,
  case
    when n.insev ~'^\w' then n.insev
    else null
  end insev
from kis.nbew n
group by n.insev
--left join metadata_repository.insev mr
--  on mr.sourceid = n.insev
order by quantity desc
;

-- insev Jahr
--drop view if exists kis.dqa_nbew_insev_jahr cascade;
--create or replace view kis.dqa_nbew_insev_jahr
--as
select
  date_part('year', erdat) jahr,
  count(falnr) quantity,
  case
    when n.insev ~'^\w' then n.insev
    else null
  end insev
from kis.nbew n
-- left join metadata_repository.insev mr
--    on mr.sourceid = n.insev
group by jahr, n.insev
order by jahr, quantity desc
;

--opart
--drop view if exists kis.dqa_nbew_opart cascade;
--create or replace view kis.dqa_nbew_opart
--as
select
  count(falnr) quantity,
  case
    when n.opart ~'^\w' then n.opart
    else null
  end opart
from kis.nbew n
group by n.opart
--left join metadata_repository.opart mr
--  on mr.sourceid = n.opart
order by quantity desc
;

-- opart Jahr
--drop view if exists kis.dqa_nbew_opart_jahr cascade;
--create or replace view kis.dqa_nbew_opart_jahr
--as
select
  date_part('year', erdat) jahr,
  count(falnr) quantity,
  case
    when n.opart ~'^\w' then n.opart
    else null
  end opart
from kis.nbew n
-- left join metadata_repository.opart mr
--    on mr.sourceid = n.opart
group by jahr, n.opart
order by jahr, quantity desc
;

--"class"
--drop view if exists kis.dqa_nbew_"class" cascade;
--create or replace view kis.dqa_nbew_"class"
--as
select
  count(falnr) quantity,
  case
    when n."class" ~'^\w' then n."class"
    else null
  end "class"
from kis.nbew n
group by n."class"
--left join metadata_repository."class" mr
--  on mr.sourceid = n."class"
order by quantity desc
;

-- "class" Jahr
--drop view if exists kis.dqa_nbew_"class"_jahr cascade;
--create or replace view kis.dqa_nbew_"class"_jahr
--as
select
  date_part('year', erdat) jahr,
  count(falnr) quantity,
  case
    when n."class" ~'^\w' then n."class"
    else null
  end "class"
from kis.nbew n
-- left join metadata_repository."class" mr
--    on mr.sourceid = n."class"
group by jahr, n."class"
order by jahr, quantity desc
;

--rfsrc
--drop view if exists kis.dqa_nbew_rfsrc cascade;
--create or replace view kis.dqa_nbew_rfsrc
--as
select
  count(falnr) quantity,
  case
    when n.rfsrc ~'^\w' then n.rfsrc
    else null
  end rfsrc
from kis.nbew n
group by n.rfsrc
--left join metadata_repository.rfsrc mr
--  on mr.sourceid = n.rfsrc
order by quantity desc
;

-- rfsrc Jahr
--drop view if exists kis.dqa_nbew_rfsrc_jahr cascade;
--create or replace view kis.dqa_nbew_rfsrc_jahr
--as
select
  date_part('year', erdat) jahr,
  count(falnr) quantity,
  case
    when n.rfsrc ~'^\w' then n.rfsrc
    else null
  end rfsrc
from kis.nbew n
-- left join metadata_repository.rfsrc mr
--    on mr.sourceid = n.rfsrc
group by jahr, n.rfsrc
order by jahr, quantity desc
;

--fachr
--drop view if exists kis.dqa_nbew_fachr cascade;
--create or replace view kis.dqa_nbew_fachr
--as
select
  count(falnr) quantity,
  case
    when n.fachr ~'^\w' then n.fachr
    else null
  end fachr
from kis.nbew n
group by n.fachr
--left join metadata_repository.fachr mr
--  on mr.sourceid = n.fachr
order by quantity desc
;

-- fachr Jahr
--drop view if exists kis.dqa_nbew_fachr_jahr cascade;
--create or replace view kis.dqa_nbew_fachr_jahr
--as
select
  date_part('year', erdat) jahr,
  count(falnr) quantity,
  case
    when n.fachr ~'^\w' then n.fachr
    else null
  end fachr
from kis.nbew n
-- left join metadata_repository.fachr mr
--    on mr.sourceid = n.fachr
group by jahr, n.fachr
order by jahr, quantity desc
;

--unfrt
--drop view if exists kis.dqa_nbew_unfrt cascade;
--create or replace view kis.dqa_nbew_unfrt
--as
select
  count(falnr) quantity,
  case
    when n.unfrt ~'^\w' then n.unfrt
    else null
  end unfrt
from kis.nbew n
group by n.unfrt
--left join metadata_repository.unfrt mr
--  on mr.sourceid = n.unfrt
order by quantity desc
;

-- unfrt Jahr
--drop view if exists kis.dqa_nbew_unfrt_jahr cascade;
--create or replace view kis.dqa_nbew_unfrt_jahr
--as
select
  date_part('year', erdat) jahr,
  count(falnr) quantity,
  case
    when n.unfrt ~'^\w' then n.unfrt
    else null
  end unfrt
from kis.nbew n
-- left join metadata_repository.unfrt mr
--    on mr.sourceid = n.unfrt
group by jahr, n.unfrt
order by jahr, quantity desc
;

--unfav
--drop view if exists kis.dqa_nbew_unfav cascade;
--create or replace view kis.dqa_nbew_unfav
--as
select
  count(falnr) quantity,
  case
    when n.unfav ~'^\w' then n.unfav
    else null
  end unfav
from kis.nbew n
group by n.unfav
--left join metadata_repository.unfav mr
--  on mr.sourceid = n.unfav
order by quantity desc
;

-- unfav Jahr
--drop view if exists kis.dqa_nbew_unfav_jahr cascade;
--create or replace view kis.dqa_nbew_unfav_jahr
--as
select
  date_part('year', erdat) jahr,
  count(falnr) quantity,
  case
    when n.unfav ~'^\w' then n.unfav
    else null
  end unfav
from kis.nbew n
-- left join metadata_repository.unfav mr
--    on mr.sourceid = n.unfav
group by jahr, n.unfav
order by jahr, quantity desc
;
