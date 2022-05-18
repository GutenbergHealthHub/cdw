/*ALTER TABLE kis."/HSROM/SCREENCOV" DROP CONSTRAINT screencov_pkey;

ALTER TABLE kis."/HSROM/SCREENCOV" ADD CONSTRAINT screencov_pkey PRIMARY KEY ("EINRI", "FALNR", "SETDATE", "SETTIME", "SCREENOPTION")

alter table kis."/HSROM/SCREENCOV" 
  drop column "MAND"
;


drop table kis.NFPZ;
create table kis."NFPZ"(
  "EINRI" varchar(5),
  "FALNR" varchar(11),
  "PERNR" varchar(11),
  "LFDNR" INT,      
  "FARZT" varchar(2),
  "BEGDT" DATE,     
  "ENDDT" date,     
  "ERDAT" date,     
  "UPDAT" date,     
  "STORN" boolean,  
  "STDAT" date,     
  "RetrievalDate" timestamp,
  primary key ("EINRI", "FALNR", "PERNR", "LFDNR")
);

create table kis."NBAU"(
  "BAUID" varchar(9),
  "BAUTY" varchar(3),
  "BAUNA" varchar,
  "BKURZ" varchar(9),
  "BAUKB" varchar(13),
  "LOEKZ" BOOLEAN,
  "LODAT" DATE,
  "ERDAT" DATE,
  "UPDAT" DATE,
  "BEGDT" DATE,
  "ENDDT" DATE,
  "RetrievalDate" TIMESTAMP,
  primary key ("BAUID")
);


create table kis."TN11H"(
  "UNTBE" varchar(9),
  "UEBBE" varchar(9),
  "UNTBT" varchar(3),
  "UEBBT" varchar(3),
  "UPDAT" date,     
  "RetrievalDate" timestamp,
  primary key ("UNTBE", "UEBBE")
);

alter table kis."NORG"
  add column "FACHR3" VARCHAR(5),
  add column "SPERR" BOOLEAN,
  add column "BEGDT" DATE,
  add column "ENDDT" DATE,
  add column "BELEG" boolean,
  add column "FREIG" boolean,
  add column "FAZUW" boolean,
  add column "PFZUW" boolean,
  add column "INTKZ" boolean,
  add column "AMBES" boolean,
  add column "ORGDS" boolean,
  add column "PPRKZ" boolean,
  add column "LOEKZ" boolean,
  add column "LODAT" date,
  add column "ERDAT" date,
  add column "UPDAT" date,
  add column "ARCOE" boolean,
  add column "ABRKZ" boolean,
  add column "KSTKZ" boolean,
  add column "TALST" boolean,
  add column "FACHR4" varchar(5),
  add column "FACHR5" varchar(5),
  add column "FACHRA" varchar(5),
  add column "FACHRB" varchar(5),
  add column "FACHRC" varchar(5),
  add column "FACHR6" varchar(5),
  add column "FACHR7" varchar(5),
  add column "SLWRK" varchar(5),
  add column "SLLGO" varchar(5),
  add column "BELAB" boolean,
  add column "FACHRD" varchar(5),
  add column "RetrievalDate" timestamp
;


create table kis."TN10H"(
  "UNTOR" varchar(9),
  "UEBOR" varchar(9),
  "BEGDT" DATE,
  "ENDDT" DATE,
  "UPDAT" date,     
  "RetrievalDate" timestamp,
  primary key ("UNTOR", "UEBOR")
);
*/
