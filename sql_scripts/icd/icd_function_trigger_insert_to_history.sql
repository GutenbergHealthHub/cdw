-- Function to insert modified icd10gm into history table 
-- insert update ICDs into the history table

CREATE OR REPLACE FUNCTION func_updated_to_icd10gm_history() RETURNS TRIGGER AS $icd10gm_to_history$
    begin
	    	-- updated icd to history
			insert into icd_metainfo.icd10gm_history   
		    	SELECT 
				  icd.ver,
				  icd.ebene,
				  icd.ort,
				  icd.art,
				  icd.kapnr,
				  icd.grvon,
				  icd.code,
				  icd.normcode,
				  icd.codeohnepunkt,
				  icd.titel,
				  icd.dreisteller,
				  icd.viersteller,
				  icd.fuenfsteller,
				  icd.p295,
				  icd.p301,
				  icd.mortl1code,
				  icd.mortl2code,
				  icd.mortl3code,
				  icd.mortl4code,
				  icd.morblcode,
				  icd.sexcode,
				  icd.sexfehlertyp,
				  icd.altunt,
				  icd.altob,
				  icd.altfehlertyp,
				  icd.exot,
				  icd.belegt,
				  icd.ifsgmeldung,
				  icd.ifsglabor,
				  ig.ver,
				  'U' verevent
				FROM new_table icd 
				join icd_metainfo.kodes ig 
				  on icd.code = ig.code
				where (ig.ebene != icd.ebene
				  or ig.ort != icd.ort
				  or ig.art != icd.art
				  or ig.kapnr != icd.kapnr
				  or ig.grvon != icd.grvon
				  or ig.normcode != icd.normcode
				  or ig.codeohnepunkt != icd.codeohnepunkt
				  or ig.titel != icd.titel
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
        RETURN NULL; 
    END;
$icd10gm_to_history$ LANGUAGE plpgsql;

--trigger to update the history table with the old values
CREATE TRIGGER tr_icd10gm_updated_to_history
    AFTER UPDATE ON icd_metainfo.icd10gm 
    REFERENCING OLD TABLE AS new_table
    FOR EACH STATEMENT EXECUTE FUNCTION func_updated_to_icd10gm_history();