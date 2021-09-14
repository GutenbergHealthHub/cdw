-- old version delete
select count(distinct code) q, oldver from icd_metainfo.icd10gm_history igh where verevent = 'D' group by oldver order by q;

-- new version delete old icd
select count(distinct code) q, ver from icd_metainfo.icd10gm_history igh where verevent = 'D' group by ver order by q;

-- deleted and inserted
select * from icd_metainfo.icd10gm_history where code in (
select code from icd_metainfo.kodes k where code in (select distinct code from icd_metainfo.icd10gm_history igh where igh.verevent = 'D')) order by code, ver;


-- icd with more modifications
select count(distinct ver) q, code from icd_metainfo.icd10gm_history igh group by code having count(ver) > 3 order by q desc;


select count(distinct code), 'only_mod' modi from icd_metainfo.icd10gm_history igh where verevent = 'U' and code not in (select code from icd_metainfo.icd10gm_history where verevent = 'D') 
  union 
select count(distinct code), 'only_del' modi from icd_metainfo.icd10gm_history igh where verevent = 'D' and code not in (select code from icd_metainfo.icd10gm_history where verevent = 'U')
  union 
select count(distinct code), 'del' modi from icd_metainfo.icd10gm_history igh where verevent = 'D'
  union 
select count(distinct code), 'mod' modi from icd_metainfo.icd10gm_history igh where verevent = 'U'
  union 
select count(distinct code), 'ins' modi from icd_metainfo.icd10gm_history igh where verevent = 'I'
  union 
select count(distinct code), 'ins_no_del_no_mod' modi from icd_metainfo.icd10gm_history igh where verevent = 'I' 
and code not in (select code from icd_metainfo.icd10gm_history where verevent = 'U')
and code not in (select code from icd_metainfo.icd10gm_history where verevent = 'D')
  union 
select count(distinct code), 'del_mod' modi from icd_metainfo.icd10gm_history igh 
where code in (select code from icd_metainfo.icd10gm_history where verevent = 'D')
and code in (select code from icd_metainfo.icd10gm_history where verevent = 'U')
  union 
select count(distinct code), 're' modi from icd_metainfo.icd10gm_history igh where verevent = 'DI'


-- kapitel with more modifications
select code, kapnr, ver from icd_metainfo.icd10gm_history where ver not like '2007' and verevent = 'I' and kapnr in (
select kapnr from icd_metainfo.icd10gm_history igh where ver not like '2007' and verevent = 'I' group by kapnr, ver having count(code) > 20
) order by code; 
  


-- deleted codes without dot in current version
select 
code, ver, titel
from icd_metainfo.icd10gm ig 
where codeohnepunkt in (select igh.codeohnepunkt from icd_metainfo.icd10gm_history igh where igh.verevent = 'D' )
and codeohnepunkt in (select codeohnepunkt from icd_metainfo.icd10gm ig group by codeohnepunkt having count(code) > 1 )
order by code;

-- deleted codes without dot not in current version
select 
  distinct code
from icd_metainfo.icd10gm ig 
where codeohnepunkt in (select igh.codeohnepunkt from icd_metainfo.icd10gm_history igh where igh.verevent = 'D' )
and codeohnepunkt not in (select codeohnepunkt from icd_metainfo.icd10gm ig group by codeohnepunkt having count(code) > 1 )
order by code;


-- reuse code without dot
select 
  count(code)
from icd_metainfo.kodes k 
where codeohnepunkt in (select igh.codeohnepunkt from icd_metainfo.icd10gm_history igh where igh.verevent = 'D' );


-- used and not used code without dot 
select count(distinct code), 'not used' used from icd_metainfo.icd10gm_history igh where verevent = 'D' and codeohnepunkt not in (select codeohnepunkt from icd_metainfo.kodes k)
  union
select count(distinct code), 'used' from icd_metainfo.icd10gm_history igh where verevent = 'D' and codeohnepunkt in (select codeohnepunkt from icd_metainfo.kodes k)
  


  
-- Modifications
select 
  count(distinct i.code) "Anzahl", 
  'Klassifikationsebene' "Spalte" 
  from (select code, ebene from icd_metainfo.icd10gm_history where verevent = 'I') i 
  join (select code, ebene from icd_metainfo.icd10gm_history where verevent = 'U') u
    on  i.code = u.code
where i.ebene != u.ebene 
  union
select 
  count(distinct i.code) "Anzahl", 
  'Ort der Schlüsselnummer im Klassifikationsbaum' "Spalte" 
  from (select code, ort from icd_metainfo.icd10gm_history where verevent = 'I') i 
  join (select code, ort from icd_metainfo.icd10gm_history where verevent = 'U') u
    on  i.code = u.code
where i.ort != u.ort 
  union
/*select 
  count(distinct i.code) "Anzahl", 
  'Art der Vier- und Fünfsteller' "Spalte" 
  from (select code, art from icd_metainfo.icd10gm_history where verevent = 'I') i 
  join (select code, art from icd_metainfo.icd10gm_history where verevent = 'U') u
    on  i.code = u.code
where i.art != u.art 
  union*/
select 
  count(distinct i.code) "Anzahl", 
  'Bezug zur Mortalitätsliste 1' "Spalte" 
  from (select code, mortl1code from icd_metainfo.icd10gm_history where verevent = 'I') i 
  join (select code, mortl1code from icd_metainfo.icd10gm_history where verevent = 'U') u
    on  i.code = u.code
where i.mortl1code != u.mortl1code
  union 
select 
  count(distinct i.code) "Anzahl", 
  'Bezug zur Mortalitätsliste 1 (definiert)' "Spalte" 
  from (select code, mortl1code from icd_metainfo.icd10gm_history where verevent = 'I') i 
  join (select code, mortl1code from icd_metainfo.icd10gm_history where verevent = 'U') u
    on  i.code = u.code
where i.mortl1code != u.mortl1code
and i.mortl1code not like 'UNDEF%' and u.mortl1code not like 'UNDEF%'
  union
select 
  count(distinct i.code) "Anzahl", 
  'Bezug zur Mortalitätsliste 2' "Spalte" 
  from (select code, mortl2code from icd_metainfo.icd10gm_history where verevent = 'I') i 
  join (select code, mortl2code from icd_metainfo.icd10gm_history where verevent = 'U') u
    on  i.code = u.code
where i.mortl2code != u.mortl2code 
  union 
select 
  count(distinct i.code) "Anzahl", 
  'Bezug zur Mortalitätsliste 2 (definiert)' "Spalte" 
  from (select code, mortl2code from icd_metainfo.icd10gm_history where verevent = 'I') i 
  join (select code, mortl2code from icd_metainfo.icd10gm_history where verevent = 'U') u
    on  i.code = u.code
where i.mortl2code != u.mortl2code
and i.mortl2code not like 'UNDEF%' and u.mortl2code not like 'UNDEF%'
  union
select 
  count(distinct i.code) "Anzahl", 
  'Bezug zur Mortalitätsliste 3' "Spalte" 
  from (select code, mortl3code from icd_metainfo.icd10gm_history where verevent = 'I') i 
  join (select code, mortl3code from icd_metainfo.icd10gm_history where verevent = 'U') u
    on  i.code = u.code
where i.mortl3code != u.mortl3code 
  union 
select 
  count(distinct i.code) "Anzahl", 
  'Bezug zur Mortalitätsliste 3 (definiert)' "Spalte" 
  from (select code, mortl3code from icd_metainfo.icd10gm_history where verevent = 'I') i 
  join (select code, mortl3code from icd_metainfo.icd10gm_history where verevent = 'U') u
    on  i.code = u.code
where i.mortl3code != u.mortl3code
and i.mortl3code not like 'UNDEF%' and u.mortl3code not like 'UNDEF%'
  union
select 
  count(distinct i.code) "Anzahl", 
  'Bezug zur Mortalitätsliste 4' "Spalte" 
  from (select code, mortl4code from icd_metainfo.icd10gm_history where verevent = 'I') i 
  join (select code, mortl4code from icd_metainfo.icd10gm_history where verevent = 'U') u
    on  i.code = u.code
where i.mortl4code != u.mortl4code 
  union 
select 
  count(distinct i.code) "Anzahl", 
  'Bezug zur Mortalitätsliste 4 (definiert)' "Spalte" 
  from (select code, mortl4code from icd_metainfo.icd10gm_history where verevent = 'I') i 
  join (select code, mortl4code from icd_metainfo.icd10gm_history where verevent = 'U') u
    on  i.code = u.code
where i.mortl4code != u.mortl4code
and i.mortl4code not like 'UNDEF%' and u.mortl4code not like 'UNDEF%'
  union
select 
  count(distinct i.code) "Anzahl", 
  'Kapitelnummer' "Spalte" 
  from (select code, kapnr from icd_metainfo.icd10gm_history where verevent = 'I') i 
  join (select code, kapnr from icd_metainfo.icd10gm_history where verevent = 'U') u
    on  i.code = u.code
where i.kapnr != u.kapnr 
  union 
select 
  count(distinct i.code) "Anzahl", 
  'Erster Dreisteller der Gruppe' "Spalte" 
  from (select code, grvon from icd_metainfo.icd10gm_history where verevent = 'I') i 
  join (select code, grvon from icd_metainfo.icd10gm_history where verevent = 'U') u
    on  i.code = u.code
where i.grvon != u.grvon
  union 
select 
  count(distinct i.code) "Anzahl", 
  'Schlüsselnummer ohne Strich, Stern und  Ausrufezeichen' "Spalte" 
  from (select code, normcode from icd_metainfo.icd10gm_history where verevent = 'I') i 
  join (select code, normcode from icd_metainfo.icd10gm_history where verevent = 'U') u
    on  i.code = u.code
where i.normcode != u.normcode
  union 
select 
  count(distinct i.code) "Anzahl", 
  'Schlüsselnummer ohne Punkt, Strich, Stern und Ausrufezeichen' "Spalte" 
  from (select code, codeohnepunkt from icd_metainfo.icd10gm_history where verevent = 'I') i 
  join (select code, codeohnepunkt from icd_metainfo.icd10gm_history where verevent = 'U') u
    on  i.code = u.code
where i.codeohnepunkt != u.codeohnepunkt
  union 
select 
  count(distinct i.code) "Anzahl", 
  'Klassentitel' "Spalte" 
  from (select code, titel from icd_metainfo.icd10gm_history where verevent = 'I') i 
  join (select code, titel from icd_metainfo.icd10gm_history where verevent = 'U') u
    on  i.code = u.code
where i.titel != u.titel
  union 
select 
  count(distinct i.code) "Anzahl", 
  'Paragraph 295' "Spalte" 
  from (select code, p295 from icd_metainfo.icd10gm_history where verevent = 'I') i 
  join (select code, p295 from icd_metainfo.icd10gm_history where verevent = 'U') u
    on  i.code = u.code
where i.p295 != u.p295
  union 
select 
  count(distinct i.code) "Anzahl", 
  'Paragraph 301' "Spalte" 
  from (select code, p301 from icd_metainfo.icd10gm_history where verevent = 'I') i 
  join (select code, p301 from icd_metainfo.icd10gm_history where verevent = 'U') u
    on  i.code = u.code
where i.p301 != u.p301
  union 
select 
  count(distinct i.code) "Anzahl", 
  'Bezug zur Morbiditätsliste' "Spalte" 
  from (select code, morblcode from icd_metainfo.icd10gm_history where verevent = 'I') i 
  join (select code, morblcode from icd_metainfo.icd10gm_history where verevent = 'U') u
    on  i.code = u.code
where i.morblcode != u.morblcode
  union 
select 
  count(distinct i.code) "Anzahl", 
  'Bezug zur Morbiditätsliste (definiert)' "Spalte" 
  from (select code, morblcode from icd_metainfo.icd10gm_history where verevent = 'I') i 
  join (select code, morblcode from icd_metainfo.icd10gm_history where verevent = 'U') u
    on  i.code = u.code
where i.morblcode != u.morblcode
and i.morblcode not like 'UNDEF%' and u.morblcode not like 'UNDEF%'
  union 
select 
  count(distinct i.code) "Anzahl", 
  'Geschlechtsbezug' "Spalte" 
  from (select code, sexcode from icd_metainfo.icd10gm_history where verevent = 'I') i 
  join (select code, sexcode from icd_metainfo.icd10gm_history where verevent = 'U') u
    on  i.code = u.code
where i.sexcode != u.sexcode
  union 
select 
  count(distinct i.code) "Anzahl", 
  'Untere Altersgrenze' "Spalte" 
  from (select code, altunt from icd_metainfo.icd10gm_history where verevent = 'I') i 
  join (select code, altunt from icd_metainfo.icd10gm_history where verevent = 'U') u
    on  i.code = u.code
where i.altunt != u.altunt
  union 
select 
  count(distinct i.code) "Anzahl", 
  'Untere Altersgrenze (definiert)' "Spalte" 
  from (select code, altunt from icd_metainfo.icd10gm_history where verevent = 'I') i 
  join (select code, altunt from icd_metainfo.icd10gm_history where verevent = 'U') u
    on  i.code = u.code
where i.altunt != u.altunt and i.altunt not like '9%' and u.altunt not like '9%'
union 
select 
  count(distinct i.code) "Anzahl", 
  'Obere Altersgrenze' "Spalte" 
  from (select code, altob from icd_metainfo.icd10gm_history where verevent = 'I') i 
  join (select code, altob from icd_metainfo.icd10gm_history where verevent = 'U') u
    on  i.code = u.code
where i.altob != u.altob
  union 
select 
  count(distinct i.code) "Anzahl", 
  'Obere Altersgrenze (definiert)' "Spalte" 
  from (select code, altob from icd_metainfo.icd10gm_history where verevent = 'I') i 
  join (select code, altob from icd_metainfo.icd10gm_history where verevent = 'U') u
    on  i.code = u.code
where i.altob != u.altob 
and i.altob not like '9%' and u.altob not like '9%'
  union 
select 
  count(distinct i.code) "Anzahl", 
  'Sehr seltene Krankheit in Mitteleuropa' "Spalte" 
  from (select code, exot from icd_metainfo.icd10gm_history where verevent = 'I') i 
  join (select code, exot from icd_metainfo.icd10gm_history where verevent = 'U') u
    on  i.code = u.code
where i.exot != u.exot
  union 
select 
  count(distinct i.code) "Anzahl", 
  'Belegte Nummer' "Spalte" 
  from (select code, belegt from icd_metainfo.icd10gm_history where verevent = 'I') i 
  join (select code, belegt from icd_metainfo.icd10gm_history where verevent = 'U') u
    on  i.code = u.code
where i.belegt != u.belegt
  union 
select 
  count(distinct i.code) "Anzahl", 
  'Arzt-Meldepflicht' "Spalte" 
  from (select code, ifsgmeldung from icd_metainfo.icd10gm_history where verevent = 'I') i 
  join (select code, ifsgmeldung from icd_metainfo.icd10gm_history where verevent = 'U') u
    on  i.code = u.code
where i.ifsgmeldung != u.ifsgmeldung
  union 
select 
  count(distinct i.code) "Anzahl", 
  'Anwendung der Laborausschlussziffer des einheitlisches Bewertungsmaßstab' "Spalte" 
  from (select code, ifsglabor from icd_metainfo.icd10gm_history where verevent = 'I') i 
  join (select code, ifsglabor from icd_metainfo.icd10gm_history where verevent = 'U') u
    on  i.code = u.code
where i.ifsglabor != u.ifsglabor
order by "Spalte";