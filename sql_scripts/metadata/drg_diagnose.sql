-- metadata_repository.drg_prozedur definition

-- Drop table

-- DROP TABLE metadata_repository.drg_prozedur;

CREATE TABLE metadata_repository.drg_diagnose (
	id serial4 NOT null primary key,
	sourceid varchar NOT NULL,
	drg_diagnose varchar NOT NULL,
	description varchar NULL,
	"source" varchar NOT NULL DEFAULT 'kis' references metadata_repository.sources(sourceid),
	inserted timestamp NOT NULL DEFAULT now(),
	UNIQUE (sourceid, drg_diagnose)
);

insert into metadata_repository.drg_diagnose(sourceid, drg_diagnose)
  values 
    ('P', 'Hauptdiagnose'),
    ('S', 'Nebendiagnose');

-- metadata_repository.drg_prozedur foreign keys
