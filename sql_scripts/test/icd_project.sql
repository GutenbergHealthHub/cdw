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

COPY icd_metainfo.icd_tmp from '/home/abel/cdw/ICD/icd_versions/codes/icd10gm2021.csv' WITH DELIMITER E';' CSV QUOTE E'\b';

--select * into icd_metainfo.icd_by_year from icd_metainfo.icd_tmp where ver = '2007';

insert into icd_metainfo.icd_by_year 
  select t.* from icd_metainfo.icd_tmp t 
  left join icd_metainfo.icd_by_year iby  
    on t.code = iby.code 
  where t.ver = '2021' and iby.code isnull;
 
 select *, altunt||altob "alter" from icd_metainfo.icd_by_year iby;
 
 select count(code), ver from icd_metainfo.icd_by_year group by ver 
  union 
select count(code), 'Gesamt' from icd_metainfo.icd_by_year order by ver;

 select count(code) from icd_metainfo.icd10gm ig ;

select distinct ebene, code, codeohnepunkt, titel, ver from icd_metainfo.icd_by_year where codeohnepunkt in (select codeohnepunkt from icd_metainfo.icd_by_year group by codeohnepunkt having count(code) > 1) order by codeohnepunkt, ver;

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

select count(ig.code) "Anzahl", 'Klassifikationsebene' "Spalte" from icd_metainfo.icd10gm ig join icd_metainfo.icd10gm_history igh on  igh.code = ig.code
where ig.ebene != igh.ebene and igh.verevent like 'U'
  union 
select count(ig.code) "Anzahl", 'Ort der Schlüsselnummer im Klassifikationsbaum' "Spalte" from icd_metainfo.icd10gm ig join icd_metainfo.icd10gm_history igh on igh.code = ig.code
where ig.ort != igh.ort and igh.verevent like 'U' 
  union 
select count(ig.code) "Anzahl", 'Art der Vier- und Fünfsteller' "Spalte" from icd_metainfo.icd10gm ig join icd_metainfo.icd10gm_history igh on igh.code = ig.code
where ig.art != igh.art and igh.verevent like 'U'
  union 
select count(ig.code) "Anzahl", 'Kapitelnummer' "Spalte" from icd_metainfo.icd10gm ig join icd_metainfo.icd10gm_history igh on igh.code = ig.code
where ig.kapnr != igh.kapnr and igh.verevent like 'U'
  union
select count(ig.code) "Anzahl", 'Erster Dreisteller der Gruppe' "Spalte" from icd_metainfo.icd10gm ig join icd_metainfo.icd10gm_history igh on igh.code = ig.code
where ig.grvon != igh.grvon and igh.verevent like 'U' 
  union 
select count(ig.code) "Anzahl", 'Schlüsselnummer ohne Strich, Stern und  Ausrufezeichen' "Spalte"from icd_metainfo.icd10gm ig join icd_metainfo.icd10gm_history igh on igh.code = ig.code
where ig.normcode != igh.normcode and igh.verevent like 'U' 
  union 
select count(ig.code) "Anzahl", 'Schlüsselnummer ohne Punkt, Strich, Stern und Ausrufezeichen' "Spalte" from icd_metainfo.icd10gm ig join icd_metainfo.icd10gm_history igh on igh.code = ig.code
where ig.codeohnepunkt != igh.codeohnepunkt  and igh.verevent like 'U'
  union 
select count(ig.code) "Anzahl", 'Klassentitel' "Spalte" from icd_metainfo.icd10gm ig join icd_metainfo.icd10gm_history igh on igh.code = ig.code
where ig.titel != igh.titel and igh.verevent like 'U'
  union 
select count(ig.code) "Anzahl", 'Paragraph 295' "Spalte" from icd_metainfo.icd10gm ig join icd_metainfo.icd10gm_history igh on igh.code = ig.code
where ig.p295 != igh.p295 and igh.verevent like 'U'
  union 
select count(ig.code) "Anzahl", 'Paragraph 301' "Spalte" from icd_metainfo.icd10gm ig join icd_metainfo.icd10gm_history igh on igh.code = ig.code
where ig.p301 != igh.p301 and igh.verevent like 'U' 
  union 
select count(ig.code) "Anzahl", 'Bezug zur Mortalitätsliste 1' "Spalte" from icd_metainfo.icd10gm ig join icd_metainfo.icd10gm_history igh on igh.code = ig.code
where ig.mortl1code != igh.mortl1code and igh.verevent like 'U'
  union 
select count(ig.code) "Anzahl", 'Bezug zur Mortalitätsliste 2' "Spalte" from icd_metainfo.icd10gm ig join icd_metainfo.icd10gm_history igh on igh.code = ig.code
where ig.mortl2code != igh.mortl2code and igh.verevent like 'U'
  union 
select count(ig.code) "Anzahl", 'Bezug zur Mortalitätsliste 3' "Spalte" from icd_metainfo.icd10gm ig join icd_metainfo.icd10gm_history igh on igh.code = ig.code
where ig.mortl3code != igh.mortl3code and igh.verevent like 'U'
  union 
select count(ig.code) "Anzahl", 'Bezug zur Mortalitätsliste 4' "Spalte" from icd_metainfo.icd10gm ig join icd_metainfo.icd10gm_history igh on igh.code = ig.code
where ig.mortl4code != igh.mortl4code and igh.verevent like 'U'
  union 
select count(ig.code) "Anzahl", 'Bezug zur Morbiditätsliste' "Spalte" from icd_metainfo.icd10gm ig join icd_metainfo.icd10gm_history igh on igh.code = ig.code
where ig.morblcode != igh.morblcode and igh.verevent like 'U'
  union 
select count(ig.code) "Anzahl", 'Geschlechtsbezug' "Spalte" from icd_metainfo.icd10gm ig join icd_metainfo.icd10gm_history igh on igh.code = ig.code
where ig.sexcode != igh.sexcode and igh.verevent like 'U' 
  union 
select count(ig.code) "Anzahl", 'Art des Fehlers bei Geschlechtsbezug' "Spalte" from icd_metainfo.icd10gm ig join icd_metainfo.icd10gm_history igh on igh.code = ig.code
where ig.sexfehlertyp != igh.sexfehlertyp and igh.verevent like 'U' 
  union 
select count(ig.code) "Anzahl", 'Untere Altersgrenze' "Spalte" from icd_metainfo.icd10gm ig join icd_metainfo.icd10gm_history igh on igh.code = ig.code
where ig.altunt != igh.altunt and igh.verevent like 'U' 
  union 
select count(ig.code) "Anzahl", 'Obere Altersgrenze' "Spalte" from icd_metainfo.icd10gm ig join icd_metainfo.icd10gm_history igh on igh.code = ig.code
where ig.altob != igh.altob and igh.verevent like 'U'
  union 
select count(ig.code) "Anzahl", 'Alter Fehlertyp' "Spalte" from icd_metainfo.icd10gm ig join icd_metainfo.icd10gm_history igh on igh.code = ig.code
where ig.altfehlertyp != igh.altfehlertyp and igh.verevent like 'U' 
  union 
select count(ig.code) "Anzahl", 'Sehr seltene Krankheit in Mitteleuropa' "Spalte" from icd_metainfo.icd10gm ig join icd_metainfo.icd10gm_history igh on igh.code = ig.code
where ig.exot != igh.exot and igh.verevent like 'U' 
  union 
select count(ig.code) "Anzahl", 'Belegt' "Spalte" from icd_metainfo.icd10gm ig join icd_metainfo.icd10gm_history igh on igh.code = ig.code
where ig.belegt != igh.belegt and igh.verevent like 'U' 
  union 
select count(ig.code) "Anzahl", 'Arzt-Meldepflicht' "Spalte" from icd_metainfo.icd10gm ig join icd_metainfo.icd10gm_history igh on igh.code = ig.code
where ig.ifsgmeldung != igh.ifsgmeldung  and igh.verevent like 'U'
  union 
select count(ig.code) "Anzahl", 'Anwendung der Laborausschlussziffer des einheitlisches Bewertungsmaßstab' "Spalte" from icd_metainfo.icd10gm ig join icd_metainfo.icd10gm_history igh on igh.code = ig.code
where ig.ifsglabor != igh.ifsglabor and igh.verevent like 'U'
order by "Anzahl" desc, "Spalte";


select 
  count(distinct ig.code) "Anzahl"
from icd_metainfo.icd10gm ig 
join icd_metainfo.icd10gm_history igh 
  on igh.code = ig.code
where ig.ebene != igh.ebene 
or ig.ort != igh.ort 
or ig.art != igh.art 
or ig.kapnr != igh.kapnr 
or ig.grvon != igh.grvon 
or ig.normcode != igh.normcode 
or ig.codeohnepunkt != igh.codeohnepunkt 
or ig.titel != igh.titel 
or ig.p295 != igh.p295 
or ig.p301 != igh.p301 
or ig.mortl1code != igh.mortl1code 
or ig.mortl2code != igh.mortl2code
or ig.mortl3code != igh.mortl3code
or ig.mortl4code != igh.mortl4code
or ig.morblcode != igh.morblcode 
or ig.sexcode != igh.sexcode 
or ig.sexfehlertyp != igh.sexfehlertyp 
or ig.altunt != igh.altunt 
or ig.altob != igh.altob 
or ig.altfehlertyp != igh.altfehlertyp 
or ig.exot != igh.exot 
or ig.belegt != igh.belegt 
or ig.ifsgmeldung != igh.ifsgmeldung 
or ig.ifsglabor != igh.ifsglabor;




and igh.verevent like 'U'



select distinct ig.code, ig.sexfehlertyp , igh.sexfehlertyp from icd_metainfo.icd10gm ig join icd_metainfo.icd10gm_history igh on igh.code = ig.code
where ig.sexfehlertyp != igh.sexfehlertyp 




select ig.code, ig.ebene icd10gm, igh.ebene history from icd_metainfo.icd10gm ig join icd_metainfo.icd10gm_history igh on  igh.code = ig.code
where ig.ebene != igh.ebene ;


select mortl1code, count(code) anzahl from icd_metainfo.kodes k group by mortl1code order by anzahl desc;





select distinct ebene, md5(ebene), ascii(ebene) , ver from icd_metainfo.icd10gm_history ig order by ebene;



select distinct ebene, md5(ebene), ascii(ebene) , ver from icd_metainfo.icd10gm_history ig order by ebene;

select distinct code, ver from icd_metainfo.icd10gm_history igh where ebene like '0'





select count(code) icd, vermodif from icd_metainfo.icd10gm_history igh group by vermodif
  union 
 select count(code), 'total' from icd_metainfo.icd10gm_history order by vermodif;

select * from icd_metainfo.icd10gm_history igh where verevent = 'U';



-- mort3
select count(distinct ig.code) "Anzahl", igh.ver "Originale Fassung", igh.vermodif "Fassung der Änderung" from icd_metainfo.icd10gm ig join icd_metainfo.icd10gm_history igh on igh.code = ig.code
where ig.mortl3code != igh.mortl3code and igh.verevent like 'U' and igh.mortl3code like 'UNDEF' group by igh.ver, igh.vermodif
union 
select count(ig.code) "Anzahl", '', '' from icd_metainfo.icd10gm ig join icd_metainfo.icd10gm_history igh on igh.code = ig.code
where ig.mortl3code != igh.mortl3code and igh.verevent like 'U' and igh.mortl3code like 'UNDEF' order by "Originale Fassung",  "Fassung der Änderung", "Anzahl" ;


--mort1
select count(distinct ig.code) "Anzahl", igh.ver "Originale Fassung", igh.vermodif "Fassung der Änderung" from icd_metainfo.icd10gm ig join icd_metainfo.icd10gm_history igh on igh.code = ig.code
where ig.mortl1code != igh.mortl1code and igh.verevent like 'U' and igh.mortl1code like 'UNDEF' group by igh.ver, igh.vermodif;

select count(ig.code) "Anzahl", case when igh.mortl1code not like 'UNDEF' then 'DEF' else igh.mortl1code end "Bezug zur Mortalitätsliste 1" from icd_metainfo.icd10gm ig join icd_metainfo.icd10gm_history igh on igh.code = ig.code
where ig.mortl1code != igh.mortl1code and igh.verevent like 'U' group by "Bezug zur Mortalitätsliste 1"


select count(mortl1ti) quantity, 'mort1' mort from icd_metainfo.mortl1 m1
  union
select count(mortl2ti), 'mort2' from icd_metainfo.mortl2 m2

select mortl2ti morti, 'm2' mort from icd_metainfo.mortl2 m2 where mortl2ti not in (select mortl1ti from icd_metainfo.mortl1 m1)
  union
select mortl1ti, 'm1' from icd_metainfo.mortl1 m1 where mortl1ti not in (select mortl2ti from icd_metainfo.mortl2 m2) order by mort, morti


select distinct altunt, altob, altunt||altob from icd_metainfo.icd_by_year iby where altunt not like '9999' order by altunt; 
select code, titel, altunt, altob from icd_metainfo.icd_by_year where altunt like 't028';
select distinct kapnr from icd_metainfo.icd_by_year iby order by kapnr ;


select kapnr, ver from icd_metainfo.icd_by_year iby where ver not like '2007' group by kapnr, ver having count(code) > 20; 

(
select kapnr from icd_metainfo.icd_by_year iby where ver not like '2007' group by kapnr, ver having count(code) > 20);


drop table icd_metainfo.icd_by_year_no_2007;
select *, altunt||altob "alter" into icd_metainfo.icd_by_year_alter from icd_metainfo.icd_by_year iby;

select distinct "alter" from icd_metainfo.icd_by_year_no_2007 where "alter" not like '999%';

select * from icd_metainfo.icd_by_year_no_2007 ig where titel like 'COV%';


select * from icd_metainfo.icd10gm_history igh where verevent = 'D'

select count(code) from icd_metainfo.icd_tmp it where ver = '2020' and code not in (select code from icd_metainfo.icd_tmp where ver = '2021');
