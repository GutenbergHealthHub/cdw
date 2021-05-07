-- Fachrichtungen

drop table if exists metadata_repository.tnkfa_tmp;
create table metadata_repository.tnkfa_tmp(
  MANDT varchar,
  FATYP varchar,
  FACHR varchar,
  FATXT varchar,
  INTEN varchar,
  SUBSP varchar,
  OBSTE varchar,
  EXTKZ varchar,
  UNQCD varchar  
);

copy metadata_repository.tnkfa_tmp from '/media/db/cdw_files/kis/tnkfa.csv' WITH DELIMITER E',' CSV QUOTE E'"' header;

drop table if exists metadata_repository.fachrichtung;
create table metadata_repository.fachrichtung(
  id serial primary key,
  fachr varchar not null,
  fachrichtung varchar not null,
  source varchar not null references metadata_repository.sources(sourceid) default 'kis',
  inserted timestamp not null default now(),
  unique(fachr, fachrichtung)
);

insert into metadata_repository.fachrichtung(fachr, fachrichtung)
select 
  FACHR,
  FATXT
from metadata_repository.tnkfa_tmp
;

drop table if exists metadata_repository.tnkfa_tmp; 
  
  
