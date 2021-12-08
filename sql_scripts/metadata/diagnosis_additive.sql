-- Metadata repository

-- Diagnose additive
--drop table if exists metadata_repository.diagnosis_additive;
create table metadata_repository.diagnosis_additive(
  id serial primary key,
  sourceid varchar not null,
  diagnosis_additive varchar not null,
  description varchar,
  source varchar REFERENCES metadata_repository.sources(sourceid),
  inserted timestamp default(now()),
  unique(sourceid, source)
);

insert into metadata_repository.diagnosis_additive (sourceid, diagnosis_additive, source)
  values 
  ('AK', 'akuter Schub', 'kis'),
  ('CP', 'Chron. progredient', 'kis'),
  ('DI', 'Dialyse', 'kis'),
  ('EF', 'z.Z.erscheinungsfrei', 'kis'),
  ('K', 'Komplikation', 'kis'),
  ('ZA', 'Zus.n.Amput.v.Extrem', 'kis'),
  ('ZN', 'Zustand nach', 'kis')
;
