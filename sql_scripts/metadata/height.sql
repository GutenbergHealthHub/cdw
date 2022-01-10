-- Maßeinheit Größe
-- drop table if exists metadata_repository.height_unity;
create table metadata_repository.height_unity(
  id serial primary key,
  sourceid varchar not null,
  height_id varchar not null,
  height_unity varchar not null,
  description varchar,
  "source" varchar not null references metadata_repository.sources(sourceid) default 'kis',
  inserted timestamp not null default now(),
  unique(sourceid, height_unity)
);

insert into metadata_repository.height_unity(sourceid, height_id, height_unity)
  values
    ('"', 'in', 'Zoll'),
    ('CM', 'cm', 'Zentimeter'),
    ('DM', 'dm', 'Dezimeter'),
    ('FT', 'ft', 'Fuß'),
    ('KM', 'km', 'Kilometer'),
    ('M', 'm', 'Meter'),
    ('MI', 'mi', 'Meile'),
    ('MM', 'mm', 'Millimiter'),
    ('NAM', 'nm', 'Nanometer'),
    ('YD', 'yd', 'Yard'),
    ('µM', 'µm', 'Mikrometer')
;

/*
update metadata_repository.height_unity
 set description = 'inch'where height_id = 'in';
*/
