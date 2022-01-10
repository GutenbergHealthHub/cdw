-- Maßeinheit Gewicht
 drop table if exists metadata_repository.weight_unity;
create table metadata_repository.weight_unity(
  id serial primary key,
  sourceid varchar not null,
  weight_id varchar not null,
  weight_unity varchar not null,
  description varchar,
  "source" varchar not null references metadata_repository.sources(sourceid) default 'kis',
  inserted timestamp not null default now(),
  unique(sourceid, weight_unity)
);

insert into metadata_repository.weight_unity(sourceid, weight_id, weight_unity)
  values
    ('G', 'g', 'Gramm'),
    ('GR', 'g', 'Gramm'),
    ('KG', 'kg', 'Kilogramm'),
    ('LB', 'lb', 'Pfund engl'),
    ('MG', 'mg', 'Milligramm'),
    ('OZ', 'oz.', 'Unze'),
    ('TO', 't', 'Tonne'),
    ('TON', 't', 'US-Tonne'),
    ('µG', 'µg', 'Mikrogramm')
;
