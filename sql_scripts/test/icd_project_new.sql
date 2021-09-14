ALTER TABLE icd_metainfo.kodes DISABLE TRIGGER ALL;
--ALTER TABLE icd_metainfo.icd10gm_history enable TRIGGER ALL;
--ALTER TABLE icd_metainfo.icd10gm enable TRIGGER ALL;
ALTER TABLE icd_metainfo.kodes ENABLE TRIGGER tr_icd10gm_insert_from_bfarm;


TRUNCATE icd_metainfo.icd10gm CASCADE;
truncate icd_metainfo.icd10gm_history cascade;

TRUNCATE icd_metainfo.kodes CASCADE;
COPY icd_metainfo.kodes FROM '/home/abel/cdw/ICD/icd_versions/codes/icd10gm2007.csv' WITH DELIMITER E';' CSV QUOTE E'\b';


select * from icd_metainfo.icd10gm_history igh where verevent = 'U'; --F45.4, 2009, D
select * from icd_metainfo.icd10gm_history where isdeleted order by code;
select * from icd_metainfo.icd10gm_history where code in (

select * from icd_metainfo.icd10gm_history igh where verevent = 'D' order by code, ver;

select count(distinct code) q, ver from icd_metainfo.icd10gm_history igh where verevent = 'D' group by ver order by q;

select distinct on (code) * into icd_metainfo.icd_del from icd_metainfo.icd10gm_history igh where verevent = 'D' order by code, ver;
drop table icd_metainfo.icd_del;

select ver, code, oldver from icd_metainfo.icd_del order by oldver desc;

select * from icd_metainfo.icd10gm_history where code in (
select code from icd_metainfo.kodes k where code in (select distinct code from icd_metainfo.icd10gm_history igh where igh.verevent = 'D')) order by code, ver;

select count(code) q , ver from icd_metainfo.icd_del group by ver;

select count(distinct code) q, ver from icd_metainfo.icd10gm_history igh where verevent = 'D' group by ver order by q;

select * from icd_metainfo.icd10gm_history igh order by  code;

select count(ver) q, code from icd_metainfo.icd10gm_history igh group by code having count(ver) > 2 order by q desc;

select * from icd_metainfo.icd10gm_history igh where code like 'K62.8';

--select count(distinct code) q, oldver from icd_metainfo.icd10gm_history igh where verevent = 'D' group by oldver order by q;


select * from icd_metainfo.icd10gm_history igh where verevent = 'U' and ver = '2012';

select * from icd_metainfo.icd10gm ig order by ver desc, code;

select * from icd_metainfo.icd10gm ig where ver != '2021';

select count(code), oldver from icd_metainfo.icd10gm_history igh group by oldver;

select code from icd_metainfo.icd10gm_history igh where verevent = 'D' group by code having count(ver) > 2 order by code;

select * from icd_metainfo.icd10gm_history igh where code = 'A90';

select * from icd_metainfo.icd10gm_history igh where verevent = 'D'

select * from icd_metainfo.kodes k where code in (select code from icd_metainfo.icd10gm_history igh where verevent = 'D');

select ver, code, verevent, oldver from icd_metainfo.icd10gm_history where code in (select code from icd_metainfo.icd10gm_history igh where verevent = 'D') and code in (select code from icd_metainfo.kodes k);

select count(*) from icd_metainfo.icd10gm;
select count(distinct code) quanty, vermodif from icd_metainfo.icd10gm_history igh where verevent = 'D'  group by vermodif order by quanty;

select count(distinct code) quanty, vermodif from icd_metainfo.icd10gm_history igh where verevent = 'U'  group by vermodif order by quanty;

select * from icd_metainfo.icd10gm_history igh where code like 'A49.0%';

select distinct igh.kapnr, ver, code, titel, vermodif, verevent from icd_metainfo.icd10gm_history igh where code in (select code from icd_metainfo.icd10gm_history where verevent = 'RU') order by code;

select igh.kapnr, igh.ver, igh.vermodif, k.code, k.titel  from icd_metainfo.kodes k 
join icd_metainfo.icd10gm_history igh 
  on k.code = igh.code 
where igh.verevent = 'RU';
select * from icd_metainfo.icd10gm_history igh where verevent = 'I';
select 
 code, verevent 
from icd_metainfo.icd10gm_history igh 
group by code, verevent 
having count(*) > 4;
  
  
  
  where exists (select code from icd_metainfo.icd10gm_history where verevent = 'RU')


select count(code) from icd_metainfo.icd10gm_history igh where verevent = 'D'

select count(code) from icd_metainfo.icd10gm ig;

select count(distinct code), verevent from icd_metainfo.icd10gm_history igh group by verevent
  union 
select count(code), 'NO U_D' from icd_metainfo.icd10gm where code not in (select code from icd_metainfo.icd10gm_history where verevent in ('D', 'U'));
 
select distinct code from icd_metainfo.icd10gm_history igh where verevent = 'D' order by code


select count(code), vermodif 
from icd_metainfo.icd10gm_history 
where verevent = 'D' 
and  code not in (select distinct code from icd_metainfo.icd10gm_history where verevent = 'U')
group by vermodif;

ALTER TABLE icd_metainfo.kodes ENABLE TRIGGER ALL;
ALTER TABLE icd_metainfo.icd10gm_history ENABLE TRIGGER ALL;

TRUNCATE icd_metainfo.kodes CASCADE;
--COPY $2 FROM '$1$file' WITH DELIMITER E';' CSV QUOTE E'\b';
-- Enable trigger to insert and management the new data
--/usr/local/pgtde/bin/psql -p 5433 -w -d $db -U db_user -c "ALTER TABLE $2 ENABLE TRIGGER $3;"

select * from icd_metainfo.icd10gm_history igh where verevent like 'I' and ver = '2008';


select distinct code 
from icd_metainfo.icd10gm_history 
where code in (select distinct code from icd_metainfo.icd10gm_history where verevent = 'D')
and  code in (select distinct code from icd_metainfo.icd10gm_history where verevent = 'U')
order by code 
--group by vermodif;




select * from icd_metainfo.kodes k;

select ig.code, ig.ver
from icd_metainfo.icd10gm ig
left join  icd_metainfo.kodes k 
  on ig.code = k.code 
where k.code isnull;


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
select count(distinct code), 're' modi from icd_metainfo.icd10gm_history igh where verevent = 'RU'
  
select code, kapnr, ver from icd_metainfo.icd10gm_history where ver not like '2007' and verevent = 'I' and kapnr in (
select kapnr from icd_metainfo.icd10gm_history igh where ver not like '2007' and verevent = 'I' group by kapnr, ver having count(code) > 20
) order by code; 
  

select * from icd_metainfo.icd10gm_history igh where verevent = 'D' and ver = '2013';


select count(code), vermodif from icd_metainfo.icd10gm_history igh where verevent = 'D' group by vermodif; 


select 
code, ver, titel
from icd_metainfo.icd10gm ig 
where codeohnepunkt in (select igh.codeohnepunkt from icd_metainfo.icd10gm_history igh where igh.verevent = 'D' )
and codeohnepunkt in (select codeohnepunkt from icd_metainfo.icd10gm ig group by codeohnepunkt having count(code) > 1 )
order by code;


select 
  distinct code
from icd_metainfo.icd10gm ig 
where codeohnepunkt in (select igh.codeohnepunkt from icd_metainfo.icd10gm_history igh where igh.verevent = 'D' )
and codeohnepunkt not in (select codeohnepunkt from icd_metainfo.icd10gm ig group by codeohnepunkt having count(code) > 1 )
order by code;



select 
  count(code)
from icd_metainfo.kodes k 
where codeohnepunkt in (select igh.codeohnepunkt from icd_metainfo.icd10gm_history igh where igh.verevent = 'D' );



and codeohnepunkt in (select codeohnepunkt from icd_metainfo.icd10gm ig group by codeohnepunkt having count(code) > 1 )
order by code;

select count(distinct code), 'not used' used from icd_metainfo.icd10gm_history igh where verevent = 'D' and codeohnepunkt not in (select codeohnepunkt from icd_metainfo.kodes k)
  union
select count(distinct code), 'used' from icd_metainfo.icd10gm_history igh where verevent = 'D' and codeohnepunkt in (select codeohnepunkt from icd_metainfo.kodes k)
  


select code, verevent, vermodif from icd_metainfo.icd10gm_history igh where verevent = 'D' and codeohnepunkt in (select codeohnepunkt from icd_metainfo.kodes k) order by code;


select code, titel from icd_metainfo.kodes k where code in (select code from icd_metainfo.icd10gm_history igh where igh.verevent = 'D') order by code;


COPY icd_metainfo.kapitel from '/home/abel/cdw/ICD/icd_versions/icd10gm2021syst-meta-20201111/Klassifikationsdateien/icd10gm2021syst_kapitel.txt' WITH DELIMITER E';' CSV QUOTE E'\b';


select igh.*, k.kapti from icd_metainfo.icd10gm_history igh 
join icd_metainfo.kapitel k 
on k.kapnr = igh.kapnr where verevent = 'D' and vermodif = '2013' and igh.kapnr in(
  select kapnr from icd_metainfo.icd10gm_history igh where verevent = 'D' and vermodif = '2013' group by kapnr having count(code) >  2
);
  


--select count(*) from ( 
SELECT 
		    	  distinct on (igh.code)
		    	  n.*,
				  igh.ver,
				  'U' verevent
				FROM icd_metainfo.icd10gm n
				join icd_metainfo.icd10gm_history igh
				  on n.code = igh.code
				order by igh.code, igh.ver desc
			--) as t;

select distinct
                  (select distinct ver from icd_metainfo.kodes k limit 1) ver,
                  ig.code,
                  ig.ebene,
                  ig.ver, 
                  'D' verevent 
                from icd_metainfo.icd10gm ig
                join icd_metainfo.icd10gm_history igh
                  on ig.code = igh.code
                left join icd_metainfo.kodes n
                  on n.code = ig.code 
                where n.code isnull
                and (igh.verevent = 'I' or igh.verevent = 'U')
                
select * from icd_metainfo.icd10gm_history igh where verevent = 'D';            
                