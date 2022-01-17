-- Insert new ops into ops and ops_history

-- insert new ops into table ops after insertion into the table kodes

CREATE OR REPLACE FUNCTION ops_metainfo.func_insert_new_ops()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$
  begin 
    insert into ops_metainfo.ops 
       SELECT 
         n.*
       FROM new_table n 
       left join ops_metainfo.ops o
         on o.kode = n.kode
       where o.kode isnull;
    return null;
  end;
 $function$
;

create trigger tr_insert_newops_into_ops after
insert
    on
    ops_metainfo.kodes referencing new table as new_table 
    for each statement execute function ops_metainfo.func_insert_new_ops();
   
-- insert new ops into table ops_history after insertion into the table kodes
CREATE OR REPLACE FUNCTION ops_metainfo.func_insert_new_ops_to_history()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$
  begin 
    INSERT INTO ops_metainfo.ops_history 
	  SELECT 
	    n.*,
	    null oldver, 
	    'I' verevent
	  FROM new_table n 
	  left join ops_metainfo.ops_history oh
	    on oh.kode = n.kode
	  where oh.kode isnull;
    return null;
  end;
 $function$
;

create trigger tr_insert_newops_into_history after
insert
    on
    ops_metainfo.ops referencing new table as new_table 
    for each statement execute function ops_metainfo.func_insert_new_ops_to_history();
