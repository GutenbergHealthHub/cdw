-- Gender

drop table if exists metadata_repository.gender cascade;

create table metadata_repository.gender(
  id serial primary key,
  sourceid varchar not null,
  gender varchar not null,
  description varchar,
  "source" varchar not null references metadata_repository.sources(sourceid),
  inserted timestamp not null default now(),
  unique(sourceid, gender, "source")
);

INSERT INTO metadata_repository.gender (sourceid,gender,"source",inserted) VALUES
	 ('1','mänlich','kis','2021-07-21 13:20:13.180987'),
	 ('2','weiblich','kis','2021-07-21 13:20:13.180987'),
	 ('3','unbekannt','kis','2021-07-21 13:20:13.180987'),
	 ('d','divers','khentgg','2021-07-21 13:20:13.180987'),
	 ('x','unbestimmt','khentgg','2021-07-21 13:20:13.180987'),
	 ('u','unbekannt','khentgg','2021-07-21 13:20:13.180987'),
	 ('w','weiblich','khentgg','2021-07-21 13:20:13.180987'),
	 ('m','mänlich','khentgg','2021-07-21 13:20:13.180987'),
	 ('M','männlich','gtds','2021-07-21 13:20:13.180987'),
	 ('W','weiblich','gtds','2021-07-21 13:20:13.180987');
INSERT INTO metadata_repository.gender (sourceid,gender,"source",inserted) VALUES
	 ('X','unbekannt','gtds','2021-07-21 13:20:13.180987'),
	 ('M','männlich','copra','2021-07-21 13:55:25.30272'),
	 ('U','unbekannt','copra','2021-07-21 13:55:25.30272'),
	 ('W','weiblich','copra','2021-07-21 13:55:25.30272'),
	 ('D','divers','copra','2021-07-21 13:55:25.30272');
  
