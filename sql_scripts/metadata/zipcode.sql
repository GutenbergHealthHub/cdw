-- metadata_repository.zipcode definition

-- Drop table

-- DROP TABLE metadata_repository.zipcode;

CREATE TABLE metadata_repository.zipcode (
	id serial4 NOT NULL,
	zipcode varchar NULL,
	ort varchar NOT NULL,
	land varchar NOT NULL,
	"source" varchar NULL DEFAULT 'suplz'::character varying,
	CONSTRAINT zipcode_pkey PRIMARY KEY (id),
	CONSTRAINT zipcode_zipcode_check CHECK (((zipcode)::text ~ '\d{5}'::text))
);


-- metadata_repository.zipcode foreign keys

ALTER TABLE metadata_repository.zipcode ADD CONSTRAINT zipcode_source_fkey FOREIGN KEY ("source") REFERENCES metadata_repository.sources(sourceid);
