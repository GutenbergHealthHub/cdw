-- Status color

drop table if exists metadata_repository.status_color;

create table metadata_repository.status_color(
  id serial primary key,
  sourceid varchar not null,
  status_color varchar not null,
  description varchar,
  "source" varchar not null references metadata_repository.sources(sourceid),
  inserted timestamp not null default now(),
  unique(sourceid, status_color, "source")
);

insert into metadata_repository.status_color(sourceid, status_color, "source")
  values
  ('GELB', 'GELB', 'copra'),
  ('ROT', 'ROT', 'copra'),
  ('ORANGE', 'ORANGE', 'copra'),
  ('BLAU', 'BLAU', 'copra'),
  ('GRUEN', 'GRÜN', 'copra')
;
  
