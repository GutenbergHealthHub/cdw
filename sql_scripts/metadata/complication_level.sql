-- Metadata repository

-- Complication level
--drop table if exists metadata_repository.complication_level;
create table metadata_repository.complication_level(
  id serial primary key,
  sourceid varchar not null,
  complication_level varchar not null,
  description varchar,
  source varchar REFERENCES metadata_repository.sources(sourceid),
  inserted timestamp default(now()),
  unique(sourceid, source)
);

insert into metadata_repository.complication_level (sourceid, complication_level, source)
  values 
  ('0', 'Kein Schweregrad', 'kis'),
  ('1', 'Geringer Schweregrad', 'kis'),
  ('2', 'Mäßiger Schweregrad', 'kis'),
  ('3', 'Hoher Schweregrad', 'kis'),
  ('4', 'Katastrophaler Schweregrad', 'kis')
;