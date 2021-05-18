drop table if exists metadata_repository.ops cascade;

drop table if exists metadata_repository.opsHistory cascade;



create table metadata_repository.ops(
  place varchar(1) not null check(place in ('T', 'N')),
  code varchar(10) primary key,
  titel varchar(255) not null,
  yearversion int check(yearversion <= date_part('year', now())),
  release_date date check (release_date < now()),
  isUsed boolean default false,
  sourceId varchar(10) default 'bfarm' references metadata_repository.sources(sourceId)
);


create table metadata_repository.opsHistory(
  id bigserial primary key,
  place varchar(1) not null check(place in ('T', 'N')),
  code varchar(8) not null,
  titel varchar(255) not null,
  isActive boolean default true,
  yearversion int check(yearversion <= date_part('year', now())),
  release_date date check (release_date < now()),
  release_update date check(release_update > release_date)
);
