-- insert new icds into icd from icdTmp
create or replace procedure metadata_repository.newicd(icd_version int)
  language plpgsql
  as $$
  begin 
	  insert into metadata_repository.icd
        select 
          t.code,
          t.normcode ,
          t.codeohnepunkt,
          t.titel,
          t.p295,
          t.p301,
          "version",
          "release", 
          false, 
          'bfarm' 
        from icd_metainfo.kodes t
        left join metadata_repository.icd i
          on i.code = t.code 
        join metadata_repository.release_version rv 
          on "version" = icd_version
        where i.code isnull;
  end; $$;
  
-- insert modified icds into icdHistory
-- update icds in icd 
create or replace procedure metadata_repository.updicd(icd_version int)
  language plpgsql
  as $$
  begin
	-- insert into icdhistory
    insert into metadata_repository.icdhistory (
      code, 
      codenormal, 
      codenodot, 
      titel, 
      p295, 
      p301, 
      isactive, 
      yearversion, 
      release_date, 
      release_update
    )
    (
      select 
        i.code,
        i.codenormal,
        i.codenodot,
        i.titel,
        i.p295,
        i.p301,
        true,
        i.yearversion,
        i.release_date,
        "release" release_update
      from icd_metainfo.kodes t
      join metadata_repository.icd i
        on i.code = t.code
      join metadata_repository.release_version rv 
        on rv."version" = icd_version and rv.ini = 'icd'
      where i.titel != t.titel
      or i.codenodot != t.codeohnepunkt 
      or i.codenormal != t.normcode 
      or i.p295 != t.p295 
      or i.p301 != t.p301
    );
   
   --update icd
    update metadata_repository.icd 
      set     
        codenormal = sq.normcode, 
        codenodot = sq.codeohnepunkt, 
        titel = sq.titel, 
        p295 = sq.p295, 
        p301 = sq.p301 , 
        yearversion = sq."version", 
        release_date = sq."release" 
      from 
      (
        select 
          t.code,
          t.normcode, 
          t.codeohnepunkt, 
          t.titel, 
          t.p295, 
          t.p301, 
          "version", 
          "release"
        from icd_metainfo.kodes t
        join metadata_repository.icd i
          on i.code = t.code
        join metadata_repository.release_version rv 
          on rv."version" = icd_version and rv.ini = 'icd'
        where i.titel != t.titel
        or i.codenodot != t.codeohnepunkt 
        or i.codenormal != t.normcode 
        or i.p295 != t.p295 
        or i.p301 != t.p301
      ) as sq 
      where icd.code = sq.code ;
  end; $$;
  
 
-- insert old icd into icdhistory
 create or replace procedure metadata_repository.oldicd(icd_version int)
  language plpgsql
  as $$
  begin 
	  insert into metadata_repository.icdhistory (
        code, 
        codenormal, 
        codenodot, 
        titel, 
        p295, 
        p301, 
        isactive, 
        yearversion, 
        release_date, 
        release_update
      )
      (
        select 
          i.code,
          i.codenormal,
          i.codenodot,
          i.titel,
          i.p295,
          i.p301,
          false isActive,
          i.yearversion,
          i.release_date,
          "release"
        from icd_metainfo.kodes t
        right join metadata_repository.icd i
          on i.code = t.code
        join metadata_repository.release_version rv
          on rv."version" = icd_version
        left join metadata_repository.icdhistory h
          on h.code = i.code 
        where t.code isnull
        and h.code isnull 
    );
  end; $$;