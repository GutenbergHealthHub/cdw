-- metadata_repository.plankennzeichen_raum_zuweisung definition

-- Drop table

-- DROP TABLE metadata_repository.plankennzeichen_raum_zuweisung;

CREATE TABLE metadata_repository.besuchtyp (
	id serial4 primary key,
	sourceid varchar NOT NULL,
	besuchtyp varchar(255) NOT NULL,
	"source" varchar NOT NULL DEFAULT 'kis' references metadata_repository.sources(sourceid),
	inserted timestamp NOT NULL DEFAULT now(),
	UNIQUE (sourceid, besuchtyp)
);


insert into metadata_repository.besuchtyp(sourceid, besuchtyp)
  values 
    ('1', 'Ersbesuch'),
    ('2', 'Wiederholbesuch'),
    ('', 'Unbestimmt')
;

select * from metadata_repository.besuchtyp;
