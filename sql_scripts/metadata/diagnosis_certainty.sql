-- Metadata repository

-- Diagnose certainty
--drop table if exists metadata_repository.diagnosis_certainty;
create table metadata_repository.diagnosis_certainty(
  id serial primary key,
  sourceid varchar not null,
  diagnosis_certainty varchar not null,
  description varchar,
  source varchar REFERENCES metadata_repository.sources(sourceid),
  inserted timestamp default(now()),
  unique(sourceid, source)
);

insert into metadata_repository.diagnosis_certainty (sourceid, diagnosis_certainty, source)
  values 
  ('A', 'Ausschluß', 'kis'),
  ('G', 'gesichert  für amb. Patienten', 'kis'),
  ('V', 'Verdacht auf', 'kis'),
  ('Z', 'Verdacht nach', 'kis')
;