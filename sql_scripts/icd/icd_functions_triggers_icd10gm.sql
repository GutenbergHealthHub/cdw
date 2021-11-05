-- insert new icd10gm into icd_metainfo.icd10gm_history from icd_metainfo.icd10gm
create or replace function icd_metainfo.func_insert_new_icd10gm_to_history()
returns trigger 
language plpgsql
as $$
  begin 
    INSERT INTO icd_metainfo.icd10gm_history 
	  SELECT 
	    n.*,
	    null oldver, 
	    'I' verevent
	  FROM new_table n 
	  left join icd_metainfo.icd10gm_history icd
	    on icd.code = n.code
	  where icd.code isnull;
    return null;
  end;
 $$;

-- management the insert of new icd10gm into icd_metainfo.icd10gm_history 
create trigger tr_insert_newicd10gm_into_history
after insert on icd_metainfo.icd10gm 
referencing new table as new_table 
for each statement execute function icd_metainfo.func_insert_new_icd10gm_to_history();


-- insert updated icd10gm into icd_metainfo.icd10gm_history from icd_metainfo.icd10gm
create or replace function icd_metainfo.func_insert_updated_icd10gm_into_history()
returns trigger 
language plpgsql
as $$
  begin 
    INSERT INTO icd_metainfo.icd10gm_history 
	  select
	    distinct on (icd.code)
	    n.*,
	    icd.ver, 
	    'U' verevent
	  FROM new_table n 
	  join (select code, ver from icd_metainfo.icd10gm_history where verevent <> 'D') icd
	    on icd.code = n.code
	  left join (select code from icd_metainfo.icd10gm_history where verevent = 'D') d
	    on d.code = n.code
	  where icd.code isnull
	  order by icd.code, icd.ver desc
	 ;
	
	INSERT INTO icd_metainfo.icd10gm_history 
	  select
	    distinct on (icd.code)
	    n.*,
	    icd.ver, 
	    'U' verevent
	  FROM new_table n 
	  join (select code, ver from icd_metainfo.icd10gm_history where verevent = 'DI') icd
	    on icd.code = n.code
	  order by icd.code, icd.ver desc
	 ;

	DELETE FROM icd_metainfo.icd10gm_history 
	  WHERE ver = oldver;
    return null;
  end;
 $$;

-- management the update of icd10gm in icd_metainfo.icd10gm 
create trigger tr_updated_icd10gm_to_history
after update on icd_metainfo.icd10gm 
referencing new table as new_table 
for each statement execute function icd_metainfo.func_insert_updated_icd10gm_into_history();
