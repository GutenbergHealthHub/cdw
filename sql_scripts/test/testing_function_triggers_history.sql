-- Function to insert modified icd10gm into history table 
-- insert update ICDs into the history table

CREATE OR REPLACE FUNCTION icd_metainfo.func_updated_to_icd10gm_history() RETURNS TRIGGER AS $icd10gm_to_history$
    begin
	    	-- updated icd to history
			insert into icd_metainfo.icd10gm_history   
		    	SELECT 
		    	  k.*,
				  n.ver,
				  case 
				    when k.code in (select code from icd_metainfo.icd10gm_history where verevent = 'D')
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
        RETURN NULL; 
    END;
$icd10gm_to_history$ LANGUAGE plpgsql;

--drop trigger tr_icd10gm_updated_to_history on icd_metainfo.icd10gm;

--trigger to update the history table with the old values
CREATE TRIGGER tr_icd10gm_updated_to_history
    AFTER UPDATE ON icd_metainfo.icd10gm 
    REFERENCING old TABLE AS new_table
    FOR EACH STATEMENT EXECUTE FUNCTION icd_metainfo.func_updated_to_icd10gm_history();