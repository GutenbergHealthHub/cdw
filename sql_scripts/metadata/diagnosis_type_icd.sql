-- Metadata repository

-- Diagnose type from icd
--drop table if exists metadata_repository.diagnosis_type_icd;
create table metadata_repository.diagnosis_type_icd(
  id serial primary key,
  sourceid varchar not null,
  diagnosis_type_icd varchar not null,
  description varchar,
  source varchar REFERENCES metadata_repository.sources(sourceid),
  inserted timestamp default(now()),
  unique(sourceid, source)
);

insert into metadata_repository.diagnosis_type_icd (sourceid, diagnosis_type_icd, source)
  values 
  ('*', 'Sterndiagnose', 'bfarm'),
  ('!', 'Zusatzdiagnose', 'bfarm'),
  ('+', 'Kreuzdiagnose', 'bfarm'),
  ('#', 'Nummernzeichen-Schlüssel (AT)', 'kis'),
  ('M', 'Morphologie Diagnose (SG)', 'kis')
;