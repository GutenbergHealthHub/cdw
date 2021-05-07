drop table if exists metadata_repository.sources;

create table metadata_repository.sources(
  sourceId varchar(10) primary key,--Bundesinstitut für Arzneimittel und Medizinprodukte
  sourceIni varchar(10),
  sourceName varchar(255) not null,
  sourceUrl varchar(255),
  sourceDescription text,
  inserted timestamp not null default now()
);

insert into metadata_repository.sources
  values (
    'bfarm', 
    'BfArM', 
    'Bundesinstitut für Arzneimittel und Medizinprodukte', 
    'https://www.dimdi.de'
    'Das Bundesinstitut für Arzneimittel und Medizinprodukte ist eine selbstständige Bundesoberbehörde im Geschäftsbereich des Bundesministeriums für Gesundheit.',
    now()
  );
  
create table metadata_repository.release_version(
  id serial primary key,
  ini varchar(7) not null,
  "version" int,
  "release" date not null  
);

insert into metadata_repository.release_version
  (ini, version, release)
values
  ('icd', '2007', '2006-09-28'),
  ('icd', '2008', '2007-09-19'),
  ('icd', '2009', '2008-09-11'),
  ('icd', '2010', '2009-10-21'),
  ('icd', '2011', '2010-09-17'),
  ('icd', '2012', '2011-09-15'),
  ('icd', '2013', '2012-09-17'),
  ('icd', '2014', '2013-09-20'),
  ('icd', '2015', '2014-09-19'),
  ('icd', '2016', '2015-09-23'),
  ('icd', '2017', '2016-09-26'),
  ('icd', '2018', '2017-09-19'),
  ('icd', '2019', '2018-09-20'),
  ('icd', '2020', '2019-09-20'),
  ('icd', '2021', '2020-11-17');

drop table if exists metadata_repository.p21_gender;

create table metadata_repository.p21_gender(
  id varchar(2) primary key,
  gender varchar(50) unique not null,
  source varchar(255) default ('§ 301 Abs. 3 SGB V, § 21 KHEntgG') not null
);

insert into metadata_repository.p21_gender (id, gender, source)
  values
  ('d','divers', '§ 301 Abs. 3 SGB V, § 21 KHEntgG')
  ,('x','unbestimmt', '§ 301 Abs. 3 SGB V, § 21 KHEntgG')
  ,('u','unbekannt', '(Alte Fassungen § 301 Abs. 3 SGB V und § 21 KHEntgG')
  ,('w','weiblich', '§ 301 Abs. 3 SGB V, § 21 KHEntgG')
  ,('m','männlich', '§ 301 Abs. 3 SGB V, § 21 KHEntgG')
;

drop table if exists metadata_repository.p21_remuneration_area;

create table metadata_repository.p21_remuneration_area(
  id varchar(4) primary key,
  remunerationArea varchar(50) unique not null,
  description varchar(255),
  source varchar(255) default ('§ 21 KHEntgG') not null
);

insert into metadata_repository.p21_remuneration_area(id, remunerationArea, description)
  values
  ('DRG','Diagnosis Related Group','Entgelt nach KHEntgG, i.d.R. DRG-Fallpauschale (KHEntgG-Entgeltbereich)')
  ,('PSY','Psychiatrische und Psychosomatische Einrichtungen','Entgelt nach BPflV für psychiatrische Einrichtungen und psychosomatische Einrichtungen gem. § 17d Abs. 1 KHG (BPflV-Entgeltbereich).') 
  ,('PIA',' Psychiatrische Institutsambulanzen','Entgelt nach § 120 SGB V für psychiatrische Institutsambulanzen gemäß § 118 SGB V (PIA-Entgeltbereich).')
 ;


drop table if exists metadata_repository.p21_admission_cause;

create table metadata_repository.p21_admission_cause(
 id varchar(2) primary key,
 admissionCause varchar(255) not null,
 source varchar(255) default ('§ 301 Abs. 3 SGB V, § 21 KHEntgG') not null
);

insert into metadata_repository.p21_admission_cause (id, admissionCause) 
  values
  ('E', 'Einweisung durch einen Arzt')
  ,('Z', 'Einweisung durch einen Zahnarzt')
  ,('N', 'Notfall')
  ,('R', 'Aufnahme nach vorausgehender Behandlung in einer Rehabilitationseinrichtung')
  ,('V', 'Verlegung mit Behandlungsdauer im verlegenden Krankenhaus länger als 24 Stunden')
  ,('A', 'Verlegung mit Behandlungsdauer im verlegenden Krankenhaus bis zu 24 Stunden')
  ,('G', 'Geburt')
  ,('B', 'Begleitperson oder mitaufgenommene Pflegekraft')
;


drop table if exists metadata_repository.p21_merging_reason;

create table metadata_repository.p21_merging_reason(
 id varchar(3) primary key,
 mergingReason varchar(255) not null,
 source varchar(255) default ('§ 301 Abs. 3 SGB V, § 21 KHEntgG') not null
);

insert into metadata_repository.p21_merging_reason (id, mergingReason)
  values
  ('OG', 'Wiederaufnahme nach § 2 Abs. 1 FPV1')
  ,('MD', 'Wiederaufnahme nach § 2 Abs. 2 FPV1')
  ,('KO', 'Wiederaufnahme nach § 2 Abs. 3 FPV1 (Komplikation)')
  ,('RU', 'Rückverlegung nach § 3 Abs. 3 FPV1')
  ,('WR', 'Kombinierte Fallzusammenführung nach § 3 Abs. 3 FPV1')
  ,('MF', 'Fallzusammenführung nach FPV1 von mehr als zwei Fällen mit mehr als einem Fallzusammenführungsgrund ohne Rückverlegung')
  ,('PW', 'Wiederaufnahme nach § 2 Abs. 1 PEPPV2')
  ,('PR', 'Rückverlegung nach § 3 Abs. 2 PEPPV2')
  ,('PM', 'Fallzusammenführung nach PEPPV2 von Fallepisoden mit mehr als einem Fallzusammenführungsgrund')
  ,('ZO', 'Wiederaufnahme nach § 2 Abs. 1 FPV1 bei 2 Eintagesfällen für die 2 Belegungstage gem. Klarstellung Nr. 10 abgerechnet werden')
  ,('ZM', 'Wiederaufnahme nach § 2 Abs. 2 FPV1 bei 2 Eintagesfällen für die 2 Belegungstage gem. Klarstellung Nr. 10 abgerechnet werden')
  ,('ZK', 'Wiederaufnahme nach § 2 Abs. 3 FPV1 (Komplikation) bei 2 Eintagesfällen für die 2 Belegungstage gem. Klarstellung Nr. 10 abgerechnet werden')
  ,('ZR', 'Rückverlegung nach § 3 Abs. 3 FPV1 bei 2 Eintagesfällen für die 2 Belegungstage gem. Klarstellung Nr. 10 abgerechnet werden')
  ,('ZW', 'Kombinierte Fallzusammenführung nach § 3 Abs. 3 FPV1 bei 2 Eintagesfällen für die 2 Belegungstage gem. Klarstellung Nr. 10 abgerechnet werden')
;


drop table if exists metadata_repository.p21_body_localisation;

create table metadata_repository.p21_body_localisation(
  id varchar(2) primary key,
  bodyLocalisation varchar(100),
 source varchar(255) default ('§ 301 Abs. 3 SGB V, § 21 KHEntgG') not null
);

insert into metadata_repository.p21_body_localisation (id, bodyLocalisation)
  values
  ('L', 'Links')
  ,('R', 'Rechts')
  ,('B', 'Beide Seite')
;

--admission reason
drop table if exists metadata_repository.p21_admission_reason_1_2;

create table metadata_repository.p21_admission_reason_1_2(
  id varchar(2) primary key,
  admissionReason12 varchar(255) not null,
  source varchar(255) default ('§ 301 Abs. 3 SGB V, § 21 KHEntgG') not null
);

insert into metadata_repository.p21_admission_reason_1_2
  values
  ('01', 'Krankenhausbehandlung, vollstationär')
  ,('02', 'Krankenhausbehandlung, vollstationär mit vorausgegangener vorstationärer Behandlung')
  ,('03', 'Krankenhausbehandlung, teilstationär')
  ,('04', 'vorstationäre Behandlung ohne anschließende vollstationäre Behandlung')
  ,('05', 'Stationäre Entbindung')
  ,('06', 'Geburt')
  ,('07', 'Wiederaufnahme wegen Komplikationen (Fallpauschale) nach KFPV 2003')
  ,('08', 'Stationäre Aufnahme zur Organentnahme')
  ,('09', 'frei')
  ,('10', 'Stationsäquivalente Behandlung')
; 

drop table if exists metadata_repository.p21_admission_reason_3;
create table metadata_repository.p21_admission_reason_3(
  id varchar(2) primary key,
  admissionReason3 varchar(255) not null,
  source varchar(255) default ('§ 301 Abs. 3 SGB V, § 21 KHEntgG') not null
);

insert into metadata_repository.p21_admission_reason_3 (id, admissionReason3)
  values
  ('0', 'Normaler Kostenträger')
  ,('2', 'Zuständigkeitswechsel des Kostenträgers')
  ,('4', 'Behandlungen im Rahmen von Verträgen zur integrierten Versorgung')
;


drop table if exists metadata_repository.p21_admission_reason_4;
create table metadata_repository.p21_admission_reason_4(
  id varchar(2) primary key,
  admissionReason4 varchar(255) not null,
  source varchar(255) default ('§ 301 Abs. 3 SGB V, § 21 KHEntgG') not null
);

insert into metadata_repository.p21_admission_reason_4 (id, admissionReason4)
  values
    ('1', 'Normalfall')
  ,('2', 'Arbeitsunfall/Berufskrankheit (§ 11 Abs. 5 SGB V)')
  ,('3', 'Verkehrsunfall/Sportunfall/Sonstiger Unfall (z.B. § 116 SGB X)')
  ,('4', 'Hinweis auf Einwirkung von äußerer Gewalt')
  ,('5', 'frei')
  ,('6', 'Kriegsbeschädigten-Leiden/BVG-Leiden')
  ,('7', 'Notfall')
;

-----------------------------------------
-- views

drop view if exists metadata_repository.p21_admission_reason;

create or replace view metadata_repository.p21_admission_reason
as
select a12.id || a3.id || a4.id admissionReason,
  a12.admissionReason12 position_1_2,
  a3.admissionReason3 position_3,
  a4.admissionReason4 position_4
    from metadata_repository.p21_admission_reason_1_2 a12, 
      metadata_repository.p21_admission_reason_3 a3, 
      metadata_repository.p21_admission_reason_4 a4
;

drop view if exists metadata_repository.p21_department;

create or replace view metadata_repository.p21_department 
as
select 
  p.prefix || d.code keys, 
  p.mean department_type,
  d.mean department 
    from metadata_repository.p21_department_prefix p, 
     metadata_repository.p21_department_code_mean d 
     order by keys; 


drop view if exists metadata_repository.p21_remission_relocation;

create or replace view metadata_repository.p21_remission_relocation
as
select mrrr12.id || mrrr3.id code,
  mrrr12.mean position_1_2,
  mrrr3.mean position_3
    from metadata_repository.p21_remission_relocation_1_2 mrrr12, metadata_repository.p21_remission_relocation_3 mrrr3
      where mrrr12.id in ('01', '02', '03', '04', '14', '15', '21')
  union
  select mrrr12.id || mrrr3.id code,
    mrrr12.mean position_1_2,
    mrrr3.mean position_3
      from metadata_repository.p21_remission_relocation_1_2 mrrr12, metadata_repository.p21_remission_relocation_3 mrrr3
        where mrrr12.id not in ('01', '02', '03', '04', '14', '15', '21') and mrrr3.id = '9'
        order by code
;
