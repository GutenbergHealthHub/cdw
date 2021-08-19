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







   
truncate icd_metainfo.icd10gm;
truncate icd_metainfo.icd_tmp;
truncate icd_metainfo.kodes;
truncate icd_metainfo.icd10gm_history;

-- from files 
COPY icd_metainfo.icd_tmp from '/home/abel/cdw/ICD/icd_versions/codes/icd10gm2020.csv' WITH DELIMITER E';' CSV QUOTE E'\b';
select * from icd_metainfo.icd_tmp;



-- from bfarm
COPY icd_metainfo.kodes from '/home/abel/cdw/ICD/icd_versions/icd10gm2021syst-meta-20201111/Klassifikationsdateien/icd10gm2021syst_kodes.txt' WITH DELIMITER E';' CSV QUOTE E'\b';
select * from icd_metainfo.kodes;


select * from icd_metainfo.icd10gm ig;

select * from icd_metainfo.icd10gm_history igh;

select * from icd_metainfo.icd10gm ig where code like 'A04.7%';
select * from icd_metainfo.icd_tmp it where code like 'A05.-%';

select count(code) icd, ver from icd_metainfo.icd10gm ig group by ver
  union 
 select count(code), 'total' from icd_metainfo.icd10gm  order by ver;

select * from icd_metainfo.icd_tmp where code in 
  (select code from icd_metainfo.icd_tmp it group by code having count(ver) = 14) limit 40;
 
 select * from icd_metainfo.icd10gm ig where titel like 'Zik%';
 
SELECT 
  n.*,
  date_part('year', now())::varchar nver,
  'D' verevent
FROM icd_metainfo.icd_tmp n -- icd_metainfo.icd10gm ig 
left join icd_metainfo.kodes icd -- ok
  on icd.code = n.code
left join icd_metainfo.icd10gm_history igh 
  on igh.code = n.code
where icd.code isnull and igh.code isnull

select * from icd_metainfo.icd_tmp it where code like 'A04.7-%';

select * from icd_metainfo.icd10gm_history igh ;

select 
 'updated' tab, ig.ver ,
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
				  ig.ifsglabor
  from icd_metainfo.icd10gm ig where code like 'U81.44%'
  union
select 
 'history', ig.ver ,ig.ebene,
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
				  ig.ifsglabor from icd_metainfo.icd10gm_history ig where code like 'U81.44%'

select code, count(verevent) quantity from icd_metainfo.icd10gm_history icd group by code order by quantity desc;
select * from icd_metainfo.icd10gm_history where code like 'M89.83';

select * from icd_metainfo.icd10gm_history igh where verevent = 'U'

 
select distinct ver from icd_metainfo.icd10gm ig;
select distinct ver from icd_metainfo.icd10gm_history igh ;

-- modifications
select count(code) quanti, verevent  from icd_metainfo.icd10gm_history igh group by verevent;

select 


-- update von 2007 - null d v f erstmal raus
-- update nomenklaturen raus
-- spliterung (!, -, ) ... Ebene

select code, ver, vermodif from icd_metainfo.icd10gm_history igh where verevent = 'D';
select count(code) from icd_metainfo.icd10gm;

select * from icd_metainfo.icd10gm where code like 'U07.1%';
select count(code) quanti,  ver, verevent from icd_metainfo.icd10gm_history igh group by ver, verevent order by ver desc;
select * from icd_metainfo.
 