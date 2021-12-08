-- Metadata repository

-- Diagnose typ
drop table if exists metadata_repository.diagnosis_type cascade;
create table metadata_repository.diagnosis_type(
  id serial primary key,
  sourceid varchar not null,
  diagnosis_type varchar not null,
  description varchar,
  source varchar REFERENCES metadata_repository.sources(sourceid),
  inserted timestamp default(now()),
  unique(sourceid, source)
);

insert into metadata_repository.diagnosis_type (sourceid, diagnosis_type, source)
  values 
  ('P', 'Hauptdiagnose', 'kis'),
  ('S', 'Nebendiagnose', 'kis'),
  ('HD', 'Hauptdiagnose', 'khentgg'),
  ('ND', 'Nebendiagnose', 'khentgg')
;