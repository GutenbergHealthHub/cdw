-- kis.nbew definition

-- Drop table

-- DROP TABLE kis.nbew;

CREATE TABLE kis.nbew (
	einri varchar(4) NOT NULL,
	falnr varchar NOT NULL,
	lfdbew int4 NOT NULL,
	bewty bpchar(1) NULL,
	bwart varchar(2) NULL,
	bwidt date NULL,
	bwizt time NULL,
	planb bool NULL,
	statu varchar(2) NULL,
	bwedt date NULL,
	bwezt time NULL,
	plane bool NULL,
	lfdref int4 NULL,
	notkz bool NULL,
	unfkz varchar(3) NULL,
	orgfa varchar(8) NULL,
	orgpf varchar(8) NULL,
	zimmr varchar(8) NULL,
	bett varchar(8) NULL,
	planr varchar(10) NULL,
	orgau varchar(8) NULL,
	ezust varchar(2) NULL,
	todur varchar(3) NULL,
	erdat date NULL,
	updat date NULL,
	storn bool NULL,
	stdat date NULL,
	bekat varchar(6) NULL,
	nfgref int4 NULL,
	vgnref int4 NULL,
	stoid varchar(3) NULL,
	dspty varchar(8) NULL,
	visty varchar(1) NULL,
	bwgr1 varchar(2) NULL,
	bwgr2 varchar(2) NULL,
	tpart varchar(2) NULL,
	unfvs bool NULL,
	insev varchar(4) NULL,
	opart varchar(2) NULL,
	"class" varchar(4) NULL,
	rfsrc varchar(2) NULL,
	fachr varchar(4) NULL,
	unfrt varchar(4) NULL,
	unfav varchar(2) NULL,
	retrievaldate timestamp NULL,
	CONSTRAINT pk_einri_falnr_lfdbew PRIMARY KEY (einri, falnr, lfdbew)
);


-- kis.ndia definition

-- Drop table

-- DROP TABLE kis.ndia;

CREATE TABLE kis.ndia (
	einri varchar(4) NOT NULL,
	falnr varchar NOT NULL,
	lfdnr int4 NOT NULL,
	lfdbew int4 NULL,
	dkat1 varchar(2) NULL,
	dkey1 varchar(30) NULL,
	dkat2 varchar(2) NULL,
	dkey2 varchar(30) NULL,
	dkat_ref varchar(2) NULL,
	dkey_ref varchar(30) NULL,
	diadt date NULL,
	diazt time NULL,
	anzop int2 NULL,
	ewdia bool NULL,
	bhdia bool NULL,
	afdia bool NULL,
	endia bool NULL,
	fhdia bool NULL,
	khdia bool NULL,
	opdia bool NULL,
	sperr bool NULL,
	diasi varchar(1) NULL,
	erdat date NULL,
	updat date NULL,
	storn bool NULL,
	stdat date NULL,
	ardia bool NULL,
	podia bool NULL,
	tudia bool NULL,
	diabz bool NULL,
	diapr varchar(1) NULL,
	diagw varchar(2) NULL,
	diazs varchar(2) NULL,
	dialo varchar(2) NULL,
	diafp varchar(8) NULL,
	drg_dia_seqno int4 NULL,
	drg_category varchar(1) NULL,
	drg_relvant bool NULL,
	dtyp1 varchar(1) NULL,
	dtyp2 varchar(1) NULL,
	dtype_ref varchar(1) NULL,
	dia_link int4 NULL,
	ccl int2 NULL,
	dia_valdt date NULL,
	dia_pia_som bool NULL,
	retrievaldate timestamp NULL,
	CONSTRAINT pk_einri_falnr_lfdnr PRIMARY KEY (einri, falnr, lfdnr)
);

-- kis.nfal definition

-- Drop table

-- DROP TABLE kis.nfal;

CREATE TABLE kis.nfal (
	einri varchar(4) NOT NULL,
	falnr varchar NOT NULL,
	falar varchar(1) NULL,
	patnr varchar NULL,
	bekat varchar(6) NULL,
	abrkz varchar(1) NULL,
	sichv bool NULL,
	statu varchar(1) NULL,
	notan bool NULL,
	krzan bool NULL,
	endat date NULL,
	fgtyp varchar(1) NULL,
	kzkom bool NULL,
	enddt date NULL,
	erdat date NULL,
	updat date NULL,
	storn bool NULL,
	stdat date NULL,
	begdt date NULL,
	fatyp varchar(2) NULL,
	fachr varchar(4) NULL,
	endtyp varchar(2) NULL,
	patw bool NULL,
	patgew numeric(7,3) NULL,
	gwein varchar(3) NULL,
	patgro numeric(5,2) NULL,
	grein varchar(3) NULL,
	resp int4 NULL,
	delgw int2 NULL,
	saps_c int2 NULL,
	pim2_c int2 NULL,
	crib_c int2 NULL,
	nems_c int4 NULL,
	saps_imc int2 NULL,
	pim2_imc int2 NULL,
	crib_imc int2 NULL,
	nems_imc int4 NULL,
	respi_imc int4 NULL,
	readm bool NULL,
	retrievaldate timestamp NULL,
	CONSTRAINT pk_einri_falnr PRIMARY KEY (einri, falnr)
);

-- kis.nicp definition

-- Drop table

-- DROP TABLE kis.nicp;

CREATE TABLE kis.nicp (
	einri varchar(4) NOT NULL,
	falnr varchar NOT NULL,
	lnric varchar(10) NOT NULL,
	lfdbew int4 NULL,
	icpmk varchar(2) NULL,
	icpml varchar(10) NULL,
	icphc bool NULL,
	anzop int2 NULL,
	bgdop date NULL,
	bztop time NULL,
	eztop time NULL,
	lslok varchar(2) NULL,
	opart varchar(2) NULL,
	updat date NULL,
	storn bool NULL,
	stdat date NULL,
	drg_category varchar(1) NULL,
	drg_relevant bool NULL,
	orgfa varchar(8) NULL,
	orgpf varchar(8) NULL,
	endop date NULL,
	prtyp varchar(2) NULL,
	quantity numeric(20,8) NULL,
	unit varchar(3) NULL,
	ccl varchar(3) NULL,
	oplebspen bool NULL,
	retrievaldate timestamp NULL,
	CONSTRAINT pk_einri_falnr_lnric PRIMARY KEY (einri, falnr, lnric)
);

-- kis.npat definition

-- Drop table

-- DROP TABLE kis.npat;

CREATE TABLE kis.npat (
	einri varchar(4) NOT NULL,
	patnr varchar NOT NULL,
	gschl bpchar(1) NULL,
	gbdat int2 NULL,
	todkz bool NULL,
	toddt date NULL,
	todzt time NULL,
	toddb date NULL,
	todzb time NULL,
	todur varchar(3) NULL,
	land bpchar(3) NULL,
	pstlz varchar NULL,
	erdat date NULL,
	updat date NULL,
	storn bool NULL,
	stdat date NULL,
	race varchar NULL,
	retrievaldate timestamp NULL,
	CONSTRAINT pk_einri_patnr PRIMARY KEY (einri, patnr)
);
