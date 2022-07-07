-- metadata_repository.arzt_anlass definition

-- Drop table

-- DROP TABLE metadata_repository.arzt_anlass;

CREATE TABLE metadata_repository.hsrom_screeniso (
	id serial4 primary key,
	sourceid varchar NOT NULL,
	hsrom_screeniso varchar NOT NULL,
	description varchar NULL,
	"source" varchar NOT NULL DEFAULT 'kis',
	inserted timestamp NOT NULL DEFAULT now(),
	UNIQUE (sourceid, hsrom_screeniso)
);

insert into metadata_repository.hsrom_screeniso (sourceid, hsrom_screeniso)
  values 
    ('0', 'Heim-Quarentäne'),
    ('1', 'Isoliertstation'),
    ('2', 'Isolationsraum')
;

select * from metadata_repository.hsrom_screeniso;

