-- insert new icd10gm into icd_metainfo.icd10gm from kodes
create or replace function icd_metainfo.func_insert_new_icd10gm()
returns trigger 
language plpgsql
as $$
  begin 
    insert into icd_metainfo.icd10gm
       SELECT 
         n.*
       FROM new_table n 
       left join icd_metainfo.icd10gm icd
         on icd.code = n.code
       where icd.code isnull;
    return null;
  end;
 $$;

-- management the insert of new icd10gm into icd_metainfo.icd10gm 
create trigger tr_insert_newicd10gm_into_icd10gm
after insert on icd_metainfo.kodes 
referencing new table as new_table 
for each statement execute function icd_metainfo.func_insert_new_icd10gm();


-- update information in icd_metainfo.icd10gm from table icd_metainfo.kodes 
create or replace function icd_metainfo.func_update_icd10gm()
returns trigger 
language plpgsql
as $$
  begin 
     update icd_metainfo.icd10gm ig
       set  
         ver = n.ver,
         ebene = n.ebene,
         ort = n.ort,
         art = n.art,
         kapnr = n.kapnr,
         grvon = n.grvon,
         normcode = n.normcode,
         codeohnepunkt = n.codeohnepunkt,
         titel = n.titel,
         dreisteller = n.dreisteller,
         viersteller = n.viersteller,
         fuenfsteller = n.fuenfsteller,
         p295 = n.p295,
         p301 = n.p301,
         mortl1code = n.mortl1code,
         mortl2code = n.mortl2code,
         mortl3code = n.mortl3code,
         mortl4code = n.mortl4code,
         morblcode = n.morblcode,
         sexcode = n.sexcode,
         sexfehlertyp = n.sexfehlertyp,
         altunt = n.altunt,
         altob = n.altob,
         altfehlertyp = n.altfehlertyp,
         exot = n.exot,
         belegt = n.belegt,
         ifsgmeldung = n.ifsgmeldung,
         ifsglabor = n.ifsglabor
       from new_table n 
       where n.code = ig.code and (
         ig.ebene != n.ebene
         or ig.ort != n.ort
         or ig.art != n.art
         or ig.kapnr != n.kapnr
         or ig.grvon != n.grvon
         or ig.normcode != n.normcode
         or ig.codeohnepunkt != n.codeohnepunkt
         or ig.titel != n.titel
         or ig.dreisteller != n.dreisteller
         or (ig.dreisteller isnull and n.dreisteller notnull)
         or ig.viersteller != n.viersteller
         or (ig.viersteller isnull and n.viersteller notnull)
         or ig.fuenfsteller != n.fuenfsteller
         or (ig.fuenfsteller isnull and n.fuenfsteller notnull)
         or ig.p295 != n.p295
         or ig.p301 != n.p301
         or ig.mortl1code != n.mortl1code
         or ig.mortl2code != n.mortl2code
         or ig.mortl3code != n.mortl3code
         or ig.mortl4code != n.mortl4code
         or ig.morblcode != n.morblcode
         or ig.sexcode != n.sexcode
         or ig.sexfehlertyp != n.sexfehlertyp
         or ig.altunt != n.altunt
         or ig.altob != n.altob
         or ig.altfehlertyp != n.altfehlertyp
         or ig.exot != n.exot
         or ig.belegt != n.belegt
         or ig.ifsgmeldung != n.ifsgmeldung
         or ig.ifsglabor != n.ifsglabor
         )
         ;    
    return null;
  end;
 $$;

-- management the update of icd10gm in icd_metainfo.icd10gm 
create trigger tr_update_icd10gm
after insert on icd_metainfo.kodes 
referencing new table as new_table 
for each statement execute function icd_metainfo.func_update_icd10gm();


-- insert deleted icd10gm into table icd_metainfo.icd10gm_history
create or replace function icd_metainfo.func_insert_deleted_icd10gm_into_history()
returns trigger 
language plpgsql
as $$
  begin 
    INSERT INTO icd_metainfo.icd10gm_history (ver, code, titel, oldver, verevent)
	  select
	    (select distinct ver from icd_metainfo.kodes limit 1) ver,
	    ig.code,
	    ig.titel, 
	    ig.ver,
	    'D' verevent
	  from icd_metainfo.icd10gm ig
      left join (select code from icd_metainfo.icd10gm_history where verevent = 'D') igh
        on ig.code = igh.code
      left join new_table n 
        on n.code = ig.code 
      where n.code isnull
      and igh.code isnull  
	  ;
    return null;
  end;
 $$;

-- management the deleted icd10gm

create trigger tr_deleted_icd10gm_to_history
after insert on icd_metainfo.kodes 
referencing new table as new_table 
for each statement execute function icd_metainfo.func_insert_deleted_icd10gm_into_history();


-- insert the reused icd10gm into the table icd_metainfo.icd10gm_history
create or replace function icd_metainfo.func_reused_icd10gm_into_history()
returns trigger 
language plpgsql
as $$
  begin 
    INSERT INTO icd_metainfo.icd10gm_history
	  select 
	    n.*,
	    case 
	      when h.oldver isnull then h.ver
	      else h.oldver
	    end ver,
	    'DI' verevent
	  from new_table n
	  join icd_metainfo.icd10gm_history h
	    on n.code = h.code
	  left join (select code from icd_metainfo.icd10gm_history where verevent = 'DI') di
	    on n.code = di.code
	  where h.verevent = 'D'
	  and di.code isnull
    ;

    return null;
  end;
 $$;

-- management the reused icd10gm
create trigger tr_insert_reused_icd10gm_to_history
after insert on icd_metainfo.kodes 
referencing new table as new_table 
for each statement execute function icd_metainfo.func_reused_icd10gm_into_history()
