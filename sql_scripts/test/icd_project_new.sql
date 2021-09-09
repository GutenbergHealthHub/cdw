ALTER TABLE icd_metainfo.kodes DISABLE TRIGGER ALL;
ALTER TABLE icd_metainfo.icd10gm_history DISABLE TRIGGER ALL;
ALTER TABLE icd_metainfo.kodes ENABLE TRIGGER tr_icd10gm_insert_from_bfarm;


TRUNCATE icd_metainfo.icd10gm CASCADE;
truncate icd_metainfo.icd10gm_history cascade;

COPY icd_metainfo.kodes FROM '/home/abel/cdw/ICD/icd_versions/codes/icd10gm2021.csv' WITH DELIMITER E';' CSV QUOTE E'\b';
TRUNCATE icd_metainfo.kodes CASCADE;

select count(distinct code) quanty, vermodif from icd_metainfo.icd10gm_history igh where verevent = 'D'  group by vermodif order by quanty;

select distinct ver, code quanty, vermodif from icd_metainfo.icd10gm_history igh where verevent = 'RU'  order by quanty;


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



  
