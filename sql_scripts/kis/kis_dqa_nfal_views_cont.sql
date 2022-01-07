--create or replace view kis.dqa_nfal_null_values
--as
select
  count(falnr) quantity,
  'endtyp' "columns"
from kis.nfal n
where endtyp isnull or endtyp !~'^\w'
  union
select
  count(falnr) quantity,
  'patw' "columns"
from kis.nfal n
where patw isnull or patw !~'^\w'
  union
select
  count(falnr) quantity,
  'patgew' "columns"
from kis.nfal n
where patgew isnull or patgew !~'^\w'
  union
select
  count(falnr) quantity,
  'gwein' "columns"
from kis.nfal n
where gwein isnull or gwein !~'^\w'
  union
select
  count(falnr) quantity,
  'patgro' "columns"
from kis.nfal n
where patgro isnull or patgro !~'^\w'
  union
select
  count(falnr) quantity,
  'grein' "columns"
from kis.nfal n
where grein isnull or grein !~'^\w'
  union
select
  count(falnr) quantity,
  'resp' "columns"
from kis.nfal n
where resp isnull or resp !~'^\w'
  union
select
  count(falnr) quantity,
  'delgw' "columns"
from kis.nfal n
where delgw isnull or delgw !~'^\w'
  union
select
  count(falnr) quantity,
  'saps_c' "columns"
from kis.nfal n
where saps_c isnull or saps_c !~'^\w'
  union
select
  count(falnr) quantity,
  'pim2_c' "columns"
from kis.nfal n
where pim2_c isnull or pim2_c !~'^\w'
  union
select
  count(falnr) quantity,
  'crib_c' "columns"
from kis.nfal n
where crib_c isnull or crib_c !~'^\w'
  union
select
  count(falnr) quantity,
  'nems_c' "columns"
from kis.nfal n
where nems_c isnull or nems_c !~'^\w'
  union
select
  count(falnr) quantity,
  'saps_imc' "columns"
from kis.nfal n
where saps_imc isnull or saps_imc !~'^\w'
  union
select
  count(falnr) quantity,
  'pim2_imc' "columns"
from kis.nfal n
where pim2_imc isnull or pim2_imc !~'^\w'
  union
select
  count(falnr) quantity,
  'crib_imc' "columns"
from kis.nfal n
where crib_imc isnull or crib_imc !~'^\w'
  union
select
  count(falnr) quantity,
  'nems_imc' "columns"
from kis.nfal n
where nems_imc isnull or nems_imc !~'^\w'
  union
select
  count(falnr) quantity,
  'respi_imc' "columns"
from kis.nfal n
where respi_imc isnull or respi_imc !~'^\w'
  union
select
  count(falnr) quantity,
  'readm' "columns"
from kis.nfal n
where readm isnull or readm !~'^\w'
  union
order by quantity, "columns"
;

--endtyp
--drop view if exists kis.dqa_nfal_endtyp cascade;
--create or replace view kis.dqa_nfal_endtyp
--as
select
  count(falnr) quantity,
  case
    when n.endtyp ~'^\w' then n.endtyp
    else null
  end endtyp
from kis.nfal n
group by n.endtyp
order by quantity desc
;

--drop view if exists kis.dqa_nfal_endtyp_jahr cascade;
--create or replace view kis.dqa_nfal_endtyp_jahr
--as
select
  case
    when erdat isnull then date_part('year', updat)
    else date_part('year', erdat)
  end jahr,
  count(falnr) quantity,
  case
    when n.endtyp ~'^\w' then n.endtyp
    else null
  end endtyp
from kis.nfal n
group by jahr, n.endtyp
order by jahr, quantity desc
;

--patw
--drop view if exists kis.dqa_nfal_patw cascade;
--create or replace view kis.dqa_nfal_patw
--as
select
  count(falnr) quantity,
  case
    when n.patw ~'^\w' then n.patw
    else null
  end patw
from kis.nfal n
group by n.patw
order by quantity desc
;

--drop view if exists kis.dqa_nfal_patw_jahr cascade;
--create or replace view kis.dqa_nfal_patw_jahr
--as
select
  case
    when erdat isnull then date_part('year', updat)
    else date_part('year', erdat)
  end jahr,
  count(falnr) quantity,
  case
    when n.patw ~'^\w' then n.patw
    else null
  end patw
from kis.nfal n
group by jahr, n.patw
order by jahr, quantity desc
;

--patgew
--drop view if exists kis.dqa_nfal_patgew cascade;
--create or replace view kis.dqa_nfal_patgew
--as
select
  count(falnr) quantity,
  case
    when n.patgew ~'^\w' then n.patgew
    else null
  end patgew
from kis.nfal n
group by n.patgew
order by quantity desc
;

--drop view if exists kis.dqa_nfal_patgew_jahr cascade;
--create or replace view kis.dqa_nfal_patgew_jahr
--as
select
  case
    when erdat isnull then date_part('year', updat)
    else date_part('year', erdat)
  end jahr,
  count(falnr) quantity,
  case
    when n.patgew ~'^\w' then n.patgew
    else null
  end patgew
from kis.nfal n
group by jahr, n.patgew
order by jahr, quantity desc
;

--gwein
--drop view if exists kis.dqa_nfal_gwein cascade;
--create or replace view kis.dqa_nfal_gwein
--as
select
  count(falnr) quantity,
  case
    when n.gwein ~'^\w' then n.gwein
    else null
  end gwein
from kis.nfal n
group by n.gwein
order by quantity desc
;

--drop view if exists kis.dqa_nfal_gwein_jahr cascade;
--create or replace view kis.dqa_nfal_gwein_jahr
--as
select
  case
    when erdat isnull then date_part('year', updat)
    else date_part('year', erdat)
  end jahr,
  count(falnr) quantity,
  case
    when n.gwein ~'^\w' then n.gwein
    else null
  end gwein
from kis.nfal n
group by jahr, n.gwein
order by jahr, quantity desc
;

--patgro
--drop view if exists kis.dqa_nfal_patgro cascade;
--create or replace view kis.dqa_nfal_patgro
--as
select
  count(falnr) quantity,
  case
    when n.patgro ~'^\w' then n.patgro
    else null
  end patgro
from kis.nfal n
group by n.patgro
order by quantity desc
;

--drop view if exists kis.dqa_nfal_patgro_jahr cascade;
--create or replace view kis.dqa_nfal_patgro_jahr
--as
select
  case
    when erdat isnull then date_part('year', updat)
    else date_part('year', erdat)
  end jahr,
  count(falnr) quantity,
  case
    when n.patgro ~'^\w' then n.patgro
    else null
  end patgro
from kis.nfal n
group by jahr, n.patgro
order by jahr, quantity desc
;

--grein
--drop view if exists kis.dqa_nfal_grein cascade;
--create or replace view kis.dqa_nfal_grein
--as
select
  count(falnr) quantity,
  case
    when n.grein ~'^\w' then n.grein
    else null
  end grein
from kis.nfal n
group by n.grein
order by quantity desc
;

--drop view if exists kis.dqa_nfal_grein_jahr cascade;
--create or replace view kis.dqa_nfal_grein_jahr
--as
select
  case
    when erdat isnull then date_part('year', updat)
    else date_part('year', erdat)
  end jahr,
  count(falnr) quantity,
  case
    when n.grein ~'^\w' then n.grein
    else null
  end grein
from kis.nfal n
group by jahr, n.grein
order by jahr, quantity desc
;

--resp
--drop view if exists kis.dqa_nfal_resp cascade;
--create or replace view kis.dqa_nfal_resp
--as
select
  count(falnr) quantity,
  case
    when n.resp ~'^\w' then n.resp
    else null
  end resp
from kis.nfal n
group by n.resp
order by quantity desc
;

--drop view if exists kis.dqa_nfal_resp_jahr cascade;
--create or replace view kis.dqa_nfal_resp_jahr
--as
select
  case
    when erdat isnull then date_part('year', updat)
    else date_part('year', erdat)
  end jahr,
  count(falnr) quantity,
  case
    when n.resp ~'^\w' then n.resp
    else null
  end resp
from kis.nfal n
group by jahr, n.resp
order by jahr, quantity desc
;

--delgw
--drop view if exists kis.dqa_nfal_delgw cascade;
--create or replace view kis.dqa_nfal_delgw
--as
select
  count(falnr) quantity,
  case
    when n.delgw ~'^\w' then n.delgw
    else null
  end delgw
from kis.nfal n
group by n.delgw
order by quantity desc
;

--drop view if exists kis.dqa_nfal_delgw_jahr cascade;
--create or replace view kis.dqa_nfal_delgw_jahr
--as
select
  case
    when erdat isnull then date_part('year', updat)
    else date_part('year', erdat)
  end jahr,
  count(falnr) quantity,
  case
    when n.delgw ~'^\w' then n.delgw
    else null
  end delgw
from kis.nfal n
group by jahr, n.delgw
order by jahr, quantity desc
;

--saps_c
--drop view if exists kis.dqa_nfal_saps_c cascade;
--create or replace view kis.dqa_nfal_saps_c
--as
select
  count(falnr) quantity,
  case
    when n.saps_c ~'^\w' then n.saps_c
    else null
  end saps_c
from kis.nfal n
group by n.saps_c
order by quantity desc
;

--drop view if exists kis.dqa_nfal_saps_c_jahr cascade;
--create or replace view kis.dqa_nfal_saps_c_jahr
--as
select
  case
    when erdat isnull then date_part('year', updat)
    else date_part('year', erdat)
  end jahr,
  count(falnr) quantity,
  case
    when n.saps_c ~'^\w' then n.saps_c
    else null
  end saps_c
from kis.nfal n
group by jahr, n.saps_c
order by jahr, quantity desc
;

--pim2_c
--drop view if exists kis.dqa_nfal_pim2_c cascade;
--create or replace view kis.dqa_nfal_pim2_c
--as
select
  count(falnr) quantity,
  case
    when n.pim2_c ~'^\w' then n.pim2_c
    else null
  end pim2_c
from kis.nfal n
group by n.pim2_c
order by quantity desc
;

--drop view if exists kis.dqa_nfal_pim2_c_jahr cascade;
--create or replace view kis.dqa_nfal_pim2_c_jahr
--as
select
  case
    when erdat isnull then date_part('year', updat)
    else date_part('year', erdat)
  end jahr,
  count(falnr) quantity,
  case
    when n.pim2_c ~'^\w' then n.pim2_c
    else null
  end pim2_c
from kis.nfal n
group by jahr, n.pim2_c
order by jahr, quantity desc
;

--crib_c
--drop view if exists kis.dqa_nfal_crib_c cascade;
--create or replace view kis.dqa_nfal_crib_c
--as
select
  count(falnr) quantity,
  case
    when n.crib_c ~'^\w' then n.crib_c
    else null
  end crib_c
from kis.nfal n
group by n.crib_c
order by quantity desc
;

--drop view if exists kis.dqa_nfal_crib_c_jahr cascade;
--create or replace view kis.dqa_nfal_crib_c_jahr
--as
select
  case
    when erdat isnull then date_part('year', updat)
    else date_part('year', erdat)
  end jahr,
  count(falnr) quantity,
  case
    when n.crib_c ~'^\w' then n.crib_c
    else null
  end crib_c
from kis.nfal n
group by jahr, n.crib_c
order by jahr, quantity desc
;

--nems_c
--drop view if exists kis.dqa_nfal_nems_c cascade;
--create or replace view kis.dqa_nfal_nems_c
--as
select
  count(falnr) quantity,
  case
    when n.nems_c ~'^\w' then n.nems_c
    else null
  end nems_c
from kis.nfal n
group by n.nems_c
order by quantity desc
;

--drop view if exists kis.dqa_nfal_nems_c_jahr cascade;
--create or replace view kis.dqa_nfal_nems_c_jahr
--as
select
  case
    when erdat isnull then date_part('year', updat)
    else date_part('year', erdat)
  end jahr,
  count(falnr) quantity,
  case
    when n.nems_c ~'^\w' then n.nems_c
    else null
  end nems_c
from kis.nfal n
group by jahr, n.nems_c
order by jahr, quantity desc
;

--saps_imc
--drop view if exists kis.dqa_nfal_saps_imc cascade;
--create or replace view kis.dqa_nfal_saps_imc
--as
select
  count(falnr) quantity,
  case
    when n.saps_imc ~'^\w' then n.saps_imc
    else null
  end saps_imc
from kis.nfal n
group by n.saps_imc
order by quantity desc
;

--drop view if exists kis.dqa_nfal_saps_imc_jahr cascade;
--create or replace view kis.dqa_nfal_saps_imc_jahr
--as
select
  case
    when erdat isnull then date_part('year', updat)
    else date_part('year', erdat)
  end jahr,
  count(falnr) quantity,
  case
    when n.saps_imc ~'^\w' then n.saps_imc
    else null
  end saps_imc
from kis.nfal n
group by jahr, n.saps_imc
order by jahr, quantity desc
;

--pim2_imc
--drop view if exists kis.dqa_nfal_pim2_imc cascade;
--create or replace view kis.dqa_nfal_pim2_imc
--as
select
  count(falnr) quantity,
  case
    when n.pim2_imc ~'^\w' then n.pim2_imc
    else null
  end pim2_imc
from kis.nfal n
group by n.pim2_imc
order by quantity desc
;

--drop view if exists kis.dqa_nfal_pim2_imc_jahr cascade;
--create or replace view kis.dqa_nfal_pim2_imc_jahr
--as
select
  case
    when erdat isnull then date_part('year', updat)
    else date_part('year', erdat)
  end jahr,
  count(falnr) quantity,
  case
    when n.pim2_imc ~'^\w' then n.pim2_imc
    else null
  end pim2_imc
from kis.nfal n
group by jahr, n.pim2_imc
order by jahr, quantity desc
;

--crib_imc
--drop view if exists kis.dqa_nfal_crib_imc cascade;
--create or replace view kis.dqa_nfal_crib_imc
--as
select
  count(falnr) quantity,
  case
    when n.crib_imc ~'^\w' then n.crib_imc
    else null
  end crib_imc
from kis.nfal n
group by n.crib_imc
order by quantity desc
;

--drop view if exists kis.dqa_nfal_crib_imc_jahr cascade;
--create or replace view kis.dqa_nfal_crib_imc_jahr
--as
select
  case
    when erdat isnull then date_part('year', updat)
    else date_part('year', erdat)
  end jahr,
  count(falnr) quantity,
  case
    when n.crib_imc ~'^\w' then n.crib_imc
    else null
  end crib_imc
from kis.nfal n
group by jahr, n.crib_imc
order by jahr, quantity desc
;

--nems_imc
--drop view if exists kis.dqa_nfal_nems_imc cascade;
--create or replace view kis.dqa_nfal_nems_imc
--as
select
  count(falnr) quantity,
  case
    when n.nems_imc ~'^\w' then n.nems_imc
    else null
  end nems_imc
from kis.nfal n
group by n.nems_imc
order by quantity desc
;

--drop view if exists kis.dqa_nfal_nems_imc_jahr cascade;
--create or replace view kis.dqa_nfal_nems_imc_jahr
--as
select
  case
    when erdat isnull then date_part('year', updat)
    else date_part('year', erdat)
  end jahr,
  count(falnr) quantity,
  case
    when n.nems_imc ~'^\w' then n.nems_imc
    else null
  end nems_imc
from kis.nfal n
group by jahr, n.nems_imc
order by jahr, quantity desc
;

--respi_imc
--drop view if exists kis.dqa_nfal_respi_imc cascade;
--create or replace view kis.dqa_nfal_respi_imc
--as
select
  count(falnr) quantity,
  case
    when n.respi_imc ~'^\w' then n.respi_imc
    else null
  end respi_imc
from kis.nfal n
group by n.respi_imc
order by quantity desc
;

--drop view if exists kis.dqa_nfal_respi_imc_jahr cascade;
--create or replace view kis.dqa_nfal_respi_imc_jahr
--as
select
  case
    when erdat isnull then date_part('year', updat)
    else date_part('year', erdat)
  end jahr,
  count(falnr) quantity,
  case
    when n.respi_imc ~'^\w' then n.respi_imc
    else null
  end respi_imc
from kis.nfal n
group by jahr, n.respi_imc
order by jahr, quantity desc
;

--readm
--drop view if exists kis.dqa_nfal_readm cascade;
--create or replace view kis.dqa_nfal_readm
--as
select
  count(falnr) quantity,
  case
    when n.readm ~'^\w' then n.readm
    else null
  end readm
from kis.nfal n
group by n.readm
order by quantity desc
;

--drop view if exists kis.dqa_nfal_readm_jahr cascade;
--create or replace view kis.dqa_nfal_readm_jahr
--as
select
  case
    when erdat isnull then date_part('year', updat)
    else date_part('year', erdat)
  end jahr,
  count(falnr) quantity,
  case
    when n.readm ~'^\w' then n.readm
    else null
  end readm
from kis.nfal n
group by jahr, n.readm
order by jahr, quantity desc
;
