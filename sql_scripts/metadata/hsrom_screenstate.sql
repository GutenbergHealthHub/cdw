-- metadata_repository.arzt_anlass definition

-- Drop table

-- DROP TABLE metadata_repository.hsrom_screenstate;

CREATE TABLE metadata_repository.hsrom_screenstate (
	id serial4 primary key,
	sourceid varchar NOT NULL,
	hsrom_screenstate varchar NOT NULL,
	description varchar NULL,
	"source" varchar NOT NULL DEFAULT 'kis',
	inserted timestamp NOT NULL DEFAULT now(),
	UNIQUE (sourceid, hsrom_screenstate)
);

insert into metadata_repository.hsrom_screenstate (sourceid, hsrom_screenstate, description)
  values 
    ('pending', 'Test abgenommen', 'Test abgenommen'),
    ('pos', 'Positiv', null),
    ('neg', 'Negativ', null)
;

select * from metadata_repository.hsrom_screenstate;

