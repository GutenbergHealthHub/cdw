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


COPY icd_metainfo.kapitel from '/home/abel/cdw/ICD/icd_versions/icd10gm2021syst-meta-20201111/Klassifikationsdateien/icd10gm2021syst_kapitel.txt' WITH DELIMITER E';' CSV QUOTE E'\b';
COPY icd_metainfo.gruppen from '/home/abel/cdw/ICD/icd_versions/icd10gm2021syst-meta-20201111/Klassifikationsdateien/icd10gm2021syst_gruppen.txt' WITH DELIMITER E';' CSV QUOTE E'\b';
COPY icd_metainfo.morbl from '/home/abel/cdw/ICD/icd_versions/icd10gm2021syst-meta-20201111/Klassifikationsdateien/morbl_2021.txt' WITH DELIMITER E';' CSV QUOTE E'\b';
COPY icd_metainfo.mortl1grp from '/home/abel/cdw/ICD/icd_versions/icd10gm2021syst-meta-20201111/Klassifikationsdateien/mortl1grp_2021.txt' WITH DELIMITER E';' CSV QUOTE E'\b';
COPY icd_metainfo.mortl1 from '/home/abel/cdw/ICD/icd_versions/icd10gm2021syst-meta-20201111/Klassifikationsdateien/mortl1_2021.txt' WITH DELIMITER E';' CSV QUOTE E'\b';
COPY icd_metainfo.mortl2 from '/home/abel/cdw/ICD/icd_versions/icd10gm2021syst-meta-20201111/Klassifikationsdateien/mortl2_2021.txt' WITH DELIMITER E';' CSV QUOTE E'\b';
COPY icd_metainfo.mortl3grp from '/home/abel/cdw/ICD/icd_versions/icd10gm2021syst-meta-20201111/Klassifikationsdateien/mortl3grp_2021.txt' WITH DELIMITER E';' CSV QUOTE E'\b';
COPY icd_metainfo.mortl3 from '/home/abel/cdw/ICD/icd_versions/icd10gm2021syst-meta-20201111/Klassifikationsdateien/mortl3_2021.txt' WITH DELIMITER E';' CSV QUOTE E'\b';
COPY icd_metainfo.mortl4 from '/home/abel/cdw/ICD/icd_versions/icd10gm2021syst-meta-20201111/Klassifikationsdateien/mortl4_2021.txt' WITH DELIMITER E';' CSV QUOTE E'\b';
COPY icd_metainfo.kodes from '/home/abel/cdw/ICD/icd_versions/icd10gm2021syst-meta-20201111/Klassifikationsdateien/icd10gm2021syst_kodes.txt' WITH DELIMITER E';' CSV QUOTE E'\b';


/*
create table icd_metainfo.icd10gm_release_info(
  icd10gm_version varchar(10) not null,
  icd10gm_release date not null,
  primary key (icd10gm_version, icd10gm_release)
);
*/
--truncate icd_metainfo.icd10gm_release_info;
--COPY icd_metainfo.icd10gm_release_info from '/home/abel/cdw/ICD/icd_versions/codes/icd10gm_versions.dat' WITH DELIMITER E';' CSV QUOTE E'\b' Header;

--select * from icd_metainfo.icd10gm_release_info;
/*
-- temporary old icds from files 2007-2020

create table icd_metainfo.icd_tmp(
  ver varchar,
  ebene varchar,
  ort varchar,
  art varchar,
  kapnr varchar,
  grvon varchar,
  code varchar,
  normcode varchar,
  codeohnepunkt varchar,
  titel varchar,
  dreisteller varchar,
  viersteller varchar,
  fuenfsteller varchar, -- look off!! this column hat a strange character in the original name
  p295 varchar,
  p301 varchar,
  mort1code varchar,
  mort2code varchar,
  mort3code varchar,
  mort4code varchar,
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

-- all icd10gm from 2007 till now

create table icd_metainfo.icd10gm(
  ver varchar default date_part('year', now()),
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
  mort1code varchar,
  mort2code varchar,
  mort3code varchar,
  mort4code varchar,
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
  isused boolean default false
);


drop table if exists icd_metainfo.icd10gm_history;

--table for history of icd10gm
create table icd_metainfo.icd10gm_history(
  ver varchar,
  ebene varchar,
  ort varchar,
  art varchar,
  kapnr varchar,
  grvon varchar,
  code varchar,
  normcode varchar,
  codeohnepunkt varchar,
  titel varchar,
  dreisteller varchar,
  viersteller varchar,
  fuenfsteller varchar,
  p295 varchar,
  p301 varchar,
  mort1code varchar,
  mort2code varchar,
  mort3code varchar,
  mort4code varchar,
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
  vermodif varchar,
  verevent varchar check(verevent in ('D', 'U'))
)
*/



-- function to insert new icd10gm from bfarm into the table with all icd 
CREATE OR REPLACE FUNCTION func_insert_new_icd10gm_bfarm() RETURNS TRIGGER AS $new_icd10gm_bfarm$
    BEGIN
            INSERT INTO icd_metainfo.icd10gm
              SELECT 
                date_part('year', now()), n.*, false 
              FROM new_table n 
              left join icd_metainfo.icd10gm icd
                on icd.code = n.code
              where icd.code isnull;
        RETURN NULL; -- result is ignored since this is an AFTER trigger
    END;
$new_icd10gm_bfarm$ LANGUAGE plpgsql;


-- function to insert into history table the deprecated icd
CREATE OR REPLACE FUNCTION func_delete_new_icd10gm_bfarm() RETURNS TRIGGER AS $old_icd10gm_bfarm$
    BEGIN
            INSERT INTO icd_metainfo.icd10gm_history
              SELECT 
                date_part('year', now()) ver, n.*
              FROM new_table n 
              right join icd_metainfo.icd10gm icd
                on icd.code = n.code
              where n.code isnull;
        RETURN NULL; -- result is ignored since this is an AFTER trigger
    END;
$old_icd10gm_bfarm$ LANGUAGE plpgsql;


SELECT cast(date_part('year', now()) as varchar) ver, icd.* FROM icd_metainfo.kodes icd;

-- trigger in table icd_metainfo.kode to insert new icds
CREATE TRIGGER tr_icd10gm_insert_from_bfarm
    AFTER INSERT ON icd_metainfo.kodes 
    REFERENCING NEW TABLE AS new_table
    FOR EACH STATEMENT EXECUTE FUNCTION func_insert_new_icd10gm_bfarm();
   

-- function to insert new icd10gm from bfarm into the table with all icd 
CREATE OR REPLACE FUNCTION func_insert_new_icd10gm_files() RETURNS TRIGGER AS $new_icd10gm_files$
    BEGIN
            INSERT INTO icd_metainfo.icd10gm
              SELECT 
                n.*, false 
              FROM new_table n 
              left join icd_metainfo.icd10gm icd
                on icd.code = n.code
              where icd.code isnull;
        RETURN NULL;
    END;
$new_icd10gm_files$ LANGUAGE plpgsql;

-- trigger in table icd_metainfo.icd_tmp to insert new (old) icds 
CREATE TRIGGER tr_icd10gm_insert_from_files
    AFTER INSERT ON icd_metainfo.icd_tmp 
    REFERENCING NEW TABLE AS new_table
    FOR EACH STATEMENT EXECUTE FUNCTION func_insert_new_icd10gm_files();



   
truncate icd_metainfo.icd10gm;

-- from files 
truncate table icd_metainfo.icd_tmp;
COPY icd_metainfo.icd_tmp from '/home/abel/cdw/ICD/icd_versions/codes/icd10gm2007.csv' WITH DELIMITER E';' CSV QUOTE E'\b';
select * from icd_metainfo.icd_tmp;



-- from bfarm
truncate table icd_metainfo.kodes;
COPY icd_metainfo.kodes from '/home/abel/cdw/ICD/icd_versions/icd10gm2021syst-meta-20201111/Klassifikationsdateien/icd10gm2021syst_kodes.txt' WITH DELIMITER E';' CSV QUOTE E'\b';
select * from icd_metainfo.kodes;


select * from icd_metainfo.icd10gm ig;



select * from icd_metainfo.icd10gm ig where code like 'A04.7%';
select * from icd_metainfo.icd_tmp it where code like 'A05.-%';

select count(code) icd, ver from icd_metainfo.icd10gm ig group by ver
  union 
 select count(code), 'total' from icd_metainfo.icd10gm  order by ver;

select * from icd_metainfo.icd_tmp where code in 
  (select code from icd_metainfo.icd_tmp it group by code having count(ver) = 14) limit 40;
 
 
 select * from icd_metainfo.icd_tmp it where titel like '%Pria%';
--select 
