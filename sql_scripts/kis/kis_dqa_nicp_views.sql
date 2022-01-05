--create or replace view kis.dqa_nicp_null_values
--as
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
where lfdbew isnull or lfdbew !~'^\w'
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
where icphc isnull or icphc !~'^\w'
  union
select
  count(falnr) quantities,
  'anzop' "columns"
from kis.nicp n
where anzop isnull or anzop !~'^\w'
  union
select
  count(falnr) quantities,
  'bgdop' "columns"
from kis.nicp n
where bgdop isnull or bgdop !~'^\w'
  union
select
  count(falnr) quantities,
  'bztop' "columns"
from kis.nicp n
where bztop isnull or bztop !~'^\w'
  union
select
  count(falnr) quantities,
  'eztop' "columns"
from kis.nicp n
where eztop isnull or eztop !~'^\w'
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
where updat isnull or updat !~'^\w'
  union
select
  count(falnr) quantities,
  'storn' "columns"
from kis.nicp n
where storn isnull or storn !~'^\w'
  union
select
  count(falnr) quantities,
  'stdat' "columns"
from kis.nicp n
where stdat isnull or stdat !~'^\w'
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
where drg_relevant isnull or drg_relevant !~'^\w'
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
where endop isnull or endop !~'^\w'
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
where quantity isnull or quantity !~'^\w'
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
where oplebspen isnull or oplebspen !~'^\w'
  union
order by quantities, "columns"
;

--einri
--drop view if exists kis.dqa_nicp_einri cascade;
--create or replace view kis.dqa_nicp_einri
--as
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
--create or replace view kis.dqa_nicp_einri_jahr
--as
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

--falnr
--drop view if exists kis.dqa_nicp_falnr cascade;
--create or replace view kis.dqa_nicp_falnr
--as
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
--create or replace view kis.dqa_nicp_falnr_jahr
--as
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

--lnric
--drop view if exists kis.dqa_nicp_lnric cascade;
--create or replace view kis.dqa_nicp_lnric
--as
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
--create or replace view kis.dqa_nicp_lnric_jahr
--as
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

--lfdbew
--drop view if exists kis.dqa_nicp_lfdbew cascade;
--create or replace view kis.dqa_nicp_lfdbew
--as
select
  count(falnr) quantities,
  case
    when n.lfdbew ~'^\w' then n.lfdbew
    else null
  end lfdbew
from kis.nicp n
group by n.lfdbew
order by quantities desc
;

--drop view if exists kis.dqa_nicp_lfdbew_jahr cascade;
--create or replace view kis.dqa_nicp_lfdbew_jahr
--as
select
  date_part('year', updat) jahr,
  count(falnr) quantities,
  case
    when n.lfdbew ~'^\w' then n.lfdbew
    else null
  end lfdbew
from kis.nicp n
group by jahr, n.lfdbew
order by jahr, quantities desc
;

--icpmk
--drop view if exists kis.dqa_nicp_icpmk cascade;
--create or replace view kis.dqa_nicp_icpmk
--as
select
  count(falnr) quantities,
  case
    when n.icpmk ~'^\w' then n.icpmk
    else null
  end icpmk
from kis.nicp n
group by n.icpmk
order by quantities desc
;

--drop view if exists kis.dqa_nicp_icpmk_jahr cascade;
--create or replace view kis.dqa_nicp_icpmk_jahr
--as
select
  date_part('year', updat) jahr,
  count(falnr) quantities,
  case
    when n.icpmk ~'^\w' then n.icpmk
    else null
  end icpmk
from kis.nicp n
group by jahr, n.icpmk
order by jahr, quantities desc
;

--icpml
--drop view if exists kis.dqa_nicp_icpml cascade;
--create or replace view kis.dqa_nicp_icpml
--as
select
  count(falnr) quantities,
  case
    when n.icpml ~'^\w' then n.icpml
    else null
  end icpml
from kis.nicp n
group by n.icpml
order by quantities desc
;

--drop view if exists kis.dqa_nicp_icpml_jahr cascade;
--create or replace view kis.dqa_nicp_icpml_jahr
--as
select
  date_part('year', updat) jahr,
  count(falnr) quantities,
  case
    when n.icpml ~'^\w' then n.icpml
    else null
  end icpml
from kis.nicp n
group by jahr, n.icpml
order by jahr, quantities desc
;

--icphc
--drop view if exists kis.dqa_nicp_icphc cascade;
--create or replace view kis.dqa_nicp_icphc
--as
select
  count(falnr) quantities,
  case
    when n.icphc ~'^\w' then n.icphc
    else null
  end icphc
from kis.nicp n
group by n.icphc
order by quantities desc
;

--drop view if exists kis.dqa_nicp_icphc_jahr cascade;
--create or replace view kis.dqa_nicp_icphc_jahr
--as
select
  date_part('year', updat) jahr,
  count(falnr) quantities,
  case
    when n.icphc ~'^\w' then n.icphc
    else null
  end icphc
from kis.nicp n
group by jahr, n.icphc
order by jahr, quantities desc
;

--anzop
--drop view if exists kis.dqa_nicp_anzop cascade;
--create or replace view kis.dqa_nicp_anzop
--as
select
  count(falnr) quantities,
  case
    when n.anzop ~'^\w' then n.anzop
    else null
  end anzop
from kis.nicp n
group by n.anzop
order by quantities desc
;

--drop view if exists kis.dqa_nicp_anzop_jahr cascade;
--create or replace view kis.dqa_nicp_anzop_jahr
--as
select
  date_part('year', updat) jahr,
  count(falnr) quantities,
  case
    when n.anzop ~'^\w' then n.anzop
    else null
  end anzop
from kis.nicp n
group by jahr, n.anzop
order by jahr, quantities desc
;

--bgdop
--drop view if exists kis.dqa_nicp_bgdop cascade;
--create or replace view kis.dqa_nicp_bgdop
--as
select
  count(falnr) quantities,
  case
    when n.bgdop ~'^\w' then n.bgdop
    else null
  end bgdop
from kis.nicp n
group by n.bgdop
order by quantities desc
;

--drop view if exists kis.dqa_nicp_bgdop_jahr cascade;
--create or replace view kis.dqa_nicp_bgdop_jahr
--as
select
  date_part('year', updat) jahr,
  count(falnr) quantities,
  case
    when n.bgdop ~'^\w' then n.bgdop
    else null
  end bgdop
from kis.nicp n
group by jahr, n.bgdop
order by jahr, quantities desc
;

--bztop
--drop view if exists kis.dqa_nicp_bztop cascade;
--create or replace view kis.dqa_nicp_bztop
--as
select
  count(falnr) quantities,
  case
    when n.bztop ~'^\w' then n.bztop
    else null
  end bztop
from kis.nicp n
group by n.bztop
order by quantities desc
;

--drop view if exists kis.dqa_nicp_bztop_jahr cascade;
--create or replace view kis.dqa_nicp_bztop_jahr
--as
select
  date_part('year', updat) jahr,
  count(falnr) quantities,
  case
    when n.bztop ~'^\w' then n.bztop
    else null
  end bztop
from kis.nicp n
group by jahr, n.bztop
order by jahr, quantities desc
;

--eztop
--drop view if exists kis.dqa_nicp_eztop cascade;
--create or replace view kis.dqa_nicp_eztop
--as
select
  count(falnr) quantities,
  case
    when n.eztop ~'^\w' then n.eztop
    else null
  end eztop
from kis.nicp n
group by n.eztop
order by quantities desc
;

--drop view if exists kis.dqa_nicp_eztop_jahr cascade;
--create or replace view kis.dqa_nicp_eztop_jahr
--as
select
  date_part('year', updat) jahr,
  count(falnr) quantities,
  case
    when n.eztop ~'^\w' then n.eztop
    else null
  end eztop
from kis.nicp n
group by jahr, n.eztop
order by jahr, quantities desc
;

--lslok
--drop view if exists kis.dqa_nicp_lslok cascade;
--create or replace view kis.dqa_nicp_lslok
--as
select
  count(falnr) quantities,
  case
    when n.lslok ~'^\w' then n.lslok
    else null
  end lslok
from kis.nicp n
group by n.lslok
order by quantities desc
;

--drop view if exists kis.dqa_nicp_lslok_jahr cascade;
--create or replace view kis.dqa_nicp_lslok_jahr
--as
select
  date_part('year', updat) jahr,
  count(falnr) quantities,
  case
    when n.lslok ~'^\w' then n.lslok
    else null
  end lslok
from kis.nicp n
group by jahr, n.lslok
order by jahr, quantities desc
;

--opart
--drop view if exists kis.dqa_nicp_opart cascade;
--create or replace view kis.dqa_nicp_opart
--as
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
--create or replace view kis.dqa_nicp_opart_jahr
--as
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

--updat
--drop view if exists kis.dqa_nicp_updat cascade;
--create or replace view kis.dqa_nicp_updat
--as
select
  count(falnr) quantities,
  case
    when n.updat ~'^\w' then n.updat
    else null
  end updat
from kis.nicp n
group by n.updat
order by quantities desc
;

--drop view if exists kis.dqa_nicp_updat_jahr cascade;
--create or replace view kis.dqa_nicp_updat_jahr
--as
select
  date_part('year', updat) jahr,
  count(falnr) quantities,
  case
    when n.updat ~'^\w' then n.updat
    else null
  end updat
from kis.nicp n
group by jahr, n.updat
order by jahr, quantities desc
;

--storn
--drop view if exists kis.dqa_nicp_storn cascade;
--create or replace view kis.dqa_nicp_storn
--as
select
  count(falnr) quantities,
  case
    when n.storn ~'^\w' then n.storn
    else null
  end storn
from kis.nicp n
group by n.storn
order by quantities desc
;

--drop view if exists kis.dqa_nicp_storn_jahr cascade;
--create or replace view kis.dqa_nicp_storn_jahr
--as
select
  date_part('year', updat) jahr,
  count(falnr) quantities,
  case
    when n.storn ~'^\w' then n.storn
    else null
  end storn
from kis.nicp n
group by jahr, n.storn
order by jahr, quantities desc
;

--stdat
--drop view if exists kis.dqa_nicp_stdat cascade;
--create or replace view kis.dqa_nicp_stdat
--as
select
  count(falnr) quantities,
  case
    when n.stdat ~'^\w' then n.stdat
    else null
  end stdat
from kis.nicp n
group by n.stdat
order by quantities desc
;

--drop view if exists kis.dqa_nicp_stdat_jahr cascade;
--create or replace view kis.dqa_nicp_stdat_jahr
--as
select
  date_part('year', updat) jahr,
  count(falnr) quantities,
  case
    when n.stdat ~'^\w' then n.stdat
    else null
  end stdat
from kis.nicp n
group by jahr, n.stdat
order by jahr, quantities desc
;

--drg_category
--drop view if exists kis.dqa_nicp_drg_category cascade;
--create or replace view kis.dqa_nicp_drg_category
--as
select
  count(falnr) quantities,
  case
    when n.drg_category ~'^\w' then n.drg_category
    else null
  end drg_category
from kis.nicp n
group by n.drg_category
order by quantities desc
;

--drop view if exists kis.dqa_nicp_drg_category_jahr cascade;
--create or replace view kis.dqa_nicp_drg_category_jahr
--as
select
  date_part('year', updat) jahr,
  count(falnr) quantities,
  case
    when n.drg_category ~'^\w' then n.drg_category
    else null
  end drg_category
from kis.nicp n
group by jahr, n.drg_category
order by jahr, quantities desc
;

--drg_relevant
--drop view if exists kis.dqa_nicp_drg_relevant cascade;
--create or replace view kis.dqa_nicp_drg_relevant
--as
select
  count(falnr) quantities,
  case
    when n.drg_relevant ~'^\w' then n.drg_relevant
    else null
  end drg_relevant
from kis.nicp n
group by n.drg_relevant
order by quantities desc
;

--drop view if exists kis.dqa_nicp_drg_relevant_jahr cascade;
--create or replace view kis.dqa_nicp_drg_relevant_jahr
--as
select
  date_part('year', updat) jahr,
  count(falnr) quantities,
  case
    when n.drg_relevant ~'^\w' then n.drg_relevant
    else null
  end drg_relevant
from kis.nicp n
group by jahr, n.drg_relevant
order by jahr, quantities desc
;

--orgfa
--drop view if exists kis.dqa_nicp_orgfa cascade;
--create or replace view kis.dqa_nicp_orgfa
--as
select
  count(falnr) quantities,
  case
    when n.orgfa ~'^\w' then n.orgfa
    else null
  end orgfa
from kis.nicp n
group by n.orgfa
order by quantities desc
;

--drop view if exists kis.dqa_nicp_orgfa_jahr cascade;
--create or replace view kis.dqa_nicp_orgfa_jahr
--as
select
  date_part('year', updat) jahr,
  count(falnr) quantities,
  case
    when n.orgfa ~'^\w' then n.orgfa
    else null
  end orgfa
from kis.nicp n
group by jahr, n.orgfa
order by jahr, quantities desc
;

--orgpf
--drop view if exists kis.dqa_nicp_orgpf cascade;
--create or replace view kis.dqa_nicp_orgpf
--as
select
  count(falnr) quantities,
  case
    when n.orgpf ~'^\w' then n.orgpf
    else null
  end orgpf
from kis.nicp n
group by n.orgpf
order by quantities desc
;

--drop view if exists kis.dqa_nicp_orgpf_jahr cascade;
--create or replace view kis.dqa_nicp_orgpf_jahr
--as
select
  date_part('year', updat) jahr,
  count(falnr) quantities,
  case
    when n.orgpf ~'^\w' then n.orgpf
    else null
  end orgpf
from kis.nicp n
group by jahr, n.orgpf
order by jahr, quantities desc
;

--endop
--drop view if exists kis.dqa_nicp_endop cascade;
--create or replace view kis.dqa_nicp_endop
--as
select
  count(falnr) quantities,
  case
    when n.endop ~'^\w' then n.endop
    else null
  end endop
from kis.nicp n
group by n.endop
order by quantities desc
;

--drop view if exists kis.dqa_nicp_endop_jahr cascade;
--create or replace view kis.dqa_nicp_endop_jahr
--as
select
  date_part('year', updat) jahr,
  count(falnr) quantities,
  case
    when n.endop ~'^\w' then n.endop
    else null
  end endop
from kis.nicp n
group by jahr, n.endop
order by jahr, quantities desc
;

--prtyp
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

--quantity
--drop view if exists kis.dqa_nicp_quantity cascade;
--create or replace view kis.dqa_nicp_quantity
--as
select
  count(falnr) quantities,
  case
    when n.quantity ~'^\w' then n.quantity
    else null
  end quantity
from kis.nicp n
group by n.quantity
order by quantities desc
;

--drop view if exists kis.dqa_nicp_quantity_jahr cascade;
--create or replace view kis.dqa_nicp_quantity_jahr
--as
select
  date_part('year', updat) jahr,
  count(falnr) quantities,
  case
    when n.quantity ~'^\w' then n.quantity
    else null
  end quantity
from kis.nicp n
group by jahr, n.quantity
order by jahr, quantities desc
;

--unit
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

--ccl
--drop view if exists kis.dqa_nicp_ccl cascade;
--create or replace view kis.dqa_nicp_ccl
--as
select
  count(falnr) quantities,
  case
    when n.ccl ~'^\w' then n.ccl
    else null
  end ccl
from kis.nicp n
group by n.ccl
order by quantities desc
;

--drop view if exists kis.dqa_nicp_ccl_jahr cascade;
--create or replace view kis.dqa_nicp_ccl_jahr
--as
select
  date_part('year', updat) jahr,
  count(falnr) quantities,
  case
    when n.ccl ~'^\w' then n.ccl
    else null
  end ccl
from kis.nicp n
group by jahr, n.ccl
order by jahr, quantities desc
;

--oplebspen
--drop view if exists kis.dqa_nicp_oplebspen cascade;
--create or replace view kis.dqa_nicp_oplebspen
--as
select
  count(falnr) quantities,
  case
    when n.oplebspen ~'^\w' then n.oplebspen
    else null
  end oplebspen
from kis.nicp n
group by n.oplebspen
order by quantities desc
;

--drop view if exists kis.dqa_nicp_oplebspen_jahr cascade;
--create or replace view kis.dqa_nicp_oplebspen_jahr
--as
select
  date_part('year', updat) jahr,
  count(falnr) quantities,
  case
    when n.oplebspen ~'^\w' then n.oplebspen
    else null
  end oplebspen
from kis.nicp n
group by jahr, n.oplebspen
order by jahr, quantities desc
;
