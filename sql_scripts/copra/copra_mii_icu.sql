create table copra.copra_mii_icu_tmp(
  one_column varchar
);

copy copra.copra_mii_icu_tmp from '/home/abel/git_repos/cdw/csv/copra/fhir_mii_icu.csv';

drop table copra.mii_icu_profile;

create table copra.mii_icu_profile(
  profile_name varchar,
  profile_type varchar,
  status varchar
);


insert into copra.mii_icu_profile
select 
  mii_icu profile_name, 
  profile profile_type,
  'Active' status
from 
  (select one_column mii_icu, row_number() over () n from copra.copra_mii_icu_tmp where one_column ~ 'MII|Vital') as n
join
  (select one_column profile, row_number() over () t from copra.copra_mii_icu_tmp where one_column !~ 'MII|Vital') as t 
    on n.n = t.t;

drop table if exists copra.copra_mii_icu_tmp;

update copra.mii_icu_profile mip
  set status = 'Draft' where profile_name = 'MII_Blutdruck_Generisch';

copy copra.mii_icu_profile to '/home/abel/git_repos/masterthesis/data/csv/mii_icu.csv' WITH DELIMITER E';' HEADER CSV QUOTE E'\b';
