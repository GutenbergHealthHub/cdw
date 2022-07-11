-- metadata_repository.planr definition

-- Drop table

 DROP TABLE metadata_repository.plankennzeichen_raum_zuweisung;

CREATE TABLE metadata_repository.plankennzeichen_raum_zuweisung (
	id serial4 primary key,
	sourceid varchar NOT NULL,
	plankennzeichen_raum_zuweisung varchar(255) NOT NULL,
	"source" varchar NOT NULL DEFAULT 'kis' references metadata_repository.sources(sourceid),
	inserted timestamp NOT NULL DEFAULT now(),
	UNIQUE (sourceid, plankennzeichen_raum_zuweisung)
);

insert into metadata_repository.plankennzeichen_raum_zuweisung (sourceid, plankennzeichen_raum_zuweisung)
  values 
    ('P', 'Plan'),
    ('W', 'Warteliste'),
    ('', 'ist')
;

select * from metadata_repository.plankennzeichen_raum_zuweisung;

