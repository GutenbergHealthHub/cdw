-- Function to insert modified icd10gm into history table 
-- 1. insert updated ICD into the history table and set as updated (U if not deleted and DI if deleted and reused)
-- 2. set reused ICD in the history table as "not deleted" (isdeleted false)

CREATE OR REPLACE FUNCTION icd_metainfo.func_updated_to_icd10gm_history()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$
    begin
	    	-- updated icd to history
			insert into icd_metainfo.icd10gm_history   
		    	SELECT 
		    	  k.*,
				  n.ver,
				  case 
				    when k.code in (select code from icd_metainfo.icd10gm_history where isdeleted)
				      then 'DI'
				    else 'U'
				  end verevent 
				FROM new_table n
				join icd_metainfo.kodes k
				  on n.code = k.code
				  where (n.ebene != k.ebene
				  or n.ort != k.ort
				  or n.art != k.art
				  or n.kapnr != k.kapnr
				  or n.grvon != k.grvon
				  or n.normcode != k.normcode
				  or n.codeohnepunkt != k.codeohnepunkt
				  or n.titel != k.titel
				  or n.dreisteller != k.dreisteller
                  or (n.dreisteller isnull and k.dreisteller notnull)
                  or n.viersteller != k.viersteller
                  or (n.viersteller isnull and k.viersteller notnull)
                  or n.fuenfsteller != k.fuenfsteller
                  or (n.fuenfsteller isnull and k.fuenfsteller notnull)
				  or n.p295 != k.p295
				  or n.p301 != k.p301
				  or n.mortl1code != k.mortl1code
				  or n.mortl2code != k.mortl2code
				  or n.mortl3code != k.mortl3code
				  or n.mortl4code != k.mortl4code
				  or n.morblcode != k.morblcode
				  or n.sexcode != k.sexcode
				  or n.sexfehlertyp != k.sexfehlertyp
				  or n.altunt != k.altunt
				  or n.altob != k.altob
				  or n.altfehlertyp != k.altfehlertyp
				  or n.exot != k.exot
				  or n.belegt != k.belegt
				  or n.ifsgmeldung != k.ifsgmeldung
				  or n.ifsglabor != k.ifsglabor)
				 ;
				
				update icd_metainfo.icd10gm_history 
				  set isdeleted = false
				  where code in (select code from icd_metainfo.kodes);
				 
        RETURN NULL; 
    END;
$function$
;

CREATE TRIGGER tr_icd10gm_updated_to_history
    AFTER UPDATE ON icd_metainfo.icd10gm 
    REFERENCING old TABLE AS new_table
    FOR EACH STATEMENT EXECUTE FUNCTION icd_metainfo.func_updated_to_icd10gm_history();
