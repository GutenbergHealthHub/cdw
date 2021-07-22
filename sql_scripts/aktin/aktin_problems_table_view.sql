--Problem in aktin_copra data

drop table if exists aktin.dqa_aktin_copra_problem;

create table aktin.dqa_aktin_copra_problem(
  id bigserial primary key,
  problem varchar not null,
  problem_value varchar not null,
  case_number   varchar(20) not null,
  admission timestamp not null,
  inserted timestamp not null default now(),
  unique(case_number, problem, problem_value)
);

-- view to show aktin copra data with problems 
drop view if exists aktin.dqa_v_aktin_copra_problem; 

create or replace view aktin.dqa_v_aktin_copra_problem
as
  select 
    'alter_aufnahme' problem, 
    alter_aufnahme::varchar problem_value,
    fall_nummer,
    zeitpunkt_aufnahme 
  from aktin.aktin_copra 
  where alter_aufnahme not between 0 and 120
    union 
  select 
    'geschlecht',
    geschlecht,
    fall_nummer,
    zeitpunkt_aufnahme 
  from aktin.aktin_copra
  left join metadata_repository.gender g
    on geschlecht = g.sourceid 
  where sourceid isnull 
    union
  select 
    'zeitpunkt_aufnahme',
    zeitpunkt_aufnahme::varchar,
    fall_nummer,
    zeitpunkt_aufnahme
  from aktin.aktin_copra ac 
  where zeitpunkt_aufnahme > zeitpunkt_entlassung 
  or zeitpunkt_aufnahme > zeitpunkt_ersteinsch 
  or zeitpunkt_aufnahme isnull
    union 
  select 
    'zeitpunkt_ersteinsch', 
    zeitpunkt_ersteinsch::varchar,
    fall_nummer,
    zeitpunkt_aufnahme
  from aktin.aktin_copra ac 
  where zeitpunkt_ersteinsch > zeitpunkt_entlassung 
  or zeitpunkt_ersteinsch isnull
    union 
  select 
    'zeitpunkt_entlassung',
    zeitpunkt_entlassung::varchar,
    fall_nummer,
    zeitpunkt_aufnahme
  from aktin.aktin_copra ac 
  where zeitpunkt_entlassung < zeitpunkt_aufnahme
    union 
  select 
    'aufnahmegrund',
    aufnahmegrund,
    fall_nummer ,
    zeitpunkt_aufnahme
  from aktin.aktin_copra ac 
  where aufnahmegrund isnull 
  or aufnahmegrund like ''
    union 
  select 
    'mts_status_farbe',
    mts_status_farbe ,
    fall_nummer,
    zeitpunkt_aufnahme
  from aktin.aktin_copra ac
  left join metadata_repository.status_color sc
    on sc.sourceid = ac.mts_status_farbe
  where sc.sourceid isnull
  or mts_status_farbe isnull
   union 
  select 
    'atemfrequenz',
    atemfrequenz::varchar,
    fall_nummer,
    zeitpunkt_aufnahme
  from aktin.aktin_copra ac 
  where atemfrequenz not between 0 and 99
    union 
  select 
    'herzfrequenz',
    herzfrequenz::varchar ,
    fall_nummer,
    zeitpunkt_aufnahme
  from aktin.aktin_copra ac 
  where herzfrequenz not between 0 and 300
    union 
  select 
    'systolic_pressure',
    systolic_pressure::varchar,
    fall_nummer,
    zeitpunkt_aufnahme
  from aktin.aktin_copra ac 
  where systolic_pressure not between 0 and 300
    union 
  select 
    'temperatur', 
    temperatur::varchar,
    fall_nummer,
    zeitpunkt_aufnahme 
  from aktin.aktin_copra ac 
  where temperatur not between 0 and 45
    union 
  select 
    'gcs_scorevalue',
    gcs_scorevalue::varchar,
    fall_nummer,
    zeitpunkt_aufnahme 
  from aktin.aktin_copra ac 
  where gcs_scorevalue not between 3 and 15
    union 
  select
    'gcs_augenint',
    gcs_augenint::varchar,
    fall_nummer ,
    zeitpunkt_aufnahme
  from aktin.aktin_copra ac 
  where gcs_augenint not between 1 and 4
   union 
  select 
    'gcs_motorik',
    gcs_motorik::varchar ,
    fall_nummer,
    zeitpunkt_aufnahme
  from aktin.aktin_copra ac 
  where gcs_motorik not between 1 and 4
    union 
  select 
    'gcs_lang',
    gcs_lang::varchar,
    fall_nummer ,
    zeitpunkt_aufnahme
  from aktin.aktin_copra ac 
  where gcs_lang not between 1 and 4
    union 
  select 
    'schmerzskala',
    schmerzskala::varchar,
    fall_nummer,
    zeitpunkt_aufnahme
  from aktin.aktin_copra ac 
  where schmerzskala not between 0 and 10
    union 
  select 
    'pupille_reaktion_links',
    pupille_reaktion_links ,
    fall_nummer,
    zeitpunkt_aufnahme
  from aktin.aktin_copra ac 
  left join metadata_repository.pupille_reaction pr
    on pr.sourceid = ac.pupille_reaktion_links 
  where pr.sourceid isnull
  and pupille_reaktion_links notnull
    union 
  select 
    'pupille_reaktion_rechts', 
    pupille_reaktion_rechts ,
    fall_nummer,
    zeitpunkt_aufnahme
  from aktin.aktin_copra ac 
  left join metadata_repository.pupille_reaction pr
    on pr.sourceid = ac.pupille_reaktion_rechts 
  where pr.sourceid isnull 
  and pupille_reaktion_rechts notnull
    union 
  select 
    'pupille_weite_links', 
    pupille_weite_links,
    fall_nummer ,
    zeitpunkt_aufnahme
  from aktin.aktin_copra ac 
  left join metadata_repository.pupille_width pw 
    on pw.sourceid = pupille_weite_links 
  where pw.sourceid isnull
  and pupille_weite_links notnull 
    union 
  select 
    'pupille_weite_rechts',
    pupille_weite_rechts,
    fall_nummer,
    zeitpunkt_aufnahme 
  from aktin.aktin_copra ac 
  left join metadata_repository.pupille_width pw 
    on pw.sourceid = pupille_weite_rechts 
  where pw.sourceid isnull 
  and pupille_weite_rechts notnull 
    union 
  select 
    'schwanger',
    schwanger ,
    fall_nummer,
    zeitpunkt_aufnahme
  from aktin.aktin_copra ac 
  where (geschlecht = 'M' or alter_aufnahme < 18 or alter_aufnahme > 65) 
  and schwanger = 'Patient ist anamnestisch schwanger'
  order by fall_nummer 
;

--select * from aktin.dqa_v_aktin_copra_problem;
