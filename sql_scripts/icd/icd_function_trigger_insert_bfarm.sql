-- Function to insert and management the current icd10gm
-- 1. insert removed ICDs into the history table
-- 2. update ICDs to the new version if needed
-- 3. insert new ICDs into the management table 

drop FUNCTION func_insert_new_icd10gm_bfarm();
CREATE OR REPLACE FUNCTION icd_metainfo.func_insert_new_icd10gm_bfarm() RETURNS TRIGGER AS $icd10gm_bfarm$
    begin	    
	       
		
            INSERT INTO icd_metainfo.icd10gm
              SELECT 
                n.*
              FROM new_table n 
              left join icd_metainfo.icd10gm icd
                on icd.code = n.code
              where icd.code isnull;
             
             INSERT INTO icd_metainfo.icd10gm_history 
              SELECT 
                n.*,
                null oldver, 
                'I' verevent
              FROM new_table n 
              left join icd_metainfo.icd10gm_history icd
                on icd.code = n.code
              where icd.code isnull
              --on conflict (code, ver, verevent) do nothing
              ;
             
             /*INSERT INTO icd_metainfo.icd10gm_history 
              SELECT 
                n.*,
                icd.ver oldver, 
                'DI' verevent
              FROM new_table n 
              join icd_metainfo.icd10gm_history icd
                on icd.code = n.code
              where icd.verevent != 'D'
              and exists (select h.code from icd_metainfo.icd10gm_history h where n.code = h.code and h.verevent = 'D')
              on conflict (code, ver, verevent) do nothing
              ;*/
            
             -------------------------------
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
                
                ----------------------------------
                insert into icd_metainfo.icd10gm_history 
                select 
                  --distinct on (code)
                  (select distinct ver from icd_metainfo.kodes limit 1) ver,
                  ig.ebene,
                  ig.ort,
                  ig.art,
                  ig.kapnr,
                  ig.grvon,
                  ig.code,
                  ig.normcode,
                  ig.codeohnepunkt,
                  ig.titel,
                  ig.dreisteller,
                  ig.viersteller,
                  ig.fuenfsteller,
                  ig.p295,
                  ig.p301,
                  ig.mortl1code,
                  ig.mortl2code,
                  ig.mortl3code,
                  ig.mortl4code,
                  ig.morblcode,
                  ig.sexcode,
                  ig.sexfehlertyp,
                  ig.altunt,
                  ig.altob,
                  ig.altfehlertyp,
                  ig.exot,
                  ig.belegt,
                  ig.ifsgmeldung,
                  ig.ifsglabor, 
                  ig.ver, 
                  'D' verevent
                from icd_metainfo.icd10gm ig
                left join (select code from icd_metainfo.icd10gm_history where verevent = 'D') igh
                  on ig.code = igh.code
                left join new_table n 
                  on n.code = ig.code 
                where n.code isnull
                and igh.code isnull 
                --and not igh.isdeleted
                --and 
                --on conflict (code, ver, verevent) do nothing
                ;
                 
             
        RETURN NULL;
    END;
$icd10gm_bfarm$ LANGUAGE plpgsql;


-- trigger in table icd_metainfo.kode to insert new icds
CREATE TRIGGER tr_icd10gm_insert_from_bfarm
    AFTER INSERT ON icd_metainfo.kodes 
    REFERENCING NEW TABLE AS new_table
    FOR EACH STATEMENT EXECUTE FUNCTION icd_metainfo.func_insert_new_icd10gm_bfarm();