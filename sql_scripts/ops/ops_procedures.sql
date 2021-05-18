-- insert new OPS into ops from metainfo tables
create or replace procedure metadata_repository.newops(ops_version int)
  language plpgsql
  as $$
  begin 
	  insert into metadata_repository.ops
        select 
          t.ort,
          t.kode,
          t.titel,
          "version",
          "release", 
          false, 
          'bfarm' 
        from ops_metainfo.kodes t
        left join metadata_repository.ops i
          on i.code = t.kode 
        join metadata_repository.release_version rv 
          on "version" = ops_version and ini = 'ops'
        where i.code isnull;
  end; $$;
  
    
-- insert modified icds into icdHistory
-- update icds in icd 
create or replace procedure metadata_repository.updops(ops_version int)
  language plpgsql
  as $$
  begin
	-- insert into opshistory
 insert into metadata_repository.opshistory (
      place,
      code,  
      titel, 
      isactive, 
      yearversion, 
      release_date, 
      release_update
    )
    (
 select 
        i.place,
        i.code,
        i.titel,
        true,
        i.yearversion,
        i.release_date,
        "release" release_update
      from ops_metainfo.kodes t
      join metadata_repository.ops i
        on i.code = t.kode
      join metadata_repository.release_version rv 
        on rv."version" = ops_version and rv.ini = 'ops'
      where i.titel != t.titel
      or i.place != t.ort
  );
   
   --update ops
    update metadata_repository.ops 
      set     
        place = sq.ort, 
        titel = sq.titel, 
        yearversion = sq."version", 
        release_date = sq."release" 
      from 
      (
        select 
          t.ort,
          t.kode, 
          t.titel, 
          "version", 
          "release"
        from ops_metainfo.kodes t
        join metadata_repository.ops i
          on i.code = t.kode
        join metadata_repository.release_version rv 
          on rv."version" = ops_version and rv.ini = 'ops'
        where i.titel != t.titel
        or i.place != t.ort
      ) as sq 
      where ops.code = sq.kode ;
  end; $$;
  
 
-- insert old ops into opshistory
 create or replace procedure metadata_repository.oldops(ops_version int)
  language plpgsql
  as $$
  begin 
	  insert into metadata_repository.opshistory (
        place,
	    code,  
        titel,  
        isactive, 
        yearversion, 
        release_date, 
        release_update
      )
      (
        select 
          i.place,
          i.code,
          i.titel,
          false isActive,
          i.yearversion,
          i.release_date,
          "release"
        from ops_metainfo.kodes t
        right join metadata_repository.ops i
          on i.code = t.kode
        join metadata_repository.release_version rv
          on rv."version" = ops_version and rv.ini = 'ops'
        left join metadata_repository.opshistory h
          on h.code = i.code 
        where t.kode isnull
        and h.code isnull 
    );
  end; $$; 
