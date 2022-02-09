create table copra.copra_mii_icu_tmp(
  one_column varchar
);

copy copra.copra_mii_icu_tmp from '/home/abel/git_repos/cdw/csv/copra/fhir_mii_icu.csv';

create table copra.mii_icu_profile(
  profile_name varchar,
  profile_type varchar 
);


insert into copra.mii_icu_profile
select 
  mii_icu profile_name, 
  profile profile_type 
from 
  (select one_column mii_icu, row_number() over () n from copra.copra_mii_icu_tmp where one_column ~ 'MII|Vital') as n
join
  (select one_column profile, row_number() over () t from copra.copra_mii_icu_tmp where one_column !~ 'MII|Vital') as t 
    on n.n = t.t;

drop table if exists copra.copra_mii_icu_tmp;

select * from copra.mii_icu_profile mip; 