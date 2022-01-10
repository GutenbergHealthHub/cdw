-- Fallendes

-- drop table if exists metadata_repository.fallendes cascade;

create table metadata_repository.fallendes(
  id serial primary key,
  sourceid varchar not null, 
  fallendes varchar not null,
  description varchar,
  "source" varchar not null references metadata_repository.sources(sourceid) default 'kis',
  inserted timestamp not null default now(),
  unique(sourceid, fallendes)
);

insert into metadata_repository.fallendes(sourceid, fallendes)
  values
    ('HE', 'Halbjahresende'),
    ('JE', 'Jahresende'),
    ('ME', 'Monatsende'),
    ('MS', 'Maschinelles Ende'),
    ('QE', 'Quartalsende')
;
