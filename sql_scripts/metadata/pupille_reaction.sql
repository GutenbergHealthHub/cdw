-- Pupille reaction

drop table if exists metadata_repository.pupille_reaction;

create table metadata_repository.pupille_reaction(
  id serial primary key,
  sourceid varchar not null,
  pupille_reaction varchar not null,
  description varchar,
  "source" varchar not null references metadata_repository.sources(sourceid),
  inserted timestamp not null default now(),
  unique(sourceid, pupille_reaction, "source")
);

insert into metadata_repository.pupille_reaction(sourceid, pupille_reaction, "source")
  values
  ('k', 'k', 'copra'),
  ('p', 'p', 'copra'),
  ('v', 'v', 'copra')
;
