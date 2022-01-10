-- Falltyp

-- drop table if exists metadata_repository.falltyp cascade;

create table metadata_repository.falltyp(
  id serial primary key,
  sourceid varchar not null, 
  falltyp varchar not null,
  description varchar,
  "source" varchar not null references metadata_repository.sources(sourceid) default 'kis',
  inserted timestamp not null default now(),
  unique(sourceid, falltyp)
);

insert into metadata_repository.falltyp(sourceid, falltyp)
  values
    ('FR', 'NC Früh Reha B'),
    ('I1', 'IV TK KoroChir im Budget'),
    ('I2', 'IV TK KorChir außerh.Budget'),
    ('I3', 'IV DAK Schlaganfall'),
    ('I4', 'Koop.Prax.Rittg.Katsaros'),
    ('I5', 'Kooperation Praxis Hauser'),
    ('I6', 'Kooperation Dr. Menzel'),
    ('I7', 'Kooperation Dr. Kuner'),
    ('I8', 'Kooperation Cardiopraxis'),
    ('I9', 'Kooperation KK-Koblenz-Mo'),
    ('IA', 'Kooperation Prof. Haghi'),
    ('IB', 'Kooperation Abujarour'),
    ('KT', 'Kindertraumatologie'),
    ('Z1', 'Illegal'),
    ('Z2', 'SZ/KTR unkl./Pflichtvers.'),
    ('Z3', 'Schlaflabor'),
    ('Z4', 'SPZ'),
    ('Z5', 'Fallartwechsel in VT')
;
