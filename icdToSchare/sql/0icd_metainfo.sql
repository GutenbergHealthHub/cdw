-- [Database], schema, tables
create database icd;
\c icd

CREATE SCHEMA IF NOT EXISTS icd_metainfo;

-- releases
create table icd_metainfo.icd10gm_release_info(
  icd10gm_version varchar(10) primary key,
  icd10gm_release date not null unique
);

-- metadata -> BfArM schema from Access to Postgres
CREATE TABLE icd_metainfo.Kapitel (
      KapNr varchar(3) PRIMARY KEY,
      KapTi VARCHAR(255) NOT NULL
);

CREATE TABLE icd_metainfo.Gruppen (
      GrVon VARCHAR(4) PRIMARY KEY,
      GrBis VARCHAR(4),
      KapNr VARCHAR(3) REFERENCES icd_metainfo.Kapitel(KapNr),
      GrTi  VARCHAR(255) NOT NULL
);

CREATE TABLE icd_metainfo.MorbL (
      MorbLCode VARCHAR(6) PRIMARY KEY,
      MorbLTi   VARCHAR(255) NOT NULL 
);

CREATE TABLE icd_metainfo.MortL1Grp (
      MortL1GrpCode VARCHAR(12) PRIMARY KEY,
      MortL1GrpTi   VARCHAR(255) NOT NULL
);

CREATE TABLE icd_metainfo.MortL1 (
      MortL1Code     VARCHAR(12) PRIMARY KEY,
      MortL1GrpCode  VARCHAR(12) REFERENCES icd_metainfo.MortL1Grp(MortL1GrpCode),
      MortL1Ti       VARCHAR(255) NOT NULL
);

CREATE TABLE icd_metainfo.MortL2 (
      MortL2Code     VARCHAR(6) PRIMARY KEY,
      MortL2Ti       VARCHAR(255) NOT NULL
);

CREATE TABLE icd_metainfo.MortL3Grp (
      MortL3GrpCode VARCHAR(12) PRIMARY KEY,
      MortL3GrpTi   VARCHAR(255) NOT NULL
);

CREATE TABLE icd_metainfo.MortL3 (
      MortL3Code     VARCHAR(12) PRIMARY KEY,
      MortL3GrpCode  VARCHAR(12) REFERENCES icd_metainfo.MortL3Grp(MortL3GrpCode),
      MortL3Ti       VARCHAR(255) NOT NULL
);

CREATE table icd_metainfo.MortL4 (
      MortL4Code     VARCHAR(5) CONSTRAINT MortL4CodeX PRIMARY KEY,
      MortL4Ti       VARCHAR(255) NOT NULL
);
--drop table if exists icd_metainfo.Kodes;
CREATE TABLE icd_metainfo.Kodes (
	  Ver			 VARCHAR(10) REFERENCES icd_metainfo.icd10gm_release_info(icd10gm_version),
      Ebene          VARCHAR(2),
      Ort            VARCHAR(2),
      Art            VARCHAR(2),
      KapNr          VARCHAR(3) REFERENCES icd_metainfo.Kapitel(KapNr),
      GrVon          VARCHAR(4) REFERENCES icd_metainfo.Gruppen(GrVon),
      Code           VARCHAR(8) PRIMARY KEY,
      NormCode       VARCHAR(7) UNIQUE NOT NULL,
      CodeOhnePunkt  VARCHAR(6) UNIQUE NOT NULL,
      Titel          VARCHAR(255) NOT NULL,
      Dreisteller    VARCHAR(255),
      Viersteller    VARCHAR(255),
      Fuenfsteller   VARCHAR(255),
      P295           VARCHAR(2),
      P301           VARCHAR(2),
      MortL1Code     VARCHAR(6) REFERENCES icd_metainfo.MortL1(MortL1Code),
      MortL2Code     VARCHAR(6) REFERENCES icd_metainfo.MortL2(MortL2Code),
      MortL3Code     VARCHAR(6) REFERENCES icd_metainfo.MortL3(MortL3Code),
      MortL4Code     VARCHAR(6) REFERENCES icd_metainfo.MortL4(MortL4Code),
      MorbLCode      VARCHAR(6) REFERENCES icd_metainfo.MorbL(MorbLCode),
      SexCode        VARCHAR(2),
      SexFehlerTyp   VARCHAR(2),
      AltUnt         VARCHAR(5),
      AltOb          VARCHAR(5),
      AltFehlerTyp   VARCHAR(2),
      Exot           VARCHAR(2),
      Belegt         VARCHAR(2),
      IfSGMeldung    VARCHAR(2),
      IfSGLabor      VARCHAR(2)
);

-- tables for all icd and historys

-- all icds
create table icd_metainfo.icd10gm(
  ver varchar references icd_metainfo.icd10gm_release_info(icd10gm_version), -- current version
  ebene varchar,
  ort varchar,
  art varchar,
  kapnr varchar,
  grvon varchar,
  code varchar primary key,
  normcode varchar,
  codeohnepunkt varchar,
  titel varchar,
  dreisteller varchar,
  viersteller varchar,
  fuenfsteller varchar, -- look off!! this column hat a strange character in the original name
  p295 varchar,
  p301 varchar,
  mortl1code varchar,
  mortl2code varchar,
  mortl3code varchar,
  mortl4code varchar,
  morblcode varchar,
  sexcode varchar,
  sexfehlertyp varchar,
  altunt varchar,
  altob varchar,
  altfehlertyp varchar,
  exot varchar,
  belegt varchar,
  ifsgmeldung varchar,
  ifsglabor varchar
);

-- icd history
create table icd_metainfo.icd10gm_history(
  ver varchar references icd_metainfo.icd10gm_release_info(icd10gm_version), -- new version
  ebene varchar,
  ort varchar,
  art varchar,
  kapnr varchar,
  grvon varchar,
  code varchar REFERENCES icd_metainfo.icd10gm(code),
  normcode varchar,
  codeohnepunkt varchar,
  titel varchar,
  dreisteller varchar,
  viersteller varchar,
  fuenfsteller varchar,
  p295 varchar,
  p301 varchar,
  mortl1code varchar,
  mortl2code varchar,
  mortl3code varchar,
  mortl4code varchar,
  morblcode varchar,
  sexcode varchar,
  sexfehlertyp varchar,
  altunt varchar,
  altob varchar,
  altfehlertyp varchar,
  exot varchar,
  belegt varchar,
  ifsgmeldung varchar,
  ifsglabor varchar,
  oldver varchar references icd_metainfo.icd10gm_release_info(icd10gm_version), -- old version
  verevent varchar check(verevent in ('D', 'I', 'U', 'DI')), --change in the new release
  primary key (code, ver, verevent)
);

create index if not exists ix_codes_history on icd_metainfo.icd10gm_history (code);
create index if not exists ix_codes_norm_history on icd_metainfo.icd10gm_history(normcode);
create index if not exists ix_codes_no_dot_history on icd_metainfo.icd10gm_history(codeohnepunkt);
create index if not exists ix_version_history on icd_metainfo.icd10gm_history(ver);
create index if not exists ix_old_version_history on icd_metainfo.icd10gm_history(oldver);
create index if not exists ix_event_history on icd_metainfo.icd10gm_history(verevent);

