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
    case
      when alter_aufnahme isnull then 'NULL'
      else alter_aufnahme::varchar 
    end problem_value,
    fall_nummer,
    zeitpunkt_aufnahme 
  from aktin.aktin_copra 
  where alter_aufnahme not between 0 and 120
    union 
  select 
    'geschlecht',
    case 
      when geschlecht isnull then 'NULL'
      else geschlecht
    end geschlecht,
    fall_nummer,
    zeitpunkt_aufnahme 
  from aktin.aktin_copra
  left join metadata_repository.gender g
    on geschlecht = g.sourceid 
  where sourceid isnull 
    union
  select 
    'zeitpunkt_aufnahme',
    case
      when zeitpunkt_aufnahme isnull then 'NULL'
      else zeitpunkt_aufnahme::varchar
    end zeitpunkt_aufnahme_var,
    fall_nummer,
    zeitpunkt_aufnahme
  from aktin.aktin_copra ac 
  where zeitpunkt_aufnahme > zeitpunkt_entlassung 
  or zeitpunkt_aufnahme > zeitpunkt_ersteinsch 
  or zeitpunkt_aufnahme isnull
    union 
  select 
    'zeitpunkt_ersteinsch', 
    case
      when zeitpunkt_ersteinsch isnull then 'NULL'
      else  zeitpunkt_ersteinsch::varchar
    end zeitpunkt_ersteinsch,
    fall_nummer,
    zeitpunkt_aufnahme
  from aktin.aktin_copra ac 
  where zeitpunkt_ersteinsch > zeitpunkt_entlassung 
  or zeitpunkt_ersteinsch isnull
    union 
  select 
    'zeitpunkt_entlassung',
    case
      when zeitpunkt_entlassung isnull then 'NULL' 
      else zeitpunkt_entlassung::varchar
    end zeitpunkt_entlassung,
    fall_nummer,
    zeitpunkt_aufnahme
  from aktin.aktin_copra ac 
  where zeitpunkt_entlassung < zeitpunkt_aufnahme
    union 
  select 
    'aufnahmegrund',
    case
      when aufnahmegrund isnull then 'NULL'
      else aufnahmegrund
    end aufnahmegrund,
    fall_nummer,
    zeitpunkt_aufnahme
  from aktin.aktin_copra ac 
  where aufnahmegrund isnull 
  or aufnahmegrund like ''
    union 
  select 
    'mts_status_farbe',
    case
      when mts_status_farbe isnull then 'NULL'
      else mts_status_farbe
    end mts_status_farbe,
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
    case
      when atemfrequenz isnull then 'NULL'
      else atemfrequenz::varchar
    end atemfrequenz,
    fall_nummer,
    zeitpunkt_aufnahme
  from aktin.aktin_copra ac 
  where atemfrequenz not between 0 and 99
    union 
  select 
    'herzfrequenz',
    case
      when herzfrequenz isnull then 'NULL'
      else herzfrequenz::varchar
    end herzfrequenz,
    fall_nummer,
    zeitpunkt_aufnahme
  from aktin.aktin_copra ac 
  where herzfrequenz not between 0 and 300
    union 
  select 
    'systolic_pressure',
    case 
      when systolic_pressure isnull then 'NULL'
      else systolic_pressure::varchar
    end systolic_pressure,
    fall_nummer,
    zeitpunkt_aufnahme
  from aktin.aktin_copra ac 
  where systolic_pressure not between 0 and 300
    union 
  select 
    'temperatur', 
    case
      when temperatur isnull then 'NULL'
      else temperatur::varchar
    end temperatur,
    fall_nummer,
    zeitpunkt_aufnahme 
  from aktin.aktin_copra ac 
  where temperatur not between 0 and 45
    union 
  select 
    'gcs_scorevalue',
    case
      when gcs_scorevalue isnull then 'NULL'
      else gcs_scorevalue::varchar
    end gcs_scorevalue,
    fall_nummer,
    zeitpunkt_aufnahme 
  from aktin.aktin_copra ac 
  where gcs_scorevalue not between 3 and 15
    union 
  select
    'gcs_augenint',
    case
      when gcs_augenint isnull then 'NULL'
      else gcs_augenint::varchar
    end gcs_augenint,
    fall_nummer ,
    zeitpunkt_aufnahme
  from aktin.aktin_copra ac 
  where gcs_augenint not between 1 and 4
   union 
  select 
    'gcs_motorik',
    case
      when gcs_motorik isnull then 'NULL'
      else gcs_motorik::varchar
    end gcs_motorik,
    fall_nummer,
    zeitpunkt_aufnahme
  from aktin.aktin_copra ac 
  where gcs_motorik not between 1 and 4
    union 
  select 
    'gcs_lang',
    case
      when gcs_lang isnull then 'NULL'
      else gcs_lang::varchar
    end gcs_lang,
    fall_nummer ,
    zeitpunkt_aufnahme
  from aktin.aktin_copra ac 
  where gcs_lang not between 1 and 4
    union 
  select 
    'schmerzskala',
    case
      when schmerzskala isnull then 'NULL'
      else schmerzskala::varchar
    end schmerzskala,
    fall_nummer,
    zeitpunkt_aufnahme
  from aktin.aktin_copra ac 
  where schmerzskala not between 0 and 10
    union 
  select 
    'pupille_reaktion_links',
    case
      when pupille_reaktion_links isnull then 'NULL'
      else pupille_reaktion_links
    end pupille_reaktion_links,
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
    case
      when pupille_reaktion_rechts isnull then 'NULL'
      else pupille_reaktion_rechts
    end pupille_reaktion_rechts,
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
    case
      when pupille_weite_links isnull then 'NULL'
      else pupille_weite_links
    end pupille_weite_links,
    fall_nummer,
    zeitpunkt_aufnahme
  from aktin.aktin_copra ac 
  left join metadata_repository.pupille_width pw 
    on pw.sourceid = pupille_weite_links 
  where pw.sourceid isnull
  and pupille_weite_links notnull 
    union 
  select 
    'pupille_weite_rechts',
    case
      when pupille_weite_rechts isnull then 'NULL'
      else pupille_weite_rechts
    end pupille_weite_rechts,
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
    case
      when schwanger isnull then 'NULL'
      else schwanger
    end schwanger,
    fall_nummer,
    zeitpunkt_aufnahme
  from aktin.aktin_copra ac 
  where (geschlecht = 'M' or alter_aufnahme < 18 or alter_aufnahme > 65) 
  and schwanger = 'Patient ist anamnestisch schwanger'
  order by fall_nummer 
;

--select * from aktin.dqa_v_aktin_copra_problem;
