-- metadata_repository.arzt_anlass definition

-- Drop table

-- DROP TABLE metadata_repository.hsrom_screenoption;

CREATE TABLE metadata_repository.hsrom_screentesttype (
	id serial4 primary key,
	sourceid varchar NOT NULL,
	hsrom_screentesttype varchar NOT NULL,
	description varchar NULL,
	"source" varchar NOT NULL DEFAULT 'kis',
	inserted timestamp NOT NULL DEFAULT now(),
	UNIQUE (sourceid, hsrom_screentesttype)
);

insert into metadata_repository.hsrom_screentesttype (sourceid, hsrom_screentesttype)
  values 
    ('0', 'COVID-19 PCR'),
    ('1', 'COVID-19 IgG')
;

select * from metadata_repository.hsrom_screentesttype;

