-- Fachrichtung
alter table metadata_repository.fachrichtung 
rename to fachrichtung_tmp
;

create table metadata_repository.fachrichtung
(
  id serial primary key,
  sourceid varchar not null,
  fachrichtung varchar not null,
  description varchar,
  "source" varchar not null references metadata_repository.sources(sourceid) default 'kis',
  inserted timestamp not null default now(),
  unique(sourceid, fachrichtung)
);

insert into metadata_repository.fachrichtung(sourceid, fachrichtung) 
  select fachr, fachrichtung from metadata_repository.fachrichtung_tmp;

drop table metadata_repository.fachrichtung_tmp;
