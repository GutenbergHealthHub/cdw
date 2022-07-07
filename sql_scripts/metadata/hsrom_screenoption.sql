-- metadata_repository.arzt_anlass definition

-- Drop table

-- DROP TABLE metadata_repository.hsrom_screenoption;

CREATE TABLE metadata_repository.hsrom_screenoption (
	id serial4 primary key,
	sourceid varchar NOT NULL,
	hsrom_screenoption varchar NOT NULL,
	description varchar NULL,
	"source" varchar NOT NULL DEFAULT 'kis',
	inserted timestamp NOT NULL DEFAULT now(),
	UNIQUE (sourceid, hsrom_screenoption)
);

insert into metadata_repository.hsrom_screenoption (sourceid, hsrom_screenoption)
  values 
    ('0', 'Kein Screening erfordelich'),
    ('1', 'COVID-19 Test'),
    ('2', 'Isolation'),
    ('3', 'Andere'),
    ('4', 'Impfstatus')
;

select * from metadata_repository.hsrom_screenoption;

