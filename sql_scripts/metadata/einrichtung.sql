-- Einrichtungen in kis

drop table if exists metadata_repository.einrichtung cascade;
create table metadata_repository.einrichtung(
  id serial primary key,
  sourceid varchar not null unique,
  einri varchar not null,
  description varchar,
  "source" varchar references metadata_repository.sources(sourceid) default 'kis' not null
);

insert into metadata_repository.einrichtung(sourceid, einri)
  select distinct einri sourceid, einri from kis.norg order by einri;


--select * from metadata_repository.einrichtung;

