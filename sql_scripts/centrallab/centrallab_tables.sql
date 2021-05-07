-- kis.observation definition

-- Drop table

-- DROP TABLE kis.observation;

CREATE TABLE centrallab.observation (
	ordernumber varchar NOT NULL,
	linenum int4 NOT NULL,
	valuetype varchar NULL,
	identifier varchar NULL,
	identifiertext varchar NULL,
	value varchar NULL,
	unit varchar NULL,
	referencerange varchar NULL,
	abnormalflags varchar NULL,
	status varchar NULL,
	CONSTRAINT pk_observation PRIMARY KEY (ordernumber, linenum)
);


-- kis.observationreport definition

-- Drop table

-- DROP TABLE kis.observationreport;

CREATE TABLE centrallab.observationreport (
	patient varchar NULL,
	encounter varchar NULL,
	sender varchar NULL,
	messagedatetime timestamp NOT NULL,
	fillerordernumberentity varchar NULL,
	fillerordernumbernamespace varchar NULL,
	observationdatetime timestamp NULL,
	observationenddatetime timestamp NULL,
	ordernumber varchar NOT NULL,
	orderstatus varchar NULL,
	orderingprovider varchar NULL,
	CONSTRAINT pk_observationreport PRIMARY KEY (ordernumber)
);

-- kis.loinc_mapping_central_lab definition

-- Drop table

-- DROP TABLE kis.loinc_mapping_central_lab;

CREATE TABLE centrallab.loinc_mapping_central_lab (
	id bigserial NOT NULL,
	analyteabbr varchar(10) NULL,
	loinc varchar(10) NULL,
	analytetext varchar(255) NULL,
	unit varchar(20) NULL,
	unitucum varchar(20) NULL,
	conversionfactor varchar(20) NULL,
	material varchar(255) NULL,
	laborprocedure varchar(100) NULL,
	validfrom date NULL,
	"source" varchar(255) NULL DEFAULT 'LOINC-Zentrallabor-Liste Version 1.0'::character varying,
	CONSTRAINT loinc_mapping_central_lab_pkey PRIMARY KEY (id)
);
