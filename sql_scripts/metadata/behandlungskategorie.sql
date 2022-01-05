-- Behandlungskategorie

alter table if exists metadata_repository.behandlungskategorie
rename to behandlungskategorie_tmp;

create table metadata_repository.behandlungskategorie
(
  id serial primary key,
  sourceid varchar not null,
  behandlungskategorie varchar not null,
  description varchar,
  "source" varchar references metadata_repository.sources(sourceid) not null default 'kis',
  inserted timestamp not null default now(),
  unique(sourceid, behandlungskategorie)
);

insert into metadata_repository.behandlungskategorie(sourceid, behandlungskategorie) 
  select distinct bekat, bltxt from metadata_repository.behandlungskategorie_tmp;