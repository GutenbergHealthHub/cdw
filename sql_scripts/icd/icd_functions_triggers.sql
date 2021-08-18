-- function to insert management the current icd10gm
-- insert removed ICDs into the history table
-- insert update ICDs into the history table
-- update ICDs to the new version if needed
-- insert new ICDs into the management table 
CREATE OR REPLACE FUNCTION func_insert_new_icd10gm_bfarm() RETURNS TRIGGER AS $new_icd10gm_bfarm$
    begin
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
				  date_part('year', now())::varchar nver,
				  'D' verevent
				FROM icd_metainfo.icd10gm ig 
				left join new_table icd -- ok
				  on icd.code = ig.code
				left join icd_metainfo.icd10gm_history igh 
				  on igh.code = ig.code
				where icd.code isnull and igh.code isnull;
			
			-- updated icd to history
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
				  date_part('year', now())::varchar nver,
				  'U' verevent
				FROM icd_metainfo.icd10gm ig 
				join new_table icd -- ok
				  on icd.code = ig.code
				left join icd_metainfo.icd10gm_history igh
				  on ig.code = igh.code
				where (ig.ebene != icd.ebene
				  or ig.ort != icd.ort
				  or ig.art != icd.art
				  or ig.kapnr != icd.kapnr
				  or ig.grvon != icd.grvon
				  or ig.normcode != icd.normcode
				  or ig.codeohnepunkt != icd.codeohnepunkt
				  or ig.titel != icd.titel
				  or ig.dreisteller != icd.dreisteller
				  or ig.viersteller != icd.viersteller
				  or ig.fuenfsteller != icd.fuenfsteller
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
				  and (igh.code isnull or igh.ver isnull)
				 ;
			
			-- update in normal table
			update icd_metainfo.icd10gm ig
		    	set 
				  ver = date_part('year', now())::varchar,
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
				  or ig.viersteller != icd.viersteller
				  or ig.fuenfsteller != icd.fuenfsteller
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
                date_part('year', now()), n.*, false 
              FROM new_table n 
              left join icd_metainfo.icd10gm icd
                on icd.code = n.code
              where icd.code isnull;
        RETURN NULL; -- result is ignored since this is an AFTER trigger
    END;
$new_icd10gm_bfarm$ LANGUAGE plpgsql;


-- trigger in table icd_metainfo.kode to insert new icds
CREATE TRIGGER tr_icd10gm_insert_from_bfarm
    AFTER INSERT ON icd_metainfo.kodes 
    REFERENCING NEW TABLE AS new_table
    FOR EACH STATEMENT EXECUTE FUNCTION func_insert_new_icd10gm_bfarm();
   

-- function to insert management the old icd10gm (from 2007 to 2020)
-- insert removed ICDs into the history table
-- insert update ICDs into the history table
-- update ICDs to the new version if needed
-- insert new ICDs into the management table
CREATE OR REPLACE FUNCTION func_insert_new_icd10gm_files() RETURNS TRIGGER AS $new_icd10gm_files$
    BEGIN
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
				  (select ver from new_table limit 1) vermodif, -- version without the icd
				  'D' verevent
				FROM icd_metainfo.icd10gm ig 
				left join new_table icd -- ok
				  on icd.code = ig.code
				left join icd_metainfo.icd10gm_history igh 
				  on igh.code = ig.code
				where icd.code isnull and igh.code isnull;
			
			-- updated icd to history
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
				  (select ver from new_table limit 1) vermodif,
				  'U' verevent
				FROM icd_metainfo.icd10gm ig 
				join new_table icd -- ok
				  on icd.code = ig.code
				left join icd_metainfo.icd10gm_history igh
				  on ig.code = igh.code
				where (ig.ebene != icd.ebene
				  or ig.ort != icd.ort
				  or ig.art != icd.art
				  or ig.kapnr != icd.kapnr
				  or ig.grvon != icd.grvon
				  or ig.normcode != icd.normcode
				  or ig.codeohnepunkt != icd.codeohnepunkt
				  or ig.titel != icd.titel
				  or ig.dreisteller != icd.dreisteller
				  or ig.viersteller != icd.viersteller
				  or ig.fuenfsteller != icd.fuenfsteller
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
				  or ig.ifsglabor != icd.ifsglabor
				  )
				  and (igh.code isnull or igh.ver isnull)
				 ;
				
				
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
				  or ig.viersteller != icd.viersteller
				  or ig.fuenfsteller != icd.fuenfsteller
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
             
        RETURN NULL;
    END;
$new_icd10gm_files$ LANGUAGE plpgsql;

-- trigger in table icd_metainfo.icd_tmp to insert new (old) icds 
CREATE TRIGGER tr_icd10gm_insert_from_files
    AFTER INSERT ON icd_metainfo.icd_tmp 
    REFERENCING NEW TABLE AS new_table
    FOR EACH STATEMENT EXECUTE FUNCTION func_insert_new_icd10gm_files();
