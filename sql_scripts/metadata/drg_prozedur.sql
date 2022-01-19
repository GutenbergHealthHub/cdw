create table metadata_repository.drg_prozedur(
  id serial primary key,
  sourceid varchar not null,
  drg_prozedur varchar not null,
  description varchar,
  "source" varchar not null references metadata_repository.sources(sourceid) default 'kis',
  inserted timestamp not null default now(),
  unique(sourceid, drg_prozedur)
);

insert into metadata_repository.drg_prozedur(sourceid, drg_prozedur)
  values 
    ('P', 'Hauptprozedur'),
    ('S', 'Nebenprozedur')
;