--select * into metadata_repository.icd_old from metadata_repository.icd i;
--drop table metadata_repository.icd cascade;

--drop table metadata_repository.icdHistory cascade;



create table metadata_repository.icd(
  code varchar(8) primary key,
  codenormal varchar(8) not null,
  codenodot varchar(8) not null,
  titel varchar(255) not null,
  p295 char(1) not null check(p295 in ('P', 'O', 'Z', 'V')),
  p301 char(1) not null check(p301 in ('P', 'O', 'Z', 'V')),
  yearversion int check(yearversion <= date_part('year', now())),
  release_date date check (release_date < now()),
  isUsed boolean default false,
  sourceId varchar(10) default 'bfarm' references metadata_repository.sources(sourceId)
);


create table metadata_repository.icdHistory(
  id bigserial primary key,
  code varchar(8) not null,
  codenormal varchar(8) not null,
  codenodot varchar(8) not null,
  titel varchar(255) not null,
  p295 char(1) not null,
  p301 char(1) not null,
  isActive boolean default true,
  yearversion int check(yearversion <= date_part('year', now())),
  release_date date check (release_date < now()),
  release_update date check(release_update > release_date)
);










