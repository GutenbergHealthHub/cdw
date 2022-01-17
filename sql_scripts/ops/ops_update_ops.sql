-- update ops into ops 

CREATE OR REPLACE FUNCTION ops_metainfo.func_update_ops()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$
  begin 
     update ops_metainfo.ops o
       set  
         ver = n.ver,
         ebene = n.ebene,
         ort = n.ort,
         art = n.art,
         kapnr = n.kapnr,
         grvon = n.grvon,
         dkode = n.dkode,
         kode = n.kode,
         seite = n.seite,
         titel = n.titel,
         viersteller = n.viersteller,
         fuenfsteller = n.fuenfsteller,
         sechssteller = n.sechssteller,
         para17bd = n.para17bd,
         zusatzk = n.zusatzk,
         einmalk = n.einmalk 
       from new_table n 
       where n.kode = o.kode and (
         o.ebene != n.ebene
         or o.ort != n.ort
         or o.art != n.art
         or o.kapnr != n.kapnr
         or o.grvon != n.grvon
         or o.dkode != n.dkode
         or o.kode != n.kode
         or o.seite !=n.seite
         or o.titel != n.titel
         or o.viersteller != n.viersteller
         or (o.viersteller isnull and n.viersteller notnull)
         or o.fuenfsteller != n.fuenfsteller
         or (o.fuenfsteller isnull and n.fuenfsteller notnull)
         or o.sechssteller != n.sechssteller
         or (o.sechssteller isnull and n.sechssteller notnull)
         or o.para17bd = n.para17bd
         or (o.para17bd isnull and n.para17bd notnull)
         or o.zusatzk != n.zusatzk
         or (o.zusatzk isnull and n.zusatzk notnull)
         or o.einmalk != n.einmalk
         or (o.einmalk isnull and n.einmalk notnull)
         )
         ;    
    return null;
  end;
 $function$
;

create trigger tr_update_ops after
insert
    on
    ops_metainfo.kodes referencing new table as new_table for each statement execute function ops_metainfo.func_update_ops();


CREATE OR REPLACE FUNCTION ops_metainfo.func_insert_updated_ops_into_history()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$
  begin
    INSERT INTO ops_metainfo.ops_history
          select
            distinct on (o.kode)
            n.*,
            o.ver,
            'U' verevent
          FROM new_table n
          join ops_metainfo.ops_history o
            on o.kode = n.kode
          order by o.kode, o.ver desc
         ;
        
    return null;
  end;
 $function$
;

create trigger tr_updated_ops_to_history after
update
    on
    ops_metainfo.ops referencing new table as new_table for each statement execute function ops_metainfo.func_insert_updated_ops_into_history();

