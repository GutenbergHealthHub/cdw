-- Typ of procedure
drop table if exists metadata_repository.prozedur_typ;
create table metadata_repository.prozedur_typ(
  id serial primary key,
  sourceid varchar not null,
  prozedur_typ varchar not null,
  description varchar,
  "source" varchar not null references metadata_repository.sources(sourceid) default 'kis',
  inserted timestamp not null default now(),
  unique(sourceid, prozedur_typ)
);

insert into metadata_repository.prozedur_typ(sourceid, prozedur_typ)
  values
    ('01', 'Erfaßt nach Endabrechnung'),
    ('73', 'Beatmungsdauer'),
    ('81', 'Mengenbezogene OPS-Codes')
;
    