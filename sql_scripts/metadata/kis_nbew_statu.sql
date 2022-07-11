-- metadata_repository.planr definition

-- Drop table

-- DROP TABLE metadata_repository.intern_status_amb_besuch;

CREATE TABLE metadata_repository.intern_status_amb_besuch(
	id serial4 primary key,
	sourceid varchar NOT NULL,
	intern_status_amb_besuch varchar NOT NULL,
	"source" varchar NOT NULL DEFAULT 'kis' references metadata_repository.sources(sourceid),
	inserted timestamp NOT NULL DEFAULT now(),
	UNIQUE (sourceid, intern_status_amb_besuch)
);

insert into metadata_repository.intern_status_amb_besuch (sourceid, intern_status_amb_besuch)
  values 
    ('10', 'Warteliste'),
    ('20', 'Plan'),
    ('30', 'Ist'),
    ('40', 'Angemeldet'),
    ('50', 'Wartend'),
    ('55', 'Aufgerufen'),
    ('60', 'In Behandlung'),
    ('70', 'Behandlung abgeschlossen')    
;

select * from metadata_repository.intern_status_amb_besuch;
  

