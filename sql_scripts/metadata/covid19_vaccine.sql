-- metadata_repository.arzt_anlass definition

-- Drop table

-- DROP TABLE metadata_repository.hsrom_screenoption;

CREATE TABLE metadata_repository.covid19_vaccine (
	id serial4 primary key,
	sourceid varchar NOT NULL,
	vaccine varchar NOT NULL,
	manufacturer varchar,
	description varchar NULL,
	"source" varchar NOT NULL DEFAULT 'kis',
	inserted timestamp NOT NULL DEFAULT now(),
	UNIQUE (sourceid, vaccine)
);

insert into metadata_repository.covid19_vaccine (sourceid, vaccine, manufacturer, description)
  values 
    ('001', 'Comirnaty', 'BioNTec/Pfizer', 'mRNA Impfstoff'),
    ('002', 'Spikevax', 'Moderna Biotech', 'mRNA Impfstoff'),
    ('003', 'Vaxzevria', 'AstraZeneca', 'Vektor-Impfstoff'),
    ('004', 'COVID-19 Vaccine Janssen', 'Janssen-Cilag/Johnson & Johnson', 'Vektor-Impfstoff'),
    ('005', 'Nuvaxovid', 'Novavax', 'Proteinimpfstoff')
;

select * from metadata_repository.covid19_vaccine;

