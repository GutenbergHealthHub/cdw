-- Pupille width

drop table if exists metadata_repository.pupille_width;

create table metadata_repository.pupille_width(
  id serial primary key,
  sourceid varchar not null,
  pupille_width varchar not null,
  description varchar,
  "source" varchar not null references metadata_repository.sources(sourceid),
  inserted timestamp not null default now(),
  unique(sourceid, pupille_width, "source")
);

insert into metadata_repository.pupille_width(sourceid, pupille_width, "source")
  values
  ('eng', 'eng', 'copra'),
  ('extra', 'extra', 'copra'),
  ('mittel', 'mittel', 'copra'),
  ('weit', 'weit', 'copra')
;
