--Problem in aktin_copra data

-- Table with the problem in aktin copra data
/*drop table if exists aktin.aktin_copra_problem;
create table aktin.aktin_copra_problem(
  problem varchar not null,
  problem_value not null,
  fall_nummer   varchar(20) not null,
  alter_aufnahme            integer,
  geschlecht       varchar(15),
  plz        varchar(15),
  zeitpunkt_aufnahme   timestamp,
  zeitpunkt_ersteinsch  timestamp,
  zeitpunkt_entlassung timestamp,
  cedis_code      varchar(3),
  aufnahmegrund            varchar(4000),
  mts_status_farbe         varchar(15),
  ee_system       varchar(20),
  atemfrequenz decimal(9,3),
  systolic_pressure          decimal(9,3),
  herzfrequenz  decimal(9,3),
  temperatur     decimal(9,3),
  gcs_scorevalue              integer,
  gcs_augenint  integer,
  gcs_lang            integer,
  gcs_motorik    integer,
  mts_praesdiagr             varchar(4000),
  mts_symptom varchar(4000),
  schmerzskala  integer,
  pupille_weite_links      varchar(30),
  pupille_reaktion_links varchar(30),
  pupille_weite_rechts  varchar(30),
  pupille_reaktion_rechts            varchar(30),
  tetanus             varchar(250),
  schwanger       varchar(250),
  allergie              varchar(4000),
  inserted timestamp not null default now(),
  id serial not null primary key
);*/

/*
 * -- view to show aktin copra data with problems 
create or replace view aktin.v_aktin_copra_problem 
as
select 'alter_aufnahme' problem, problem_value * from aktin.aktin_copra where alter_aufnahme not between 0 and 120 
  union 
select 'geschlecht' problem, * from aktin.aktin_copra where geschlecht not in ('M', 'W', 'D', 'U')
  union
select 'zeitpunkt_aufnahme > zeitpunkt_entlassung' problem, *  from aktin.aktin_copra ac where zeitpunkt_aufnahme > zeitpunkt_entlassung
  union 
select 'zeitpunkt_aufnahme > zeitpunkt_ersteinsch' problem, *  from aktin.aktin_copra ac where zeitpunkt_aufnahme > zeitpunkt_ersteinsch
  union 
select 'zeitpunkt_ersteinsch > zeitpunkt_entlassung' problem, *  from aktin.aktin_copra ac where zeitpunkt_ersteinsch > zeitpunkt_entlassung
  union 
select 'zeitpunkt_ersteinsch' problem, *  from aktin.aktin_copra ac where zeitpunkt_ersteinsch isnull
  union 
select 'zeitpunkt_aufnahme' problem, *  from aktin.aktin_copra ac where zeitpunkt_aufnahme isnull
  union 
select 'aufnahmegrund' problem, *  from aktin.aktin_copra ac where aufnahmegrund isnull or aufnahmegrund like ''
  union 
select 'mts_status_farbe' problem, *  from aktin.aktin_copra ac 
where mts_status_farbe isnull or mts_status_farbe like '' 
or mts_status_farbe not in ('GELB', 'ROT', 'ORANGE', 'BLAU', 'GRUEN')
  union 
select 'atemfrequenz' problem, *  from aktin.aktin_copra ac where atemfrequenz not between 0 and 99
  union 
select 'herzfrequenz' problem, *  from aktin.aktin_copra ac where herzfrequenz not between 0 and 300
  union 
select 'systolic_pressure' problem, *  from aktin.aktin_copra ac where systolic_pressure not between 0 and 300
  union 
select 'temperatur' problem, *  from aktin.aktin_copra ac where temperatur not between 0 and 45
  union 
select 'gcs_scorevalue' problem, *  from aktin.aktin_copra ac where gcs_scorevalue not between 3 and 15
  union 
select 'gcs_augenint' problem, *  from aktin.aktin_copra ac where gcs_augenint not between 1 and 4
  union 
select 'gcs_motorik' problem, *  from aktin.aktin_copra ac where gcs_motorik not between 1 and 4
  union 
select 'gcs_lang' problem, *  from aktin.aktin_copra ac where gcs_lang not between 1 and 4
  union 
select 'schmerzskala' problem, *  from aktin.aktin_copra ac where schmerzskala not between 0 and 10
  union 
select 'pupille_reaktion_links' problem, *  from aktin.aktin_copra ac where pupille_reaktion_links not in ('v', 'k', 'p')
  union 
select 'pupille_reaktion_rechts' problem, *  from aktin.aktin_copra ac where pupille_reaktion_rechts not in ('v', 'k', 'p')
  union 
select 'pupille_weite_links' problem, *  from aktin.aktin_copra ac where pupille_weite_links not in ('mittel', 'eng', 'weit', 'extra')
  union 
select 'pupille_weite_rechts' problem, *  from aktin.aktin_copra ac where pupille_weite_rechts not in ('mittel', 'eng', 'weit', 'extra')
  union 
select 'schwanger' problem, * from aktin.aktin_copra ac where (geschlecht = 'M' or alter_aufnahme < 18 or alter_aufnahme > 65) and schwanger = 'Patient ist anamnestisch schwanger'
order by problem
;

 * 
 * */

drop table if exists aktin.aktin_copra_problem_tmp;

create table aktin.aktin_copra_problem_tmp(
  id bigserial primary key,
  problem varchar not null,
  problem_value varchar not null,
  fall_nummer   varchar(20) not null,
  inserted timestamp not null default now(),
  unique(fall_nummer, problem)
);

-- view to show aktin copra data with problems 
--create or replace view aktin.aktin_dqa 
--as
  select 
    'alter_aufnahme' problem, 
    alter_aufnahme::varchar problem_value 
  from aktin.aktin_copra 
  where alter_aufnahme not between 0 and 120
    union 
  select 
    'geschlecht',
    geschlecht 
  from aktin.aktin_copra
  left join metadata_repository.gender g
    on geschlecht = g.sourceid 
  where sourceid isnull 
    union
  select 
    'zeitpunkt_aufnahme',
    zeitpunkt_aufnahme::varchar
  from aktin.aktin_copra ac 
  where zeitpunkt_aufnahme > zeitpunkt_entlassung 
  or zeitpunkt_aufnahme > zeitpunkt_ersteinsch 
  or zeitpunkt_aufnahme isnull
    union 
  select 
    'zeitpunkt_ersteinsch', 
    zeitpunkt_ersteinsch::varchar
  from aktin.aktin_copra ac 
  where zeitpunkt_ersteinsch > zeitpunkt_entlassung 
  or zeitpunkt_ersteinsch isnull
    union 
  select 
    'zeitpunkt_entlassung',
    zeitpunkt_entlassung::varchar
  from aktin.aktin_copra ac 
  where zeitpunkt_entlassung < zeitpunkt_aufnahme
    union 
  select 
    'aufnahmegrund',
    aufnahmegrund 
  from aktin.aktin_copra ac 
  where aufnahmegrund isnull 
  or aufnahmegrund like ''
    union 
  select 
    'mts_status_farbe',
    mts_status_farbe 
  from aktin.aktin_copra ac
  left join metadata_repository.status_color sc
    on sc.sourceid = ac.mts_status_farbe
  where sc.sourceid isnull
  or mts_status_farbe isnull
   union 
  select 
    'atemfrequenz',
    atemfrequenz::varchar
  from aktin.aktin_copra ac 
  where atemfrequenz not between 0 and 99
    union 
  select 
    'herzfrequenz',
    herzfrequenz::varchar 
  from aktin.aktin_copra ac 
  where herzfrequenz not between 0 and 300
    union 
  select 
    'systolic_pressure',
    systolic_pressure::varchar
  from aktin.aktin_copra ac 
  where systolic_pressure not between 0 and 300
    union 
  select 
    'temperatur', 
    temperatur::varchar 
  from aktin.aktin_copra ac 
  where temperatur not between 0 and 45
    union 
  select 
    'gcs_scorevalue',
    gcs_scorevalue::varchar 
  from aktin.aktin_copra ac 
  where gcs_scorevalue not between 3 and 15
    union 
  select
    'gcs_augenint',
    gcs_augenint::varchar 
  from aktin.aktin_copra ac 
  where gcs_augenint not between 1 and 4
   union 
  select 
    'gcs_motorik',
    gcs_motorik::varchar 
  from aktin.aktin_copra ac 
  where gcs_motorik not between 1 and 4
    union 
  select 
    'gcs_lang',
    gcs_lang::varchar 
  from aktin.aktin_copra ac 
  where gcs_lang not between 1 and 4
    union 
  select 
    'schmerzskala',
    schmerzskala::varchar
  from aktin.aktin_copra ac 
  where schmerzskala not between 0 and 10
    union 
  select 
    'pupille_reaktion_links',
    pupille_reaktion_links 
  from aktin.aktin_copra ac 
  left join metadata_repository.pupille_reaction pr
    on pr.sourceid = ac.pupille_reaktion_links 
  where pr.sourceid isnull
  and pupille_reaktion_links notnull
    union 
  select 
    'pupille_reaktion_rechts', 
    pupille_reaktion_rechts 
  from aktin.aktin_copra ac 
  left join metadata_repository.pupille_reaction pr
    on pr.sourceid = ac.pupille_reaktion_rechts 
  where pr.sourceid isnull 
  and pupille_reaktion_rechts notnull
    union 
  select 
    'pupille_weite_links', 
    pupille_weite_links 
  from aktin.aktin_copra ac 
  left join metadata_repository.pupille_width pw 
    on pw.sourceid = pupille_weite_links 
  where pw.sourceid isnull
  and pupille_weite_links notnull 
    union 
  select 
    'pupille_weite_rechts',
    pupille_weite_rechts 
  from aktin.aktin_copra ac 
  left join metadata_repository.pupille_width pw 
    on pw.sourceid = pupille_weite_rechts 
  where pw.sourceid isnull 
  and pupille_weite_rechts notnull 
    union 
  select 
    'schwanger',
    schwanger 
  from aktin.aktin_copra ac 
  where (geschlecht = 'M' or alter_aufnahme < 18 or alter_aufnahme > 65) 
  and schwanger = 'Patient ist anamnestisch schwanger'
  order by problem
;


