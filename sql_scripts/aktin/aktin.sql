--drop table if exists aktin.aktin_copra;

create table aktin.aktin_copra(
  fall_nummer   varchar(20) not null primary key,
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
  allergie              varchar(4000) 
);

create index ix_encounter on aktin.aktin_copra(fall_nummer);

