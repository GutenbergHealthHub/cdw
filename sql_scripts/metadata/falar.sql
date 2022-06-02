create table metadata_repository.falar(
  id serial primary key,
  sourceid varchar not null unique,
  falar varchar not null,
  description varchar,
  inserted timestamp not null default now()
)


insert into metadata_repository.falar (sourceid, falar)
  values 
    ('1', 'stationär'),
    ('2', 'ambulant'),
    ('3', 'teilstationär')
;
select * from metadata_repository.falar;