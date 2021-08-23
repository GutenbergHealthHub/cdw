
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
 




create table icd_metainfo.data_analisis(
   quantity int,
   year_icd int
);
COPY icd_metainfo.data_analisis from '/home/abel/cdw/ICD/icd_versions/codes/icd_year.csv' WITH DELIMITER E';' CSV QUOTE E'\b';

select quantity, year_icd::varchar from icd_metainfo.data_analisis
  union
select sum(quantity), 'Gesamt' from icd_metainfo.data_analisis
  union 
select round(avg(quantity)) , 'Durchschnitt' from icd_metainfo.data_analisis order by year_icd;


select * from icd_metainfo.kodes;


select * from icd_metainfo.icd10gm ig ;
select * from icd_metainfo.icd10gm_history igh; 

select count(code) icd, ver from icd_metainfo.icd10gm ig group by ver
  union 
 select count(code), 'total' from icd_metainfo.icd10gm  order by ver;

select 'ebene' "Spalte", count(distinct ig.code) "Anzahl" from icd_metainfo.icd10gm ig join icd_metainfo.icd10gm_history igh on  igh.code = ig.code
where ig.ebene != igh.ebene
  union 
select 'ort' "Spalte", count(distinct ig.code) "Anzahl" from icd_metainfo.icd10gm ig join icd_metainfo.icd10gm_history igh on igh.code = ig.code
where ig.ort != igh.ort 
  union 
select 'art' "Spalte", count(distinct ig.code) "Anzahl" from icd_metainfo.icd10gm ig join icd_metainfo.icd10gm_history igh on igh.code = ig.code
where ig.art != igh.art
  union 
select 'kapnr' "Spalte", count(distinct ig.code) "Anzahl" from icd_metainfo.icd10gm ig join icd_metainfo.icd10gm_history igh on igh.code = ig.code
where ig.kapnr != igh.kapnr
  union
select 'grvon' "Spalte", count(distinct ig.code) "Anzahl" from icd_metainfo.icd10gm ig join icd_metainfo.icd10gm_history igh on igh.code = ig.code
where ig.grvon != igh.grvon 







select ig.code, ig.ebene icd10gm, igh.ebene history from icd_metainfo.icd10gm ig join icd_metainfo.icd10gm_history igh on  igh.code = ig.code
where ig.ebene != igh.ebene ;








select distinct ebene, md5(ebene), ascii(ebene) , ver from icd_metainfo.icd10gm_history ig order by ebene;



select distinct ebene, md5(ebene), ascii(ebene) , ver from icd_metainfo.icd10gm_history ig order by ebene;

select distinct code, ver from icd_metainfo.icd10gm_history igh where ebene like '0'





select count(code) icd, vermodif from icd_metainfo.icd10gm_history igh group by vermodif
  union 
 select count(code), 'total' from icd_metainfo.icd10gm_history order by vermodif;

select * from icd_metainfo.icd10gm_history igh where verevent = 'U';
