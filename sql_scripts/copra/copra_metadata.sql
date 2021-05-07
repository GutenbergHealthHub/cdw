drop table if exists metadata_repository.copra_biosignal_tmp;
create table metadata_repository.copra_biosignal_tmp(
  bezeichnung varchar,
  varid varchar,
  einheit varchar,
  copra varchar
);

copy metadata_repository.copra_biosignal_tmp  FROM '/media/db/cdw_files/copra/biosignals.csv' WITH DELIMITER E';' CSV QUOTE E'"' header;

drop table if exists metadata_repository.copra_biosignal;
create table metadata_repository.copra_biosignal(
  id serial primary key,
  varid bigint not null,
  description varchar not null,  
  unit varchar,
  inserted timestamp not null default now(),
  source varchar references metadata_repository.sources(sourceid) default 'copra' not null,
  unique(varid, description)
);

insert into metadata_repository.copra_biosignal(varid, description, unit)
select varid::bigint, bezeichnung, einheit from metadata_repository.copra_biosignal_tmp cbt where varid notnull;

drop table if exists metadata_repository.copra_biosignal_tmp;
select * from metadata_repository.copra_biosignal limit 10;

