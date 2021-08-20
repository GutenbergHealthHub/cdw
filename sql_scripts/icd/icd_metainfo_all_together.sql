truncate table icd_metainfo.kodes cascade;
truncate table icd_metainfo.mortl4 cascade;
truncate table icd_metainfo.mortl3 cascade;
truncate table icd_metainfo.mortl3grp cascade;
truncate table icd_metainfo.mortl2 cascade;
truncate table icd_metainfo.mortl1 cascade;
truncate table icd_metainfo.mortl1grp cascade;
truncate table icd_metainfo.morbl cascade;
truncate table icd_metainfo.gruppen cascade;
truncate table icd_metainfo.kapitel cascade;

drop table icd_metainfo.kodes;
drop table icd_metainfo.mortl4 cascade;
drop table icd_metainfo.mortl3 cascade;
drop table icd_metainfo.mortl3grp cascade; 
drop table icd_metainfo.mortl2 cascade;
drop table icd_metainfo.mortl1 cascade;
drop table icd_metainfo.mortl1grp cascade;
drop table icd_metainfo.morbl cascade;
drop table icd_metainfo.gruppen cascade;
drop table icd_metainfo.kapitel cascade;
drop table icd_metainfo.icd10gm_release_info cascade;




--CREATE SCHEMA IF NOT EXISTS icd_metainfo;
CREATE TABLE icd_metainfo.icd10gm_release_info(
  icd10gm_version VARCHAR(10) PRIMARY KEY,
  icd10gm_release DATE NOT NULL UNIQUE
);

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
      MortL1GrpCode VARCHAR(6) PRIMARY KEY,
      MortL1GrpTi   VARCHAR(255) NOT NULL
);

CREATE TABLE icd_metainfo.MortL1 (
      MortL1Code     VARCHAR(6) PRIMARY KEY,
      MortL1GrpCode  VARCHAR(6) REFERENCES icd_metainfo.MortL1Grp(MortL1GrpCode),
      MortL1Ti       VARCHAR(255) NOT NULL
);

CREATE TABLE icd_metainfo.MortL2 (
      MortL2Code     VARCHAR(6) PRIMARY KEY,
      MortL2Ti       VARCHAR(255) NOT NULL
);

CREATE TABLE icd_metainfo.MortL3Grp (
      MortL3GrpCode VARCHAR(6) PRIMARY KEY,
      MortL3GrpTi   VARCHAR(255) NOT NULL
);

CREATE TABLE icd_metainfo.MortL3 (
      MortL3Code     VARCHAR(6) PRIMARY KEY,
      MortL3GrpCode  VARCHAR(6) REFERENCES icd_metainfo.MortL3Grp(MortL3GrpCode),
      MortL3Ti       VARCHAR(255) NOT NULL
);

CREATE table icd_metainfo.MortL4 (
      MortL4Code     VARCHAR(5) CONSTRAINT MortL4CodeX PRIMARY KEY,
      MortL4Ti       VARCHAR(255) NOT NULL
);
drop table if exists icd_metainfo.Kodes;
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

COPY icd_metainfo.icd10gm_release_info from '/home/abel/cdw/ICD/icd_versions/codes/icd10gm_versions.dat' WITH DELIMITER E';' CSV QUOTE E'\b' Header;
insert into icd_metainfo.icd10gm_release_info
  values ('2021', '2020-11-11');
 
create table icd_metainfo.icd10gm(
  ver varchar references icd_metainfo.icd10gm_release_info(icd10gm_version), --default date_part('year', now())::varchar,
  ebene varchar,
  ort varchar,
  art varchar,
  kapnr varchar,
  grvon varchar,
  code varchar unique,
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
  ifsglabor varchar,
  isused boolean default false -- if this icd is used in others tables
);

--table for history of icd10gm
--drop table if exists icd_metainfo.icd10gm_history cascade;
create table icd_metainfo.icd10gm_history(
  ver varchar references icd_metainfo.icd10gm_release_info(icd10gm_version), -- original version
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
  vermodif varchar references icd_metainfo.icd10gm_release_info(icd10gm_version), -- new version
  verevent varchar check(verevent in ('D', 'U')) --change in the new release
);

create index ix_code_history on icd_metainfo.icd10gm_history(code);


CREATE OR REPLACE FUNCTION func_insert_new_icd10gm_bfarm() RETURNS TRIGGER AS $icd10gm_bfarm$
    begin
	    	-- old icd to history
	    	insert into icd_metainfo.icd10gm_history   
		    	SELECT 
				  ig.ver,
				  ig.ebene,
				  ig.ort,
				  ig.art,
				  ig.kapnr,
				  ig.grvon,
				  ig.code,
				  ig.normcode,
				  ig.codeohnepunkt,
				  ig.titel,
				  ig.dreisteller,
				  ig.viersteller,
				  ig.fuenfsteller,
				  ig.p295,
				  ig.p301,
				  ig.mortl1code,
				  ig.mortl2code,
				  ig.mortl3code,
				  ig.mortl4code,
				  ig.morblcode,
				  ig.sexcode,
				  ig.sexfehlertyp,
				  ig.altunt,
				  ig.altob,
				  ig.altfehlertyp,
				  ig.exot,
				  ig.belegt,
				  ig.ifsgmeldung,
				  ig.ifsglabor,
				  (select ver from icd_metainfo.kodes limit 1) vermodi, 
				  'D' verevent
				FROM icd_metainfo.icd10gm ig 
				left join new_table icd -- ok
				  on icd.code = ig.code
				left join icd_metainfo.icd10gm_history igh 
				  on igh.code = ig.code
				where icd.code isnull and igh.code isnull;
			
			-- update in normal table
			update icd_metainfo.icd10gm ig
		    	set 
				  ver = icd.ver,
				  ebene = icd.ebene,
				  ort = icd.ort,
				  art = icd.art,
				  kapnr = icd.kapnr,
				  grvon = icd.grvon,
				  normcode = icd.normcode,
				  codeohnepunkt = icd.codeohnepunkt,
				  titel = icd.titel,
				  dreisteller = icd.dreisteller,
				  viersteller = icd.viersteller,
				  fuenfsteller = icd.fuenfsteller,
				  p295 = icd.p295,
				  p301 = icd.p301,
				  mortl1code = icd.mortl1code,
				  mortl2code = icd.mortl2code,
				  mortl3code = icd.mortl3code,
				  mortl4code = icd.mortl4code,
				  morblcode = icd.morblcode,
				  sexcode = icd.sexcode,
				  sexfehlertyp = icd.sexfehlertyp,
				  altunt = icd.altunt,
				  altob = icd.altob,
				  altfehlertyp = icd.altfehlertyp,
				  exot = icd.exot,
				  belegt = icd.belegt,
				  ifsgmeldung = icd.ifsgmeldung,
				  ifsglabor = icd.ifsglabor
				  from new_table icd 
				where icd.code = ig.code and (
				  ig.ebene != icd.ebene
				  or ig.ort != icd.ort
				  or ig.art != icd.art
				  or ig.kapnr != icd.kapnr
				  or ig.grvon != icd.grvon
				  or ig.normcode != icd.normcode
				  or ig.codeohnepunkt != icd.codeohnepunkt
				  or ig.titel != icd.titel
				  or ig.dreisteller != icd.dreisteller
				  or ig.viersteller != icd.viersteller
				  or ig.fuenfsteller != icd.fuenfsteller
				  or ig.p295 != icd.p295
				  or ig.p301 != icd.p301
				  or ig.mortl1code != icd.mortl1code
				  or ig.mortl2code != icd.mortl2code
				  or ig.mortl3code != icd.mortl3code
				  or ig.mortl4code != icd.mortl4code
				  or ig.morblcode != icd.morblcode
				  or ig.sexcode != icd.sexcode
				  or ig.sexfehlertyp != icd.sexfehlertyp
				  or ig.altunt != icd.altunt
				  or ig.altob != icd.altob
				  or ig.altfehlertyp != icd.altfehlertyp
				  or ig.exot != icd.exot
				  or ig.belegt != icd.belegt
				  or ig.ifsgmeldung != icd.ifsgmeldung
				  or ig.ifsglabor != icd.ifsglabor)
				 ;
		
            INSERT INTO icd_metainfo.icd10gm
              SELECT 
                n.*, false 
              FROM new_table n 
              left join icd_metainfo.icd10gm icd
                on icd.code = n.code
              where icd.code isnull;
        RETURN NULL;
    END;
$icd10gm_bfarm$ LANGUAGE plpgsql;


-- trigger in table icd_metainfo.kode to insert new icds
CREATE TRIGGER tr_icd10gm_insert_from_bfarm
    AFTER INSERT ON icd_metainfo.kodes 
    REFERENCING NEW TABLE AS new_table
    FOR EACH STATEMENT EXECUTE FUNCTION func_insert_new_icd10gm_bfarm();

   
-- Function to insert modified icd10gm into history table 
-- insert update ICDs into the history table

CREATE OR REPLACE FUNCTION func_updated_to_icd10gm_history() RETURNS TRIGGER AS $icd10gm_to_history$
    begin
	    	-- updated icd to history
			insert into icd_metainfo.icd10gm_history   
		    	SELECT 
				  icd.ver,
				  icd.ebene,
				  icd.ort,
				  icd.art,
				  icd.kapnr,
				  icd.grvon,
				  icd.code,
				  icd.normcode,
				  icd.codeohnepunkt,
				  icd.titel,
				  icd.dreisteller,
				  icd.viersteller,
				  icd.fuenfsteller,
				  icd.p295,
				  icd.p301,
				  icd.mortl1code,
				  icd.mortl2code,
				  icd.mortl3code,
				  icd.mortl4code,
				  icd.morblcode,
				  icd.sexcode,
				  icd.sexfehlertyp,
				  icd.altunt,
				  icd.altob,
				  icd.altfehlertyp,
				  icd.exot,
				  icd.belegt,
				  icd.ifsgmeldung,
				  icd.ifsglabor,
				  ig.ver,
				  'U' verevent
				FROM new_table icd 
				join icd_metainfo.kodes ig 
				  on icd.code = ig.code
				where (ig.ebene != icd.ebene
				  or ig.ort != icd.ort
				  or ig.art != icd.art
				  or ig.kapnr != icd.kapnr
				  or ig.grvon != icd.grvon
				  or ig.normcode != icd.normcode
				  or ig.codeohnepunkt != icd.codeohnepunkt
				  or ig.titel != icd.titel
				  or ig.p295 != icd.p295
				  or ig.p301 != icd.p301
				  or ig.mortl1code != icd.mortl1code
				  or ig.mortl2code != icd.mortl2code
				  or ig.mortl3code != icd.mortl3code
				  or ig.mortl4code != icd.mortl4code
				  or ig.morblcode != icd.morblcode
				  or ig.sexcode != icd.sexcode
				  or ig.sexfehlertyp != icd.sexfehlertyp
				  or ig.altunt != icd.altunt
				  or ig.altob != icd.altob
				  or ig.altfehlertyp != icd.altfehlertyp
				  or ig.exot != icd.exot
				  or ig.belegt != icd.belegt
				  or ig.ifsgmeldung != icd.ifsgmeldung
				  or ig.ifsglabor != icd.ifsglabor)
				 ;		
        RETURN NULL; 
    END;
$icd10gm_to_history$ LANGUAGE plpgsql;

--trigger to update the history table with the old values
CREATE TRIGGER tr_icd10gm_updated_to_history
    AFTER UPDATE ON icd_metainfo.icd10gm 
    REFERENCING OLD TABLE AS new_table
    FOR EACH STATEMENT EXECUTE FUNCTION func_updated_to_icd10gm_history();  

select count(code) icd, ver from icd_metainfo.icd10gm ig group by ver
  union 
 select count(code), 'total' from icd_metainfo.icd10gm  order by ver;



select count(code) icd, vermodif from icd_metainfo.icd10gm_history igh group by vermodif
  union 
 select count(code), 'total' from icd_metainfo.icd10gm_history order by vermodif;



