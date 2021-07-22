--Problem in aktin_copra data

-- Table with the problem in aktin copra data
create table aktin.aktin_copra_problem(
  problem varchar not null,
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
);

-- view to show aktin copra data with problems 
create or replace view aktin.v_aktin_copra_problem 
as
select 'alter_aufnahme' problem, * from aktin.aktin_copra where alter_aufnahme not between 0 and 120 
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
