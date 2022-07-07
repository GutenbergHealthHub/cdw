-- metadata_repository.arzt_anlass definition

-- Drop table

-- DROP TABLE metadata_repository.hsrom_screenoption;

CREATE TABLE metadata_repository.hsrom_screenothers (
	id serial4 primary key,
	sourceid varchar NOT NULL,
	hsrom_screenothers varchar NOT NULL,
	description varchar NULL,
	"source" varchar NOT NULL DEFAULT 'kis',
	inserted timestamp NOT NULL DEFAULT now(),
	UNIQUE (sourceid, hsrom_screenothers)
);

insert into metadata_repository.hsrom_screenothers (sourceid, hsrom_screenothers)
  values 
    ('1', 'Kontakt'),
    ('2', 'Andere'),
    ('3', 'Symptombeginn')
;

select * from metadata_repository.hsrom_screenothers;

