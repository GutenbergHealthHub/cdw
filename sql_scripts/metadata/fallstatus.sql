-- Fallstatus

--drop table if exists metadata_repository.fallstatus cascade;
create table metadata_repository.fallstatus(
  id serial primary key,
  sourceid varchar not null,
  fallstatus varchar not null,
  description varchar,
  "source" varchar references metadata_repository.sources(sourceid) default 'kis' not null,
  inserted timestamp not null default now(),
  unique(sourceid, fallstatus)
);

insert into metadata_repository.fallstatus(sourceid, fallstatus)
  values
  ('E', 'Fall ist abgeschlossen'),
  ('I', 'Fall ist aktuell'),
  ('P', 'Fall ist im Planstatus')
;

--select * from metadata_repository.fallstatus;