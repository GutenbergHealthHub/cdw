--DQA for kis.nbew

-- Null values in nbew.
--drop view if exists kis.dqa_nbew_null_values;
create or replace view kis.dqa_nbew_null_values
as
  select 
    count(einri) null_value, 
    'einri' "columns"
  from kis.nbew n 
  where einri isnull or einri !~'^\w'
    union 
  select 
    count(falnr),
    'falnr'
  from kis.nbew
  where falnr isnull or falnr !~'^\w'
    union 
  select 
    count(falnr),
    'lfdbew'
  from kis.nbew
  where lfdbew isnull
    union 
  select
    count(bewty),
    'bewty'
  from kis.nbew
  where bewty isnull or bewty !~'^\w'
    union 
  select 
    count(bwart),
    'bwart' 
  from kis.nbew
  where bwart isnull or bwart !~'^\w'
    union 
  select 
    count(bwidt),
    'bwidt' 
  from kis.nbew
  where bwidt isnull
    union 
  select 
    count(bwizt),
    'bwizt'
  from kis.nbew
  where bwizt isnull
    union 
   select 
    count(planb),
    'planb'
  from kis.nbew
  where planb = false
    union 
  select 
    count(statu),
    'statu' 
  from kis.nbew
  where statu isnull or statu !~'^\w'
    union 
  select 
    count(bwedt),
    'bwedt'
  from kis.nbew
  where bwedt isnull
    union 
  select 
    count(bwezt),
    'bwezt'
  from kis.nbew
  where bwezt isnull
    union 
  select 
    count(plane),
    'plane'
  from kis.nbew
  where plane = false
    union 
  select 
    count(lfdbew),
    'lfdbew'
  from kis.nbew
  where lfdbew isnull 
    union 
  select 
    count(lfdref),
    'lfdref'
  from kis.nbew
  where lfdref isnull
    union 
  select 
    count(notkz),
    'notkz'
  from kis.nbew
  where notkz = false
    union 
  select 
    count(unfkz),
    'unfkz' 
  from kis.nbew
  where unfkz isnull or unfkz !~'^\w'
    union 
  select 
    count(orgfa),
    'orgfa' 
  from kis.nbew
  where orgfa isnull or orgfa !~'^\w'
    union 
  select 
    count(orgpf),
    'orgpf' 
  from kis.nbew
  where orgpf isnull or orgpf !~'^\w'
    union 
  select 
    count(zimmr),
    'zimmr' 
  from kis.nbew
  where zimmr isnull or zimmr !~'^\w'
    union 
  select 
    count(bett),
    'bett' 
  from kis.nbew
  where bett isnull or bett !~'^\w'
    union 
  select 
    count(planr),
    'planr' 
  from kis.nbew
  where planr isnull or planr !~'^\w'
    union 
  select 
    count(orgau),
    'orgau' 
  from kis.nbew
  where orgau isnull or orgau !~'^\w'
    union 
  select 
    count(ezust),
    'ezust' 
  from kis.nbew
  where ezust isnull or ezust !~'^\w'
    union 
  select 
    count(todur),
    'todur' 
  from kis.nbew
  where todur isnull or todur !~'^\w'
    union 
  select 
    count(erdat),
    'erdat' 
  from kis.nbew
  where erdat isnull
    union 
  select 
    count(updat),
    'updat' 
  from kis.nbew
  where updat isnull
    union 
   select 
    count(storn),
    'storn' 
  from kis.nbew
  where storn = false
    union 
  select 
    count(stdat),
    'stdat' 
  from kis.nbew
  where stdat isnull
    union 
  select 
    count(bekat),
    'bekat' 
  from kis.nbew
  where bekat isnull or bekat !~'^\w'
    union 
  select 
    count(nfgref),
    'nfgref' 
  from kis.nbew
  where nfgref isnull
    union 
  select 
    count(vgnref),
    'vgnref' 
  from kis.nbew
  where vgnref isnull
    union 
  select 
    count(stoid),
    'stoid' 
  from kis.nbew
  where stoid isnull or stoid !~'^\w'
    union 
  select 
    count(dspty),
    'dspty' 
  from kis.nbew
  where dspty isnull or dspty !~'^\w'
    union 
  select 
    count(visty),
    'visty' 
  from kis.nbew
  where visty isnull or visty !~'^\w'
    union
  select 
    count(bwgr1),
    'bwgr1' 
  from kis.nbew
  where bwgr1 isnull or bwgr1 !~'^\w'
    union 
  select 
    count(bwgr2),
    'bwgr2' 
  from kis.nbew
  where bwgr2 isnull or bwgr2 !~'^\w'
    union 
  select 
    count(tpart),
    'tpart' 
  from kis.nbew
  where tpart isnull or tpart !~'^\w'
    union 
  select 
    count(unfvs),
    'unfvs' 
  from kis.nbew
  where unfvs = false
    union 
  select 
    count(insev),
    'insev' 
  from kis.nbew
  where insev isnull or insev !~'^\w'
    union 
  select 
    count(opart),
    'opart' 
  from kis.nbew
  where opart isnull or opart !~'^\w'
    union 
  select 
    count("class"),
    'tpart' 
  from kis.nbew
  where "class" isnull or "class" !~'^\w'
    union 
  select 
    count(rfsrc),
    'rfsrc' 
  from kis.nbew
  where rfsrc isnull or rfsrc !~'^\w'
    union 
  select 
    count(fachr),
    'fachr' 
  from kis.nbew
  where fachr isnull or fachr !~'^\w'
    union 
  select 
    count(unfrt),
    'unfrt' 
  from kis.nbew
  where unfrt isnull or unfrt !~'^\w'
    union 
  select 
    count(unfav),
    'unfav' 
  from kis.nbew
  where unfav isnull or unfav !~'^\w'
    union 
  select 
    count(retrievaldate),
    'retrievaldate' 
  from kis.nbew
  where retrievaldate isnull
  order by null_value, "columns"
; 
    
-- Bewegungstyp
--drop view if exists kis.dqa_nbew_bewty;
create or replace view kis.dqa_nbew_bewty
as
select 
  count(falnr) quantity, 
  case 
    when n.bewty ~'\w' then n.bewty 
    else null
  end bewty,
  bewegunstyp
from kis.nbew n
left join metadata_repository.bewegunstyp b
  on n.bewty = b.bewty 
group by n.bewty, bewegunstyp
order by quantity desc
;

-- Bewegungsart
--drop view if exists kis.dqa_nbew_bwart;
create or replace view kis.dqa_nbew_bwart
as
select 
  count(falnr) quantity, 
  case 
    when n.bwart ~'\w' then n.bwart 
    else null
  end bwart
  --bewegunsart
from kis.nbew n
left join metadata_repository.bewegunsart b
  on n.bwart = b.bwart 
group by n.bwart , bewegunsart
order by quantity desc
;

-- Statu
--drop view if exists kis.dqa_nbew_statu;
create or replace view kis.dqa_nbew_statu
as
select 
  count(falnr) quantity,
  case
    when n.statu ~'\w' then n.statu 
    else null
  end statu, 
  s.intstatu status
from kis.nbew n
left join metadata_repository.inter_status_amb_besu s
  on n.statu = s.statu 
group by n.statu, status
order by quantity desc
;

-- Unfallart
--drop view if exists kis.dqa_nbew_unfkz;
create or replace view kis.dqa_nbew_unfkz
as
select 
  count(falnr) quantity,
  case
    when n.unfkz ~'\w' then n.unfkz 
    else null
  end unfallid, 
  u.unfallart 
from kis.nbew n
left join metadata_repository.unfallart u
  on n.unfkz = u.unfkz 
group by unfallid, unfallart
order by quantity desc
;

-- Orgfa
--drop view if exists kis.dqa_nbew_orgfa;
create or replace view kis.dqa_nbew_orgfa
as
select 
  count(falnr) quantity,
  case
    when n.orgfa ~'\w' then n.orgfa 
    else null
  end orgfa, 
  nor.orgna 
from kis.nbew n
left join kis.norg nor
  on n.orgfa = nor.orgid 
group by orgfa, orgna 
order by quantity desc
;

-- Orgpf
--drop view if exists kis.dqa_nbew_orgpf;
create or replace view kis.dqa_nbew_orgpf
as
select 
  count(falnr) quantity,
  case
    when n.orgpf ~'\w' then n.orgpf 
    else null
  end orgpf, 
  nor.orgna 
from kis.nbew n
left join kis.norg nor
  on n.orgpf = nor.orgid 
group by orgpf, orgna 
order by quantity desc
;

-- Zimmer
--drop view if exists kis.dqa_nbew_zimmer;
create or replace view kis.dqa_nbew_zimmer
as
select 
  count(falnr) quantity,
  case
    when n.zimmr ~'\w' then n.zimmr 
    else null
  end zimmer 
from kis.nbew n 
group by zimmer 
order by quantity desc
;

-- Bett
--drop view if exists kis.dqa_nbew_bett;
create or replace view kis.dqa_nbew_bett
as
select 
  count(falnr) quantity,
  case
    when n.bett ~'\w' then n.bett 
    else null
  end bett 
from kis.nbew n 
group by bett 
order by quantity desc
;

-- Orgau
--drop view if exists kis.dqa_nbew_orgau;
create or replace view kis.dqa_nbew_orgau
as
select 
  count(falnr) quantity,
  case
    when n.orgau ~'\w' then n.orgau
    else null
  end orgau, 
  nor.orgna 
from kis.nbew n
left join kis.norg nor
  on n.orgau = nor.orgid 
group by orgau, orgna 
order by quantity desc
;

-- Behandlungskategorien
--drop view if exists kis.dqa_nbew_bekat;
create or replace view kis.dqa_nbew_bekat
as
select 
  count(falnr) quantity,
  case
    when n.bekat ~'\w' then n.bekat 
    else null
  end bkat, 
  b.bltxt behandlungskategorien
from kis.nbew n
left join metadata_repository.behandlungskategorie b
  on n.bekat = b.bekat and n.einri = b.einri 
group by bkat, behandlungskategorien
order by quantity desc
;


-- Stornogund
--drop view if exists kis.dqa_nbew_stoid;
create or replace view kis.dqa_nbew_stoid
as
select 
  count(falnr) quantity,
  case
    when n.stoid ~'\w' then n.stoid 
    else null
  end stoid, 
  s.stornierungsgrund
from kis.nbew n
left join metadata_repository.stornierungsgrund s
  on n.stoid = s.stoid 
group by n.stoid, s.stornierungsgrund 
order by quantity desc
;

-- Dispositionstyp für die Besuchsdisposi-tion
--drop view if exists kis.dqa_nbew_dspty;
create or replace view kis.dqa_nbew_dspty
as
select 
  count(falnr) quantity,
  case
    when n.dspty ~'\w' then n.dspty 
    else null
  end dspty 
from kis.nbew n 
group by dspty 
order by quantity desc
;


--Bewegungsgrund 1. und 2. Stelle
--drop view if exists kis.dqa_nbew_bwgr1;
create or replace view kis.dqa_nbew_bwgr1
as
select 
  count(falnr) quantity,
  case
    when n.bwgr1 ~'\w' then n.bwgr1 
    else null
  end bwgr1 
from kis.nbew n 
group by bwgr1 
order by quantity desc
;


--Bewegungsgrund 3. und 4. Stelle
--drop view if exists kis.dqa_nbew_bwgr2;
create or replace view kis.dqa_nbew_bwgr2
as
select 
  count(falnr) quantity,
  case
    when n.bwgr2 ~'\w' then n.bwgr2
    else null
  end bwgr2
from kis.nbew n 
group by bwgr2 
order by quantity desc
;


-- Transportart
--drop view if exists kis.dqa_nbew_tpart;
create or replace view kis.dqa_nbew_tpart
as
select 
  count(falnr) quantity,
  case
    when n.tpart ~'\w' then n.tpart 
    else null
  end tpart, 
  t.transportart
from kis.nbew n
left join metadata_repository.transportart t
  on n.tpart = t.tpart 
group by n.tpart, t.transportart 
order by quantity desc
;

--Ereignis, durch das Bewegung angelegt wurde
--drop view if exists kis.dqa_nbew_insev;
create or replace view kis.dqa_nbew_insev
as
select 
  count(falnr) quantity,
  case
    when n.insev ~'\w' then n.insev 
    else null
  end insev 
from kis.nbew n 
group by insev 
order by quantity desc
;

--Art der Operation
--drop view if exists kis.dqa_nbew_opart;
create or replace view kis.dqa_nbew_opart
as
select 
  count(falnr) quantity,
  case
    when n.opart ~'\w' then n.opart 
    else null
  end opart 
from kis.nbew n 
group by opart 
order by quantity desc
;


--Klasse des Patienten
--drop view if exists kis.dqa_nbew_class;
create or replace view kis.dqa_nbew_class
as
select 
  count(falnr) quantity,
  case
    when n."class" ~'\w' then n."class" 
    else null
  end "class" 
from kis.nbew n 
group by "class" 
order by quantity desc
;

-- Einweisungs-, Überweisungs,- Nachbe-handlungsart
--drop view if exists kis.dqa_nbew_rfsrc;
create or replace view kis.dqa_nbew_rfsrc
as
select 
  count(falnr) quantity,
  case
    when n.rfsrc ~'\w' then n.rfsrc 
    else null
  end rfsrc, 
  e.einweisungs_ueberweisungs_nachbehandlungsart
from kis.nbew n
left join metadata_repository.einweisungs_ueberweisungs_nachbehandlungsart e
  on n.rfsrc = e.rfsrc 
group by n.rfsrc , e.einweisungs_ueberweisungs_nachbehandlungsart 
order by quantity desc
;

--Fachrichtung der Ärzte
--drop view if exists kis.dqa_nbew_fachr;
create or replace view kis.dqa_nbew_fachr
as
select 
  count(falnr) quantity,
  case
    when n.fachr ~'\w' then n.fachr 
    else null
  end fachr 
from kis.nbew n 
group by fachr 
order by quantity desc
;

-- Rettungsdienst
--drop view if exists kis.dqa_nbew_unfrt;
create or replace view kis.dqa_nbew_unfrt
as
select 
  count(falnr) quantity,
  case
    when n.unfrt ~'\w' then n.unfrt 
    else null
  end unfrt 
from kis.nbew n 
group by unfrt 
order by quantity desc
;

-- Einlieferungsart
--drop view if exists kis.dqa_nbew_unfav;
create or replace view kis.dqa_nbew_unfav
as
select 
  count(falnr) quantity,
  case
    when n.unfav ~'\w' then n.unfav 
    else null
  end unfav 
from kis.nbew n 
group by unfav 
order by quantity desc
;

 
------------------------------------------------------------------------------------------------------

-- Bei Jahren

-- Bewegungen bei Jahren
-- drop view kis.dqa_bew_jahr;
create or replace view kis.dqa_nbew_bew_jahr
as 
select 
  count(falnr) bewegungen,
  date_part('year', bwidt) jahr
from kis.nbew n 
group by jahr
order by jahr desc 
;

    
-- Bewegungstyp
--drop view if exists kis.dqa_nbew_bewty_jahr;
create or replace view kis.dqa_nbew_bewty_jahr
as
select 
  count(falnr) quantity, 
  case 
    when n.bewty ~'\w' then n.bewty 
    else null 
  end bewty,
  bewegunstyp,
  date_part('year', bwidt) jahr
from kis.nbew n
left join metadata_repository.bewegunstyp b
  on n.bewty = b.bewty 
group by n.bewty, bewegunstyp, jahr 
order by jahr desc, n.bewty asc 
;

-- Bewegungsart
-- drop view if exists kis.dqa_nbew_bwart_jahr;
create or replace view kis.dqa_nbwe_bwart_jahr
as
select 
  count(falnr) quantity, 
  case 
    when n.bwart ~'\w' then n.bwart 
    else null
  end bwart, 
  date_part('year', bwidt) jahr
from kis.nbew n
left join metadata_repository.bewegunsart b
  on n.bwart = b.bwart 
group by n.bwart , bewegunsart, jahr
order by jahr desc, bwart asc
;

-- Statu
--drop view if exists kis.dqa_nbew_statu_jahr;
create or replace view kis.dqa_nbew_statu_jahr
as
select 
  count(falnr) quantity,
  case
    when n.statu ~'\w' then n.statu 
    else null
  end statu, 
  s.intstatu status,
  date_part('year', bwidt) jahr
from kis.nbew n
left join metadata_repository.inter_status_amb_besu s
  on n.statu = s.statu 
group by n.statu, status, jahr
order by jahr desc, statu asc
;

-- Unfallart
drop view if exists kis.dqa_nbew_unfkz_jahr;
create or replace view kis.dqa_nbew_unfkz_jahr
as
select 
  count(falnr) quantity,
  case
    when n.unfkz ~'\w' then n.unfkz 
    else null
  end unfkz , 
  u.unfallart,
  date_part('year', bwidt) jahr
from kis.nbew n
left join metadata_repository.unfallart u
  on n.unfkz = u.unfkz 
group by n.unfkz , unfallart, jahr
order by jahr desc, unfkz asc
;

-- Orgfa
--drop view if exists kis.dqa_nbew_orgfa_jahr;
create or replace view kis.dqa_nbew_orgfa_jahr
as
select 
  count(falnr) quantity,
  case
    when n.orgfa ~'\w' then n.orgfa 
    else null
  end orgfa, 
  nor.orgna, 
  date_part('year', bwidt) jahr
from kis.nbew n
left join kis.norg nor
  on n.orgfa = nor.orgid 
group by orgfa, orgna, jahr
order by jahr desc, quantity desc
;

-- Orgpf
--drop view if exists kis.dqa_nbew_orgpf_jahr;
create or replace view kis.dqa_nbew_orgpf_jahr
as
select 
  count(falnr) quantity,
  case
    when n.orgpf ~'\w' then n.orgpf 
    else null
  end orgpf, 
  nor.orgna,
  date_part('year', bwidt) jahr
from kis.nbew n
left join kis.norg nor
  on n.orgpf = nor.orgid 
group by orgpf, orgna, jahr
order by jahr desc, quantity desc
;

-- Zimmer
--drop view if exists kis.dqa_nbew_zimmer_jahr;
create or replace view kis.dqa_nbew_zimmer_jahr
as
select 
  count(falnr) quantity,
  case
    when n.zimmr ~'\w' then n.zimmr 
    else null
  end zimmer,
  date_part('year', bwidt) jahr
from kis.nbew n 
group by zimmer, jahr
order by jahr desc, quantity desc
;

-- Bett
--drop view if exists kis.dqa_nbew_bett_jahr;
create or replace view kis.dqa_nbew_bett_jahr
as
select 
  count(falnr) quantity,
  case
    when n.bett ~'\w' then n.bett 
    else null
  end bett,
  date_part('year', bwidt) jahr
from kis.nbew n 
group by bett, jahr 
order by jahr desc, quantity desc
;

-- Orgau
--drop view if exists kis.dqa_nbew_orgau_jahr;
create or replace view kis.dqa_nbew_orgau_jahr
as
select 
  count(falnr) quantity,
  case
    when n.orgau ~'\w' then n.orgau
    else null
  end orgau, 
  nor.orgna,
  date_part('year', bwidt) jahr
from kis.nbew n
left join kis.norg nor
  on n.orgau = nor.orgid 
group by orgau, orgna, jahr
order by jahr desc, quantity desc
;

-- Behandlungskategorien
--drop view if exists kis.dqa_nbew_bekat_jahr;
create or replace view kis.dqa_nbew_bekat_jahr
as
select 
  count(falnr) quantity,
  case
    when n.bekat ~'\w' then n.bekat 
    else null
  end bkat, 
  b.bltxt behandlungskategorien,
  date_part('year', bwidt) jahr
from kis.nbew n
left join metadata_repository.behandlungskategorie b
  on n.bekat = b.bekat and n.einri = b.einri 
group by bkat, behandlungskategorien, jahr
order by jahr desc, quantity desc
;


-- Stornogund
--drop view if exists kis.dqa_nbew_stoid_jahr;
create or replace view kis.dqa_nbew_stoid_jahr
as
select 
  count(falnr) quantity,
  case
    when n.stoid ~'\w' then n.stoid 
    else null
  end stoid, 
  s.stornierungsgrund,
  date_part('year', bwidt) jahr
from kis.nbew n
left join metadata_repository.stornierungsgrund s
  on n.stoid = s.stoid 
group by n.stoid, s.stornierungsgrund, jahr
order by jahr desc, quantity desc
;

-- Dispositionstyp für die Besuchsdisposi-tion
--drop view if exists kis.dqa_nbew_dspty_jahr;
create or replace view kis.dqa_nbew_dspty_jahr
as
select 
  count(falnr) quantity,
  case
    when n.dspty ~'\w' then n.dspty 
    else null
  end dspty,
  date_part('year', bwidt) jahr
from kis.nbew n 
group by dspty, jahr
order by jahr desc, quantity desc
;


--Bewegungsgrund 1. und 2. Stelle
--drop view if exists kis.dqa_nbew_bwgr1_jahr;
create or replace view kis.dqa_nbew_bwgr1_jahr
as
select 
  count(falnr) quantity,
  case
    when n.bwgr1 ~'\w' then n.bwgr1 
    else null
  end bwgr1,
  date_part('year', bwidt) jahr
from kis.nbew n 
group by bwgr1, jahr
order by jahr desc, quantity desc
;


--Bewegungsgrund 3. und 4. Stelle
--drop view if exists kis.dqa_nbew_bwgr2_jahr;
create or replace view kis.dqa_nbew_bwgr2_jahr
as
select 
  count(falnr) quantity,
  case
    when n.bwgr2 ~'\w' then n.bwgr2
    else null
  end bwgr2,
  date_part('year', bwidt) jahr
from kis.nbew n 
group by bwgr2, jahr
order by jahr desc, quantity desc
;


-- Transportart
--drop view if exists kis.dqa_nbew_tpart_jahr;
create or replace view kis.dqa_nbew_tpart_jahr
as
select 
  count(falnr) quantity,
  case
    when n.tpart ~'\w' then n.tpart 
    else null
  end tpart, 
  t.transportart,
  date_part('year', bwidt) jahr
from kis.nbew n
left join metadata_repository.transportart t
  on n.tpart = t.tpart 
group by n.tpart, t.transportart, jahr
order by jahr desc, quantity desc
;

--Ereignis, durch das Bewegung angelegt wurde
--drop view if exists kis.dqa_nbew_insev_jahr;
create or replace view kis.dqa_nbew_insev_jahr
as
select 
  count(falnr) quantity,
  case
    when n.insev ~'\w' then n.insev 
    else null
  end insev,
  date_part('year', bwidt) jahr
from kis.nbew n 
group by insev, jahr 
order by jahr desc, quantity desc
;

--Art der Operation
--drop view if exists kis.dqa_nbew_opart_jahr;
create or replace view kis.dqa_nbew_opart_jahr
as
select 
  count(falnr) quantity,
  case
    when n.opart ~'\w' then n.opart 
    else null
  end opart,
  date_part('year', bwidt) jahr 
from kis.nbew n 
group by opart, jahr
order by jahr desc, quantity desc
;


--Klasse des Patienten
--drop view if exists kis.dqa_nbew_class_jahr;
create or replace view kis.dqa_nbew_class_jahr
as
select 
  count(falnr) quantity,
  case
    when n."class" ~'\w' then n."class" 
    else null
  end "class",
  date_part('year', bwidt) jahr 
from kis.nbew n 
group by "class", jahr 
order by jahr desc, quantity desc
;

-- Einweisungs-, Überweisungs,- Nachbe-handlungsart
--drop view if exists kis.dqa_nbew_rfsrc_jahr;
create or replace view kis.dqa_nbew_rfsrc_jahr
as
select 
  count(falnr) quantity,
  case
    when n.rfsrc ~'\w' then n.rfsrc 
    else null
  end rfsrc, 
  e.einweisungs_ueberweisungs_nachbehandlungsart,
  date_part('year', bwidt) jahr 
from kis.nbew n
left join metadata_repository.einweisungs_ueberweisungs_nachbehandlungsart e
  on n.rfsrc = e.rfsrc 
group by n.rfsrc , e.einweisungs_ueberweisungs_nachbehandlungsart, jahr
order by jahr desc, quantity desc
;

--Fachrichtung der Ärzte
--drop view if exists kis.dqa_nbew_fachr_jahr;
create or replace view kis.dqa_nbew_fachr_jahr
as
select 
  count(falnr) quantity,
  case
    when n.fachr ~'\w' then n.fachr 
    else null
  end fachr,
  date_part('year', bwidt) jahr 
from kis.nbew n 
group by fachr, jahr
order by jahr desc, quantity desc
;

-- Rettungsdienst
--drop view if exists kis.dqa_nbew_unfrt_jahr;
create or replace view kis.dqa_nbew_unfrt_jahr
as
select 
  count(falnr) quantity,
  case
    when n.unfrt ~'\w' then n.unfrt 
    else null
  end unfrt,
  date_part('year', bwidt) jahr 
from kis.nbew n 
group by unfrt, jahr 
order by jahr desc, quantity desc
;

-- Einlieferungsart
--drop view if exists kis.dqa_nbew_unfav_jahr;
create or replace view kis.dqa_nbew_unfav_jahr
as
select 
  count(falnr) quantity,
  case
    when n.unfav ~'\w' then n.unfav 
    else null
  end unfav,
  date_part('year', bwidt) jahr 
from kis.nbew n 
group by unfav, jahr
order by jahr desc, quantity desc
;


--Falche Datum
--drop view if exists kis.dqa_nbew_falsches_datum;
create or replace view kis.dqa_nbew_falsches_datum
as 
  select 
    falnr,
    bwidt,
    bwedt 
  from kis.nbew n 
  where bwidt > now()
  or bwedt < bwidt
;

