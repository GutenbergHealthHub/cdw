-- Function to insert and management the current icd10gm
-- 1. insert removed ICDs into the history table
-- 2. update ICDs to the new version if needed
-- 3. insert new ICDs into the management table 

drop FUNCTION func_insert_new_icd10gm_bfarm();
CREATE OR REPLACE FUNCTION icd_metainfo.func_insert_new_icd10gm_bfarm() RETURNS TRIGGER AS $icd10gm_bfarm$
    begin	    
	    
	       update icd_metainfo.icd10gm_history
	         set 
	           verevent = 'RU',
	           ver = vermodif,
	           vermodif = (select distinct ver from new_table n limit 1)	         
	         where verevent = 'D' and code in (select code from new_table n);
	        
	        
	        -- old icd to history
	    	insert into icd_metainfo.icd10gm_history   
		    	SELECT 
				  ig.ver,
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
				  (select ver from icd_metainfo.kodes limit 1) vermodi, 
				  'D' verevent
				FROM icd_metainfo.icd10gm ig 
				left join new_table icd -- ok
				  on icd.code = ig.code
				--join icd_metainfo.icd10gm_history igh 
				  --on igh.code = ig.code 
				where icd.code isnull 
			    and ig.code not in (select igh.code from icd_metainfo.icd10gm_history igh where igh.verevent = 'D')
			   ; --and igh.code isnull;
			
			-- update in normal table
			update icd_metainfo.icd10gm ig
		    	set 
				  ver = icd.ver,
				  ebene = icd.ebene,
				  ort = icd.ort,
				  art = icd.art,
				  kapnr = icd.kapnr,
				  grvon = icd.grvon,
				  normcode = icd.normcode,
				  codeohnepunkt = icd.codeohnepunkt,
				  titel = icd.titel,
				  dreisteller = icd.dreisteller,
				  viersteller = icd.viersteller,
				  fuenfsteller = icd.fuenfsteller,
				  p295 = icd.p295,
				  p301 = icd.p301,
				  mortl1code = icd.mortl1code,
				  mortl2code = icd.mortl2code,
				  mortl3code = icd.mortl3code,
				  mortl4code = icd.mortl4code,
				  morblcode = icd.morblcode,
				  sexcode = icd.sexcode,
				  sexfehlertyp = icd.sexfehlertyp,
				  altunt = icd.altunt,
				  altob = icd.altob,
				  altfehlertyp = icd.altfehlertyp,
				  exot = icd.exot,
				  belegt = icd.belegt,
				  ifsgmeldung = icd.ifsgmeldung,
				  ifsglabor = icd.ifsglabor
				  from new_table icd 
				where icd.code = ig.code and (
				  ig.ebene != icd.ebene
				  or ig.ort != icd.ort
				  or ig.art != icd.art
				  or ig.kapnr != icd.kapnr
				  or ig.grvon != icd.grvon
				  or ig.normcode != icd.normcode
				  or ig.codeohnepunkt != icd.codeohnepunkt
				  or ig.titel != icd.titel
				  or ig.dreisteller != icd.dreisteller
				  or (ig.dreisteller isnull and icd.dreisteller notnull)
				  or ig.viersteller != icd.viersteller
				  or (ig.viersteller isnull and icd.viersteller notnull)
				  or ig.fuenfsteller != icd.fuenfsteller
				  or (ig.fuenfsteller isnull and icd.fuenfsteller notnull)
				  or ig.p295 != icd.p295
				  or ig.p301 != icd.p301
				  or ig.mortl1code != icd.mortl1code
				  or ig.mortl2code != icd.mortl2code
				  or ig.mortl3code != icd.mortl3code
				  or ig.mortl4code != icd.mortl4code
				  or ig.morblcode != icd.morblcode
				  or ig.sexcode != icd.sexcode
				  or ig.sexfehlertyp != icd.sexfehlertyp
				  or ig.altunt != icd.altunt
				  or ig.altob != icd.altob
				  or ig.altfehlertyp != icd.altfehlertyp
				  or ig.exot != icd.exot
				  or ig.belegt != icd.belegt
				  or ig.ifsgmeldung != icd.ifsgmeldung
				  or ig.ifsglabor != icd.ifsglabor)
				 ;
		
            INSERT INTO icd_metainfo.icd10gm
              SELECT 
                n.*, false 
              FROM new_table n 
              left join icd_metainfo.icd10gm icd
                on icd.code = n.code
              where icd.code isnull;
             
             INSERT INTO icd_metainfo.icd10gm_history 
              SELECT 
                n.*,n.ver, 'I'
              FROM new_table n 
              left join icd_metainfo.icd10gm_history icd
                on icd.code = n.code
              where icd.code isnull;
             
        RETURN NULL;
    END;
$icd10gm_bfarm$ LANGUAGE plpgsql;


-- trigger in table icd_metainfo.kode to insert new icds
CREATE TRIGGER tr_icd10gm_insert_from_bfarm
    AFTER INSERT ON icd_metainfo.kodes 
    REFERENCING NEW TABLE AS new_table
    FOR EACH STATEMENT EXECUTE FUNCTION icd_metainfo.func_insert_new_icd10gm_bfarm();