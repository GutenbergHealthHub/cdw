-- metadata_repository.arzt_anlass definition

-- Drop table

-- DROP TABLE metadata_repository.hsrom_screenoption;

CREATE TABLE metadata_repository.hsrom_screenvaccstat (
	id serial4 primary key,
	sourceid varchar NOT NULL,
	hsrom_screenvaccstat varchar NOT NULL,
	description varchar NULL,
	"source" varchar NOT NULL DEFAULT 'kis',
	inserted timestamp NOT NULL DEFAULT now(),
	UNIQUE (sourceid, hsrom_screenvaccstat)
);

insert into metadata_repository.hsrom_screenvaccstat (sourceid, hsrom_screenvaccstat)
  values 
    ('1', 'Geipmft'),
    ('2', 'Ungeimpft')
;

select * from metadata_repository.hsrom_screenvaccstat;

