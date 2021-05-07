-- Behandlungskategorie

drop table if exists metadata_repository.behandlungskategorie_tmp;
create table metadata_repository.behandlungskategorie_tmp(
  MANDT varchar,
  EINRI varchar,
  BEKAT varchar,
  BEGDT varchar,
  ENDDT varchar,
  FALAR int,
  ACCCAT varchar,
  INPAT varchar,
  OUTPAT varchar,
  DAYPAT varchar,
  BKTXT varchar,
  BLTXT varchar
);

COPY metadata_repository.behandlungskategorie_tmp from '/media/db/cdw_files/kis/tn24.csv' WITH DELIMITER E',' CSV QUOTE E'"' header;



drop table if exists metadata_repository.behandlungskategorie;
create table metadata_repository.behandlungskategorie(
  id serial primary key,
  --mandt varchar,
  einri varchar,
  bekat varchar,
  bktxt varchar,
  bltxt varchar,
  "source" varchar references metadata_repository.sources(sourceid) default 'kis' not null,
  inserted timestamp not null default now(),
  unique(einri, bekat)
);

insert into metadata_repository.behandlungskategorie (einri, bekat, bktxt, bltxt)
  select einri, bekat, bktxt, bltxt  from metadata_repository.behandlungskategorie_tmp order by bekat;
 
drop table metadata_repository.behandlungskategorie_tmp;

