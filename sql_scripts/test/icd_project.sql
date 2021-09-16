 drop table icd_metainfo.icd10gm_history;
 drop table icd_metainfo.icd10gm cascade;
drop table icd_metainfo.kodes cascade;

select * from icd_metainfo.icd10gm_history igh where code like 'K55.8%' order by code, ver;




 select *, altunt||altob "alter" from icd_metainfo.icd_by_year iby;
 
 select count(code), ver from icd_metainfo.icd_by_year group by ver 
  union 
select count(code), 'Gesamt' from icd_metainfo.icd_by_year order by ver;

 select count(code) from icd_metainfo.icd10gm ig ;

select distinct ebene, code, codeohnepunkt, titel, ver from icd_metainfo.icd_by_year where codeohnepunkt in (select codeohnepunkt from icd_metainfo.icd_by_year group by codeohnepunkt having count(code) > 1) order by codeohnepunkt, ver;

select * from icd_metainfo.icd10gm ig;

select * from icd_metainfo.icd10gm_history igh;


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
 


select count(code) icd, ver from icd_metainfo.icd10gm ig group by ver
  union 
 select count(code), 'total' from icd_metainfo.icd10gm  order by ver;

select count(distinct ig.code) "Anzahl", 'Klassifikationsebene' "Spalte" from icd_metainfo.icd10gm ig join icd_metainfo.icd10gm_history igh on  igh.code = ig.code
where ig.ebene != igh.ebene and igh.verevent like 'U'
  union 
select count(distinct ig.code) "Anzahl", 'Ort der Schlüsselnummer im Klassifikationsbaum' "Spalte" from icd_metainfo.icd10gm ig join icd_metainfo.icd10gm_history igh on igh.code = ig.code
where ig.ort != igh.ort and igh.verevent like 'U' 
  union 
select count(distinct ig.code) "Anzahl", 'Art der Vier- und Fünfsteller' "Spalte" from icd_metainfo.icd10gm ig join icd_metainfo.icd10gm_history igh on igh.code = ig.code
where ig.art != igh.art and igh.verevent like 'U'
  union 
select count(distinct ig.code) "Anzahl", 'Kapitelnummer' "Spalte" from icd_metainfo.icd10gm ig join icd_metainfo.icd10gm_history igh on igh.code = ig.code
where ig.kapnr != igh.kapnr and igh.verevent like 'U'
  union
select count(distinct ig.code) "Anzahl", 'Erster Dreisteller der Gruppe' "Spalte" from icd_metainfo.icd10gm ig join icd_metainfo.icd10gm_history igh on igh.code = ig.code
where ig.grvon != igh.grvon and igh.verevent like 'U' 
  union 
select count(distinct ig.code) "Anzahl", 'Schlüsselnummer ohne Strich, Stern und  Ausrufezeichen' "Spalte"from icd_metainfo.icd10gm ig join icd_metainfo.icd10gm_history igh on igh.code = ig.code
where ig.normcode != igh.normcode and igh.verevent like 'U' 
  union 
select count(distinct ig.code) "Anzahl", 'Schlüsselnummer ohne Punkt, Strich, Stern und Ausrufezeichen' "Spalte" from icd_metainfo.icd10gm ig join icd_metainfo.icd10gm_history igh on igh.code = ig.code
where ig.codeohnepunkt != igh.codeohnepunkt  and igh.verevent like 'U'
  union 
select count(distinct ig.code) "Anzahl", 'Klassentitel' "Spalte" from icd_metainfo.icd10gm ig join icd_metainfo.icd10gm_history igh on igh.code = ig.code
where ig.titel != igh.titel and igh.verevent like 'U'
  union 
select count(distinct ig.code) "Anzahl", 'Paragraph 295' "Spalte" from icd_metainfo.icd10gm ig join icd_metainfo.icd10gm_history igh on igh.code = ig.code
where ig.p295 != igh.p295 and igh.verevent like 'U'
  union 
select count(distinct ig.code) "Anzahl", 'Paragraph 301' "Spalte" from icd_metainfo.icd10gm ig join icd_metainfo.icd10gm_history igh on igh.code = ig.code
where ig.p301 != igh.p301 and igh.verevent like 'U' 
  union 
select count(distinct ig.code) "Anzahl", 'Bezug zur Mortalitätsliste 1' "Spalte" from icd_metainfo.icd10gm ig join icd_metainfo.icd10gm_history igh on igh.code = ig.code
where ig.mortl1code != igh.mortl1code and igh.verevent like 'U'
  union 
select count(distinct ig.code) "Anzahl", 'Bezug zur Mortalitätsliste 1 (definiert)' "Spalte" from icd_metainfo.icd10gm ig join icd_metainfo.icd10gm_history igh on igh.code = ig.code
where ig.mortl1code != igh.mortl1code and igh.verevent like 'U' and ig.mortl1code  not like 'UNDEF%' and igh.mortl1code not like 'UNDEF%'
  union 
select count(distinct ig.code) "Anzahl", 'Bezug zur Mortalitätsliste 2' "Spalte" from icd_metainfo.icd10gm ig join icd_metainfo.icd10gm_history igh on igh.code = ig.code
where ig.mortl2code != igh.mortl2code and igh.verevent like 'U'
  union 
select count(distinct ig.code) "Anzahl", 'Bezug zur Mortalitätsliste 2 (definiert)' "Spalte" from icd_metainfo.icd10gm ig join icd_metainfo.icd10gm_history igh on igh.code = ig.code
where ig.mortl2code != igh.mortl2code and igh.verevent like 'U' and ig.mortl2code not like 'UNDEF%' and  igh.mortl2code not like 'UNDEF%' 
  union 
select count(distinct ig.code) "Anzahl", 'Bezug zur Mortalitätsliste 3' "Spalte" from icd_metainfo.icd10gm ig join icd_metainfo.icd10gm_history igh on igh.code = ig.code
where ig.mortl3code != igh.mortl3code and igh.verevent like 'U'
  union 
select count(distinct ig.code) "Anzahl", 'Bezug zur Mortalitätsliste 3 (definiert)' "Spalte" from icd_metainfo.icd10gm ig join icd_metainfo.icd10gm_history igh on igh.code = ig.code
where ig.mortl3code != igh.mortl3code and igh.verevent like 'U' and ig.mortl3code not like 'UNDEF%' and igh.mortl3code not like 'UNDEF%'
  union 
select count(distinct ig.code) "Anzahl", 'Bezug zur Mortalitätsliste 4' "Spalte" from icd_metainfo.icd10gm ig join icd_metainfo.icd10gm_history igh on igh.code = ig.code
where ig.mortl4code != igh.mortl4code and igh.verevent like 'U'
  union 
select count(distinct ig.code) "Anzahl", 'Bezug zur Mortalitätsliste 4 (definiert)' "Spalte" from icd_metainfo.icd10gm ig join icd_metainfo.icd10gm_history igh on igh.code = ig.code
where ig.mortl4code != igh.mortl4code and igh.verevent like 'U' and ig.mortl4code not like 'UNDEF%' and igh.mortl4code not like 'UNDEF%'
  union
select count(distinct ig.code) "Anzahl", 'Bezug zur Morbiditätsliste' "Spalte" from icd_metainfo.icd10gm ig join icd_metainfo.icd10gm_history igh on igh.code = ig.code
where ig.morblcode != igh.morblcode and igh.verevent like 'U'
  union 
select count(distinct ig.code) "Anzahl", 'Bezug zur Morbiditätsliste (definiert)' "Spalte" from icd_metainfo.icd10gm ig join icd_metainfo.icd10gm_history igh on igh.code = ig.code
where ig.morblcode != igh.morblcode and igh.verevent like 'U' and ig.morblcode not like 'UNDEF%' and igh.morblcode not like 'UNDEF%'
  union
select count(distinct ig.code) "Anzahl", 'Geschlechtsbezug' "Spalte" from icd_metainfo.icd10gm ig join icd_metainfo.icd10gm_history igh on igh.code = ig.code
where ig.sexcode != igh.sexcode and igh.verevent like 'U' 
  union 
select count(distinct ig.code) "Anzahl", 'Art des Fehlers bei Geschlechtsbezug' "Spalte" from icd_metainfo.icd10gm ig join icd_metainfo.icd10gm_history igh on igh.code = ig.code
where ig.sexfehlertyp != igh.sexfehlertyp and igh.verevent like 'U' 
  union 
select count(distinct ig.code) "Anzahl", 'Untere Altersgrenze' "Spalte" from icd_metainfo.icd10gm ig join icd_metainfo.icd10gm_history igh on igh.code = ig.code
where ig.altunt != igh.altunt and igh.verevent like 'U' 
  union 
select count(distinct ig.code) "Anzahl", 'Untere Altersgrenze (definiert)' "Spalte" from icd_metainfo.icd10gm ig join icd_metainfo.icd10gm_history igh on igh.code = ig.code
where ig.altunt != igh.altunt and igh.verevent like 'U' and ig.altunt not like '9%' and igh.altunt not like '9%'
  union 
select count(distinct ig.code) "Anzahl", 'Obere Altersgrenze' "Spalte" from icd_metainfo.icd10gm ig join icd_metainfo.icd10gm_history igh on igh.code = ig.code
where ig.altob != igh.altob and igh.verevent like 'U'
  union 
select count(distinct ig.code) "Anzahl", 'Obere Altersgrenze (definiert)' "Spalte" from icd_metainfo.icd10gm ig join icd_metainfo.icd10gm_history igh on igh.code = ig.code
where ig.altob != igh.altob and igh.verevent like 'U' and ig.altob not like '9%' and igh.altob not like '9%'
  union 
select count(distinct ig.code) "Anzahl", 'Alter Fehlertyp' "Spalte" from icd_metainfo.icd10gm ig join icd_metainfo.icd10gm_history igh on igh.code = ig.code
where ig.altfehlertyp != igh.altfehlertyp and igh.verevent like 'U' 
  union 
select count(distinct ig.code) "Anzahl", 'Sehr seltene Krankheit in Mitteleuropa' "Spalte" from icd_metainfo.icd10gm ig join icd_metainfo.icd10gm_history igh on igh.code = ig.code
where ig.exot != igh.exot and igh.verevent like 'U' 
  union 
select count(distinct ig.code) "Anzahl", 'Belegt' "Spalte" from icd_metainfo.icd10gm ig join icd_metainfo.icd10gm_history igh on igh.code = ig.code
where ig.belegt != igh.belegt and igh.verevent like 'U' 
  union 
select count(distinct ig.code) "Anzahl", 'Arzt-Meldepflicht' "Spalte" from icd_metainfo.icd10gm ig join icd_metainfo.icd10gm_history igh on igh.code = ig.code
where ig.ifsgmeldung != igh.ifsgmeldung  and igh.verevent like 'U'
  union 
select count(distinct ig.code) "Anzahl", 'Anwendung der Laborausschlussziffer des einheitlisches Bewertungsmaßstab' "Spalte" from icd_metainfo.icd10gm ig join icd_metainfo.icd10gm_history igh on igh.code = ig.code
where ig.ifsglabor != igh.ifsglabor and igh.verevent like 'U'
order by "Anzahl" desc, "Spalte";




and igh.verevent like 'U'



select distinct ig.code, ig.sexfehlertyp , igh.sexfehlertyp from icd_metainfo.icd10gm ig join icd_metainfo.icd10gm_history igh on igh.code = ig.code
where ig.sexfehlertyp != igh.sexfehlertyp 




select ig.code, ig.ebene icd10gm, igh.ebene history from icd_metainfo.icd10gm ig join icd_metainfo.icd10gm_history igh on  igh.code = ig.code
where ig.ebene != igh.ebene ;




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






drop table icd_metainfo.icd_by_year_no_2007;
select *, altunt||altob "alter" into icd_metainfo.icd_by_year_alter from icd_metainfo.icd_by_year iby;

select distinct "alter" from icd_metainfo.icd_by_year_no_2007 where "alter" not like '999%';

select * from icd_metainfo.icd_by_year_no_2007 ig where titel like 'COV%';


select * from icd_metainfo.icd10gm_history igh where verevent = 'D'

select count(code) from icd_metainfo.icd_tmp it where ver = '2020' and code not in (select code from icd_metainfo.icd_tmp where ver = '2021');

select * from icd_metainfo.icd10gm_history igh where verevent = 'D' order by vermodif, ver ;






select count(distinct ig.code) "Anzahl", 'Bezug zur Mortalitätsliste 1' "Spalte" from icd_metainfo.icd10gm ig join icd_metainfo.icd10gm_history igh on igh.code = ig.code
where ig.mortl1code != igh.mortl1code and igh.verevent like 'U' ;
  --union 
select count(distinct ig.code) "Anzahl", 'Bezug zur Mortalitätsliste 2' "Spalte" from icd_metainfo.icd10gm ig join icd_metainfo.icd10gm_history igh on igh.code = ig.code
where ig.mortl2code != igh.mortl2code and igh.verevent like 'U'
  union 
select count(distinct ig.code) "Anzahl", 'Bezug zur Mortalitätsliste 3' "Spalte" from icd_metainfo.icd10gm ig join icd_metainfo.icd10gm_history igh on igh.code = ig.code
where ig.mortl3code != igh.mortl3code and igh.verevent like 'U';



select ig.ver new_ver, igh.ver old_ver, ig.code, ig.mortl1code, igh.mortl1code  from icd_metainfo.icd10gm ig join icd_metainfo.icd10gm_history igh on igh.code = ig.code
where ig.mortl1code != igh.mortl1code and igh.verevent like 'U' and ig.mortl1code not like 'UNDEF%' and igh.mortl1code not like 'UNDEF%';




update icd_metainfo.icd10gm 
  set dreisteller = 'Cholera' where code = 'A00.-';
  
 
select * from icd_metainfo.icd10gm_history igh  where code = 'A00.-';
 
update icd_metainfo.icd10gm ig set 
   dreisteller = icd.dreisteller,
   viersteller = icd.viersteller,
   fuenfsteller = icd.fuenfsteller
   from icd_metainfo.icd_tmp icd
   --where ig.code = icd.code 

select k.code, k.dreisteller, k.viersteller, k.fuenfsteller from icd_metainfo.icd10gm ig join icd_metainfo.kodes k 
  on k.code = ig.code;
 
select * into icd_metainfo.testing from icd_metainfo.icd10gm ig;

update icd_metainfo.icd10gm t set 
  dreisteller = it.dreisteller, 
  viersteller = it.viersteller, 
  fuenfsteller = it.fuenfsteller
from icd_metainfo.dvf it 
  where t.code = it.code;

 
 select * from icd_metainfo.dvf where code = 'A00.0';
drop table icd_metainfo.dvf;
select distinct on (code) ver, code, dreisteller, viersteller, fuenfsteller into icd_metainfo.dvf from icd_metainfo.icd_tmp  order by code, ver desc;

/*update icd_metainfo.icd10gm ig set 
   dreisteller = icd.dreisteller,
   viersteller = icd.viersteller,
   fuenfsteller = icd.fuenfsteller
   from icd_metainfo.icd_tmp icd;
 select distinct on (code) code from icd_metainfo.icd_tmp it order by code, ver desc ;
*/

select count(*) from 
(
select ig.code, igh.ver olversion, igh.mortl1code oldliste, igh.vermodif newversion, ig.mortl1code newliste 
from icd_metainfo.icd10gm ig 
join icd_metainfo.icd10gm_history igh on ig.code = igh.code 
where ig.mortl1code not like 'UNDEF%' and igh.mortl1code like 'UNDEF%' and igh.vermodif = '2008' order by ig.code
) as t;  




select count(*) from 
(
select ig.code, igh.ver olversion, igh.mortl3code oldliste, igh.vermodif newversion, ig.mortl3code newliste 
from icd_metainfo.icd10gm ig 
join icd_metainfo.icd10gm_history igh on ig.code = igh.code 
where ig.mortl3code not like 'UNDEF%' and igh.mortl3code like 'UNDEF%' and igh.vermodif = '2008' order by ig.code
) as t;  


select distinct igh.ver "Alte Version", igh.vermodif "Version der Änderung", ig.code "Code",  ig.titel "Titel", igh.titel, igh.sexcode "Alte Klassifikation", ig.sexcode "Neue Klassifikation" from icd_metainfo.icd10gm ig join icd_metainfo.icd10gm_history igh on igh.code = ig.code
where ig.sexcode != igh.sexcode and igh.verevent like 'U' and ig.titel not like '%beleg%' order by igh.ver, igh.vermodif, ig.code;


select distinct ig.kapnr, igh.ver "Alte Version", igh.vermodif "Version der Änderung", ig.code "Code",  ig.titel "Titel", igh.titel, igh.sexcode "Alte Klassifikation", ig.sexcode "Neue Klassifikation" from icd_metainfo.icd10gm ig join icd_metainfo.icd10gm_history igh on igh.code = ig.code
where ig.sexcode != igh.sexcode and igh.verevent like 'U' and ig.titel not like '%beleg%' and ig.titel ~* 'mamm|brust' order by igh.ver, igh.vermodif, ig.code;

select distinct igh.ver "Alte Version", igh.vermodif "Version der Änderung", ig.code "Code",  ig.titel "Titel", igh.sexcode "Alte Klassifikation", ig.sexcode "Neue Klassifikation" from icd_metainfo.icd10gm ig join icd_metainfo.icd10gm_history igh on igh.code = ig.code
where ig.sexcode != igh.sexcode and igh.verevent like 'U' and ig.titel not like '%beleg%' and ig.titel !~* 'mamm|brust' order by igh.ver, igh.vermodif, ig.code;


select count(distinct ig.code) "Anzahl", 'Geschlechtsbezug' "Spalte" from icd_metainfo.icd10gm ig join icd_metainfo.icd10gm_history igh on igh.code = ig.code
where ig.sexcode != igh.sexcode and igh.verevent like 'U' 




select distinct ig.code, ig.titel from icd_metainfo.icd10gm ig join icd_metainfo.icd10gm_history igh on igh.code = ig.code
where ig.sexcode != igh.sexcode and igh.verevent like 'U' and ig.titel not like '%beleg%' and ig.titel ~* 'mamm|brust';

select distinct ig.code, ig.titel from icd_metainfo.icd10gm ig join icd_metainfo.icd10gm_history igh on igh.code = ig.code
where ig.sexcode != igh.sexcode and igh.verevent like 'U' and ig.titel not like '%beleg%' and ig.titel !~* 'mamm|brust' ;





select distinct igh.ver "Alte Version", igh.vermodif "Version der Änderung", ig.code "Code",  ig.titel "Titel", igh.titel, igh.exot "Alte Klassifikation", ig.exot "Neue Klassifikation" from icd_metainfo.kodes ig join icd_metainfo.icd10gm_history igh on igh.code = ig.code
where ig.exot != igh.exot and igh.verevent like 'U' and ig.titel not like '%beleg%' order by igh.ver, igh.vermodif, ig.code;

select * into icd_metainfo.deleted from icd_metainfo.icd10gm_history igh where verevent = 'D';

select codeohnepunkt , count(code) from icd_metainfo.icd10gm ig group by codeohnepunkt having count(code) > 1 order by codeohnepunkt ;


select count(*) from icd_metainfo.icd10gm ig;

select count(distinct code), count(distinct codeohnepunkt) from icd_metainfo.icd10gm ig;

select 
  ver, ort, code, titel
from icd_metainfo.icd10gm ig 
where codeohnepunkt in (select igh.codeohnepunkt from icd_metainfo.icd10gm_history igh where igh.verevent = 'D' )
and codeohnepunkt in (select codeohnepunkt from icd_metainfo.icd10gm ig group by codeohnepunkt having count(code) > 1 )
order by ver, code;


select 
  ver, code, titel
from icd_metainfo.icd10gm ig 
where codeohnepunkt in (select igh.codeohnepunkt from icd_metainfo.icd10gm_history igh where igh.verevent = 'D' )
and codeohnepunkt not in (select codeohnepunkt from icd_metainfo.icd10gm ig group by codeohnepunkt having count(code) > 1 )
order by code, ver;

select count(code), vermodif from icd_metainfo.icd10gm_history igh where verevent = 'D' group by vermodif ;

select * from icd_metainfo.icd10gm ig where titel like '%Warteze%';

select codeohnepunkt, code from icd_metainfo.deleted where codeohnepunkt in (select codeohnepunkt from icd_metainfo.deleted d group by codeohnepunkt having count(code) > 1);


select * from icd_metainfo.icd10gm ig where code like 'U07%' and code not in (select code from icd_metainfo.icd10gm_history igh where igh.verevent = 'D');





select distinct code from icd_metainfo.icd_tmp it where ver = '2009' and code not in (select code from icd_metainfo.icd_tmp where ver = '2008')

select count(code) from icd_metainfo.icd10gm_history igh ;


select count(*) from (
select distinct on (code) * from icd_metainfo.icd10gm_history igh order by code , ver desc) as t;



