--
-- PostgreSQL database dump
--

-- Dumped from database version 11.16 (Ubuntu 11.16-1.pgdg18.04+1)
-- Dumped by pg_dump version 14.2

-- Started on 2022-05-27 17:30:33

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 10 (class 2615 OID 17068)
-- Name: i2b2miracum; Type: SCHEMA; Schema: -; Owner: i2b2miracum
--

CREATE SCHEMA i2b2miracum;


ALTER SCHEMA i2b2miracum OWNER TO i2b2miracum;

--
-- TOC entry 437 (class 1255 OID 17085)
-- Name: create_temp_concept_table(text); Type: FUNCTION; Schema: i2b2miracum; Owner: i2b2miracum
--

CREATE FUNCTION i2b2miracum.create_temp_concept_table(tempconcepttablename text, OUT errormsg text) RETURNS text
    LANGUAGE plpgsql
    AS $$
BEGIN 
    EXECUTE 'create table ' ||  tempConceptTableName || ' (
        CONCEPT_CD varchar(50) NOT NULL, 
        CONCEPT_PATH varchar(900) NOT NULL , 
        NAME_CHAR varchar(2000), 
        CONCEPT_BLOB text, 
        UPDATE_DATE timestamp, 
        DOWNLOAD_DATE timestamp, 
        IMPORT_DATE timestamp, 
        SOURCESYSTEM_CD varchar(50)
    ) WITH OIDS';
    EXECUTE 'CREATE INDEX idx_' || tempConceptTableName || '_pat_id ON ' || tempConceptTableName || '  (CONCEPT_PATH)';
    EXCEPTION
    WHEN OTHERS THEN
        RAISE EXCEPTION 'An error was encountered - % -ERROR- %',SQLSTATE,SQLERRM;      
END;
$$;


ALTER FUNCTION i2b2miracum.create_temp_concept_table(tempconcepttablename text, OUT errormsg text) OWNER TO i2b2miracum;

--
-- TOC entry 438 (class 1255 OID 17086)
-- Name: create_temp_eid_table(text); Type: FUNCTION; Schema: i2b2miracum; Owner: i2b2miracum
--

CREATE FUNCTION i2b2miracum.create_temp_eid_table(temppatientmappingtablename text, OUT errormsg text) RETURNS text
    LANGUAGE plpgsql
    AS $$
BEGIN 
    EXECUTE 'create table ' ||  tempPatientMappingTableName || ' (
        ENCOUNTER_MAP_ID        varchar(200) NOT NULL,
        ENCOUNTER_MAP_ID_SOURCE     varchar(50) NOT NULL,
        PATIENT_MAP_ID          varchar(200), 
        PATIENT_MAP_ID_SOURCE   varchar(50), 
        ENCOUNTER_ID            varchar(200) NOT NULL,
        ENCOUNTER_ID_SOURCE     varchar(50) ,
        ENCOUNTER_NUM           numeric, 
        ENCOUNTER_MAP_ID_STATUS    varchar(50),
        PROCESS_STATUS_FLAG     char(1),
        UPDATE_DATE timestamp, 
        DOWNLOAD_DATE timestamp, 
        IMPORT_DATE timestamp, 
        SOURCESYSTEM_CD varchar(50)
    ) WITH OIDS';
    EXECUTE 'CREATE INDEX idx_' || tempPatientMappingTableName || '_eid_id ON ' || tempPatientMappingTableName || '  (ENCOUNTER_ID, ENCOUNTER_ID_SOURCE, ENCOUNTER_MAP_ID, ENCOUNTER_MAP_ID_SOURCE, ENCOUNTER_NUM)';
    EXECUTE 'CREATE INDEX idx_' || tempPatientMappingTableName || '_stateid_eid_id ON ' || tempPatientMappingTableName || '  (PROCESS_STATUS_FLAG)';  
    EXCEPTION
    WHEN OTHERS THEN
        RAISE NOTICE '%%%', SQLSTATE || ' - ' || SQLERRM;
END;
$$;


ALTER FUNCTION i2b2miracum.create_temp_eid_table(temppatientmappingtablename text, OUT errormsg text) OWNER TO i2b2miracum;

--
-- TOC entry 439 (class 1255 OID 17087)
-- Name: create_temp_modifier_table(text); Type: FUNCTION; Schema: i2b2miracum; Owner: i2b2miracum
--

CREATE FUNCTION i2b2miracum.create_temp_modifier_table(tempmodifiertablename text, OUT errormsg text) RETURNS text
    LANGUAGE plpgsql
    AS $$
BEGIN 
EXECUTE 'create table ' ||  tempModifierTableName || ' (
        MODIFIER_CD varchar(50) NOT NULL, 
        MODIFIER_PATH varchar(900) NOT NULL , 
        NAME_CHAR varchar(2000), 
        MODIFIER_BLOB text, 
        UPDATE_DATE timestamp, 
        DOWNLOAD_DATE timestamp, 
        IMPORT_DATE timestamp, 
        SOURCESYSTEM_CD varchar(50)
         ) WITH OIDS';
 EXECUTE 'CREATE INDEX idx_' || tempModifierTableName || '_pat_id ON ' || tempModifierTableName || '  (MODIFIER_PATH)';
EXCEPTION
        WHEN OTHERS THEN
        RAISE EXCEPTION 'An error was encountered - % -ERROR- %',SQLSTATE,SQLERRM;      
END;
$$;


ALTER FUNCTION i2b2miracum.create_temp_modifier_table(tempmodifiertablename text, OUT errormsg text) OWNER TO i2b2miracum;

--
-- TOC entry 443 (class 1255 OID 17088)
-- Name: create_temp_patient_table(text); Type: FUNCTION; Schema: i2b2miracum; Owner: i2b2miracum
--

CREATE FUNCTION i2b2miracum.create_temp_patient_table(temppatientdimensiontablename text, OUT errormsg text) RETURNS text
    LANGUAGE plpgsql
    AS $$
BEGIN 
    -- Create temp table to store encounter/visit information
    EXECUTE 'create table ' ||  tempPatientDimensionTableName || ' (
        patient_id varchar(200), 
        patient_id_source varchar(50),
        patient_num numeric(38,0),
        vital_status_cd varchar(50), 
        birth_date timestamp, 
        death_date timestamp, 
        sex_cd char(50), 
        age_in_years_num numeric(5,0), 
        language_cd varchar(50), 
        race_cd varchar(50 ), 
        marital_status_cd varchar(50), 
        religion_cd varchar(50), 
        zip_cd varchar(50), 
        statecityzip_path varchar(700), 
        patient_blob text, 
        update_date timestamp, 
        download_date timestamp, 
        import_date timestamp, 
        sourcesystem_cd varchar(50)
    )';
    EXECUTE 'CREATE INDEX idx_' || tempPatientDimensionTableName || '_pat_id ON ' || tempPatientDimensionTableName || '  (patient_id, patient_id_source,patient_num)';
    EXCEPTION
    WHEN OTHERS THEN
        RAISE NOTICE '%%%', SQLSTATE || ' - ' || SQLERRM;
END;
$$;


ALTER FUNCTION i2b2miracum.create_temp_patient_table(temppatientdimensiontablename text, OUT errormsg text) OWNER TO i2b2miracum;

--
-- TOC entry 444 (class 1255 OID 17089)
-- Name: create_temp_pid_table(text); Type: FUNCTION; Schema: i2b2miracum; Owner: i2b2miracum
--

CREATE FUNCTION i2b2miracum.create_temp_pid_table(temppatientmappingtablename text, OUT errormsg text) RETURNS text
    LANGUAGE plpgsql
    AS $$
BEGIN 
	EXECUTE 'create table ' ||  tempPatientMappingTableName || ' (
		PATIENT_MAP_ID varchar(200), 
		PATIENT_MAP_ID_SOURCE varchar(50), 
		PATIENT_ID_STATUS varchar(50), 
		PATIENT_ID  varchar(200),
		PATIENT_ID_SOURCE varchar(50),
		PATIENT_NUM numeric(38,0),
		PATIENT_MAP_ID_STATUS varchar(50), 
		PROCESS_STATUS_FLAG char(1), 
		UPDATE_DATE timestamp, 
		DOWNLOAD_DATE timestamp, 
		IMPORT_DATE timestamp, 
		SOURCESYSTEM_CD varchar(50)
	) WITH OIDS';
	EXECUTE 'CREATE INDEX idx_' || tempPatientMappingTableName || '_pid_id ON ' || tempPatientMappingTableName || '  ( PATIENT_ID, PATIENT_ID_SOURCE )';
	EXECUTE 'CREATE INDEX idx_' || tempPatientMappingTableName || 'map_pid_id ON ' || tempPatientMappingTableName || '  
	( PATIENT_ID, PATIENT_ID_SOURCE,PATIENT_MAP_ID, PATIENT_MAP_ID_SOURCE,  PATIENT_NUM )';
	EXECUTE 'CREATE INDEX idx_' || tempPatientMappingTableName || 'stat_pid_id ON ' || tempPatientMappingTableName || '  
	(PROCESS_STATUS_FLAG)';
	EXCEPTION
	WHEN OTHERS THEN
		RAISE NOTICE '%%%', SQLSTATE || ' - ' || SQLERRM;
END;
$$;


ALTER FUNCTION i2b2miracum.create_temp_pid_table(temppatientmappingtablename text, OUT errormsg text) OWNER TO i2b2miracum;

--
-- TOC entry 445 (class 1255 OID 17090)
-- Name: create_temp_provider_table(text); Type: FUNCTION; Schema: i2b2miracum; Owner: i2b2miracum
--

CREATE FUNCTION i2b2miracum.create_temp_provider_table(tempprovidertablename text, OUT errormsg text) RETURNS text
    LANGUAGE plpgsql
    AS $$
BEGIN 
    EXECUTE 'create table ' ||  tempProviderTableName || ' (
        PROVIDER_ID varchar(50) NOT NULL, 
        PROVIDER_PATH varchar(700) NOT NULL, 
        NAME_CHAR varchar(2000), 
        PROVIDER_BLOB text, 
        UPDATE_DATE timestamp, 
        DOWNLOAD_DATE timestamp, 
        IMPORT_DATE timestamp, 
        SOURCESYSTEM_CD varchar(50), 
        UPLOAD_ID numeric
    ) WITH OIDS';
    EXECUTE 'CREATE INDEX idx_' || tempProviderTableName || '_ppath_id ON ' || tempProviderTableName || '  (PROVIDER_PATH)';
    EXCEPTION
    WHEN OTHERS THEN
        RAISE EXCEPTION 'An error was encountered - % -ERROR- %',SQLSTATE,SQLERRM;      

END;
$$;


ALTER FUNCTION i2b2miracum.create_temp_provider_table(tempprovidertablename text, OUT errormsg text) OWNER TO i2b2miracum;

--
-- TOC entry 446 (class 1255 OID 17091)
-- Name: create_temp_table(text); Type: FUNCTION; Schema: i2b2miracum; Owner: i2b2miracum
--

CREATE FUNCTION i2b2miracum.create_temp_table(temptablename text, OUT errormsg text) RETURNS text
    LANGUAGE plpgsql
    AS $$
BEGIN 
    EXECUTE 'create table ' ||  tempTableName || '  (
        encounter_num  numeric(38,0),
        encounter_id varchar(200) not null, 
        encounter_id_source varchar(50) not null,
        concept_cd       varchar(50) not null, 
        patient_num numeric(38,0), 
        patient_id  varchar(200) not null,
        patient_id_source  varchar(50) not null,
        provider_id   varchar(50),
        start_date   timestamp, 
        modifier_cd varchar(100),
        instance_num numeric(18,0),
        valtype_cd varchar(50),
        tval_char varchar(255),
        nval_num numeric(18,5),
        valueflag_cd char(50),
        quantity_num numeric(18,5),
        confidence_num numeric(18,0),
        observation_blob text,
        units_cd varchar(50),
        end_date    timestamp,
        location_cd varchar(50),
        update_date  timestamp,
        download_date timestamp,
        import_date timestamp,
        sourcesystem_cd varchar(50) ,
        upload_id integer
    ) WITH OIDS';
    EXECUTE 'CREATE INDEX idx_' || tempTableName || '_pk ON ' || tempTableName || '  ( encounter_num,patient_num,concept_cd,provider_id,start_date,modifier_cd,instance_num)';
    EXECUTE 'CREATE INDEX idx_' || tempTableName || '_enc_pat_id ON ' || tempTableName || '  (encounter_id,encounter_id_source, patient_id,patient_id_source )';
    EXCEPTION
    WHEN OTHERS THEN
        RAISE EXCEPTION 'An error was encountered - % -ERROR- %',SQLSTATE,SQLERRM; 
END;
$$;


ALTER FUNCTION i2b2miracum.create_temp_table(temptablename text, OUT errormsg text) OWNER TO i2b2miracum;

--
-- TOC entry 450 (class 1255 OID 17092)
-- Name: create_temp_visit_table(text); Type: FUNCTION; Schema: i2b2miracum; Owner: i2b2miracum
--

CREATE FUNCTION i2b2miracum.create_temp_visit_table(temptablename text, OUT errormsg text) RETURNS text
    LANGUAGE plpgsql
    AS $$
BEGIN 
    -- Create temp table to store encounter/visit information
    EXECUTE 'create table ' ||  tempTableName || ' (
        encounter_id                    varchar(200) not null,
        encounter_id_source             varchar(50) not null, 
        project_id                      varchar(50) not null,
        patient_id                      varchar(200) not null,
        patient_id_source               varchar(50) not null,
        encounter_num                   numeric(38,0), 
        inout_cd                        varchar(50),
        location_cd                     varchar(50),
        location_path                   varchar(900),
        start_date                      timestamp, 
        end_date                        timestamp,
        visit_blob                      text,
        update_date                     timestamp,
        download_date                   timestamp,
        import_date                     timestamp,
        sourcesystem_cd                 varchar(50)
    ) WITH OIDS';
    EXECUTE 'CREATE INDEX idx_' || tempTableName || '_enc_id ON ' || tempTableName || '  ( encounter_id,encounter_id_source,patient_id,patient_id_source )';
    EXECUTE 'CREATE INDEX idx_' || tempTableName || '_patient_id ON ' || tempTableName || '  ( patient_id,patient_id_source )';
    EXCEPTION
    WHEN OTHERS THEN    
        RAISE EXCEPTION 'An error was encountered - % -ERROR- %',SQLSTATE,SQLERRM;    
END;
$$;


ALTER FUNCTION i2b2miracum.create_temp_visit_table(temptablename text, OUT errormsg text) OWNER TO i2b2miracum;

--
-- TOC entry 451 (class 1255 OID 17093)
-- Name: insert_concept_fromtemp(text, bigint); Type: FUNCTION; Schema: i2b2miracum; Owner: i2b2miracum
--

CREATE FUNCTION i2b2miracum.insert_concept_fromtemp(tempconcepttablename text, upload_id bigint, OUT errormsg text) RETURNS text
    LANGUAGE plpgsql
    AS $$
BEGIN 
    --Delete duplicate rows with same encounter and patient combination
    EXECUTE 'DELETE 
    FROM
    ' || tempConceptTableName || ' t1 
    WHERE
    oid > (SELECT  
        min(oid) 
        FROM 
        ' || tempConceptTableName || ' t2
        WHERE 
        t1.concept_cd = t2.concept_cd 
        AND t1.concept_path = t2.concept_path
    )';
    EXECUTE ' UPDATE concept_dimension  
    SET  
    concept_cd=temp.concept_cd
    ,name_char=temp.name_char
    ,concept_blob=temp.concept_blob
    ,update_date=temp.update_date
    ,download_date=temp.download_date
    ,import_date=Now()
    ,sourcesystem_cd=temp.sourcesystem_cd
    ,upload_id=' || UPLOAD_ID  || '
    FROM 
    ' || tempConceptTableName || '  temp   
    WHERE 
    temp.concept_path = concept_dimension.concept_path 
    AND temp.update_date >= concept_dimension.update_date 
    AND EXISTS (SELECT 1 
        FROM ' || tempConceptTableName || ' temp  
        WHERE temp.concept_path = concept_dimension.concept_path 
        AND temp.update_date >= concept_dimension.update_date
    )
    ';
    --Create new patient(patient_mapping) if temp table patient_ide does not exists 
    -- in patient_mapping table.
    EXECUTE 'INSERT INTO concept_dimension  (
        concept_cd
        ,concept_path
        ,name_char
        ,concept_blob
        ,update_date
        ,download_date
        ,import_date
        ,sourcesystem_cd
        ,upload_id
    )
    SELECT  
    concept_cd
    ,concept_path
    ,name_char
    ,concept_blob
    ,update_date
    ,download_date
    ,Now()
    ,sourcesystem_cd
    ,' || upload_id || '
    FROM ' || tempConceptTableName || '  temp
    WHERE NOT EXISTS (SELECT concept_cd 
        FROM concept_dimension cd 
        WHERE cd.concept_path = temp.concept_path)
    ';
    EXCEPTION
    WHEN OTHERS THEN
        RAISE EXCEPTION 'An error was encountered - % -ERROR- %',SQLSTATE,SQLERRM;      
END;
$$;


ALTER FUNCTION i2b2miracum.insert_concept_fromtemp(tempconcepttablename text, upload_id bigint, OUT errormsg text) OWNER TO i2b2miracum;

--
-- TOC entry 452 (class 1255 OID 17094)
-- Name: insert_eid_map_fromtemp(text, bigint); Type: FUNCTION; Schema: i2b2miracum; Owner: i2b2miracum
--

CREATE FUNCTION i2b2miracum.insert_eid_map_fromtemp(tempeidtablename text, upload_id bigint, OUT errormsg text) RETURNS text
    LANGUAGE plpgsql
    AS $_$
DECLARE

existingEncounterNum varchar(32);
maxEncounterNum bigint;
distinctEidCur REFCURSOR;
disEncounterId varchar(100); 
disEncounterIdSource varchar(100);
disPatientId varchar(100);
disPatientIdSource varchar(100);

BEGIN
    EXECUTE ' delete  from ' || tempEidTableName ||  ' t1  where 
    oid > (select min(oid) from ' || tempEidTableName || ' t2 
        where t1.encounter_map_id = t2.encounter_map_id
        and t1.encounter_map_id_source = t2.encounter_map_id_source
        and t1.encounter_id = t2.encounter_id
        and t1.encounter_id_source = t2.encounter_id_source) ';
    LOCK TABLE  encounter_mapping IN EXCLUSIVE MODE NOWAIT;
    select max(encounter_num) into STRICT  maxEncounterNum from encounter_mapping ; 
    if coalesce(maxEncounterNum::text, '') = '' then 
        maxEncounterNum := 0;
    end if;
    open distinctEidCur for EXECUTE 'SELECT distinct encounter_id,encounter_id_source,patient_map_id,patient_map_id_source from ' || tempEidTableName ||' ' ;
    loop
        FETCH distinctEidCur INTO disEncounterId, disEncounterIdSource,disPatientId,disPatientIdSource;
        IF NOT FOUND THEN EXIT; END IF; 
            
            if  disEncounterIdSource = 'HIVE'  THEN 
                begin
                    
                    select encounter_num into existingEncounterNum from encounter_mapping where encounter_num = CAST(disEncounterId AS numeric) and encounter_ide_source = 'HIVE';
                    EXCEPTION  when NO_DATA_FOUND THEN
                        existingEncounterNum := null;
                end;
                if (existingEncounterNum IS NOT NULL AND existingEncounterNum::text <> '') then 
                    EXECUTE ' update ' || tempEidTableName ||' set encounter_num = CAST(encounter_id AS numeric), process_status_flag = ''P''
                    where encounter_id = $1 and not exists (select 1 from encounter_mapping em where em.encounter_ide = encounter_map_id
                        and em.encounter_ide_source = encounter_map_id_source)' using disEncounterId;
                else 
                    
                    if maxEncounterNum < CAST(disEncounterId AS numeric) then 
                        maxEncounterNum := disEncounterId;
                    end if ;
                    EXECUTE ' update ' || tempEidTableName ||' set encounter_num = CAST(encounter_id AS numeric), process_status_flag = ''P'' where 
                    encounter_id =  $1 and encounter_id_source = ''HIVE'' and not exists (select 1 from encounter_mapping em where em.encounter_ide = encounter_map_id
                        and em.encounter_ide_source = encounter_map_id_source)' using disEncounterId;
                end if;    
                
                
            else 
                begin
                    select encounter_num into STRICT  existingEncounterNum from encounter_mapping where encounter_ide = disEncounterId and 
                    encounter_ide_source = disEncounterIdSource and patient_ide=disPatientId and patient_ide_source=disPatientIdSource; 
                    
                    EXCEPTION
    WHEN NO_DATA_FOUND THEN
        existingEncounterNum := null;
                end;
                if existingEncounterNum is not  null then 
                    EXECUTE ' update ' || tempEidTableName ||' set encounter_num = CAST($1 AS numeric) , process_status_flag = ''P''
                    where encounter_id = $2 and not exists (select 1 from encounter_mapping em where em.encounter_ide = encounter_map_id
                        and em.encounter_ide_source = encounter_map_id_source and em.patient_ide_source = patient_map_id_source and em.patient_ide=patient_map_id)' using existingEncounterNum, disEncounterId;
                else 
                    maxEncounterNum := maxEncounterNum + 1 ;
                    
                    EXECUTE ' insert into ' || tempEidTableName ||' (encounter_map_id,encounter_map_id_source,encounter_id,encounter_id_source,encounter_num,process_status_flag
                        ,encounter_map_id_status,update_date,download_date,import_date,sourcesystem_cd,patient_map_id,patient_map_id_source) 
                    values($1,''HIVE'',$2,''HIVE'',$3,''P'',''A'',Now(),Now(),Now(),''edu.harvard.i2b2.crc'',$4,$5)' using maxEncounterNum,maxEncounterNum,maxEncounterNum,disPatientId,disPatientIdSource; 
                    EXECUTE ' update ' || tempEidTableName ||' set encounter_num =  $1 , process_status_flag = ''P'' 
                    where encounter_id = $2 and  not exists (select 1 from 
                        encounter_mapping em where em.encounter_ide = encounter_map_id
                        and em.encounter_ide_source = encounter_map_id_source
                        and em.patient_ide_source = patient_map_id_source and em.patient_ide=patient_map_id)' using maxEncounterNum, disEncounterId;
                end if ;
                
            end if; 
    END LOOP;
    close distinctEidCur ;
    

EXECUTE 'UPDATE encounter_mapping
SET 
encounter_num = CAST(temp.encounter_id AS numeric)
,encounter_ide_status = temp.encounter_map_id_status
,patient_ide   =   temp.patient_map_id 
,patient_ide_source  =	temp.patient_map_id_source 
,update_date = temp.update_date
,download_date  = temp.download_date
,import_date = Now()
,sourcesystem_cd  = temp.sourcesystem_cd
,upload_id = ' || upload_id ||'
FROM '|| tempEidTableName || '  temp
WHERE 
temp.encounter_map_id = encounter_mapping.encounter_ide 
and temp.encounter_map_id_source = encounter_mapping.encounter_ide_source
and temp.patient_map_id = encounter_mapping.patient_ide 
and temp.patient_map_id_source = encounter_mapping.patient_ide_source
and temp.encounter_id_source = ''HIVE''
and coalesce(temp.process_status_flag::text, '''') = ''''  
and coalesce(encounter_mapping.update_date,to_date(''01-JAN-1900'',''DD-MON-YYYY'')) <= coalesce(temp.update_date,to_date(''01-JAN-1900'',''DD-MON-YYYY''))
';

    
    EXECUTE ' insert into encounter_mapping (encounter_ide,encounter_ide_source,encounter_ide_status,encounter_num,patient_ide,patient_ide_source,update_date,download_date,import_date,sourcesystem_cd,upload_id,project_id) 
    SELECT encounter_map_id,encounter_map_id_source,encounter_map_id_status,encounter_num,patient_map_id,patient_map_id_source,update_date,download_date,Now(),sourcesystem_cd,' || upload_id || ' , ''@'' project_id
    FROM ' || tempEidTableName || '  
    WHERE process_status_flag = ''P'' ' ; 
    EXCEPTION
    WHEN OTHERS THEN
        RAISE EXCEPTION 'An error was encountered - % -ERROR- %',SQLSTATE,SQLERRM;
    end;
     $_$;


ALTER FUNCTION i2b2miracum.insert_eid_map_fromtemp(tempeidtablename text, upload_id bigint, OUT errormsg text) OWNER TO i2b2miracum;

--
-- TOC entry 453 (class 1255 OID 17097)
-- Name: insert_encountervisit_fromtemp(text, bigint); Type: FUNCTION; Schema: i2b2miracum; Owner: i2b2miracum
--

CREATE FUNCTION i2b2miracum.insert_encountervisit_fromtemp(temptablename text, upload_id bigint, OUT errormsg text) RETURNS text
    LANGUAGE plpgsql
    AS $$
DECLARE

maxEncounterNum bigint; 

BEGIN 
    --Delete duplicate rows with same encounter and patient combination
    EXECUTE 'DELETE FROM ' || tempTableName || ' t1 WHERE oid > 
    (SELECT  min(oid) FROM ' || tempTableName || ' t2
        WHERE t1.encounter_id = t2.encounter_id 
        AND t1.encounter_id_source = t2.encounter_id_source
        AND coalesce(t1.patient_id,'''') = coalesce(t2.patient_id,'''')
        AND coalesce(t1.patient_id_source,'''') = coalesce(t2.patient_id_source,''''))';
    LOCK TABLE  encounter_mapping IN EXCLUSIVE MODE NOWAIT;
    -- select max(encounter_num) into maxEncounterNum from encounter_mapping ;
    --Create new patient(patient_mapping) if temp table patient_ide does not exists 
    -- in patient_mapping table.
    EXECUTE 'INSERT INTO encounter_mapping (
        encounter_ide
        , encounter_ide_source
        , encounter_num
        , patient_ide
        , patient_ide_source
        , encounter_ide_status
        , upload_id
        , project_id
    )
    (SELECT 
        distinctTemp.encounter_id
        , distinctTemp.encounter_id_source
        , CAST(distinctTemp.encounter_id AS numeric)
        , distinctTemp.patient_id
        , distinctTemp.patient_id_source
        , ''A''
        ,  '|| upload_id ||'
        , distinctTemp.project_id
        FROM 
        (SELECT 
            distinct encounter_id
            , encounter_id_source
            , patient_id
            , patient_id_source 
            , project_id
            FROM ' || tempTableName || '  temp
            WHERE 
            NOT EXISTS (SELECT encounter_ide 
                FROM encounter_mapping em 
                WHERE 
                em.encounter_ide = temp.encounter_id 
                AND em.encounter_ide_source = temp.encounter_id_source
            )
            AND encounter_id_source = ''HIVE'' 
    )   distinctTemp
) ' ;
    -- update patient_num for temp table
    EXECUTE ' UPDATE ' ||  tempTableName
    || ' SET encounter_num = (SELECT em.encounter_num
        FROM encounter_mapping em
        WHERE em.encounter_ide = '|| tempTableName ||'.encounter_id
        and em.encounter_ide_source = '|| tempTableName ||'.encounter_id_source 
        and coalesce(em.patient_ide_source,'''') = coalesce('|| tempTableName ||'.patient_id_source,'''')
        and coalesce(em.patient_ide,'''')= coalesce('|| tempTableName ||'.patient_id,'''')
    )
    WHERE EXISTS (SELECT em.encounter_num 
        FROM encounter_mapping em
        WHERE em.encounter_ide = '|| tempTableName ||'.encounter_id
        and em.encounter_ide_source = '||tempTableName||'.encounter_id_source
        and coalesce(em.patient_ide_source,'''') = coalesce('|| tempTableName ||'.patient_id_source,'''')
        and coalesce(em.patient_ide,'''')= coalesce('|| tempTableName ||'.patient_id,''''))';      

    EXECUTE ' UPDATE visit_dimension  SET  
    start_date =temp.start_date
    ,end_date=temp.end_date
    ,inout_cd=temp.inout_cd
    ,location_cd=temp.location_cd
    ,visit_blob=temp.visit_blob
    ,update_date=temp.update_date
    ,download_date=temp.download_date
    ,import_date=Now()
    ,sourcesystem_cd=temp.sourcesystem_cd
    , upload_id=' || UPLOAD_ID  || '
    FROM ' || tempTableName || '  temp       
    WHERE
    temp.encounter_num = visit_dimension.encounter_num 
    AND temp.update_date >= visit_dimension.update_date 
    AND exists (SELECT 1 
        FROM ' || tempTableName || ' temp 
        WHERE temp.encounter_num = visit_dimension.encounter_num 
        AND temp.update_date >= visit_dimension.update_date
    ) ';

    EXECUTE 'INSERT INTO visit_dimension  (encounter_num,patient_num,start_date,end_date,inout_cd,location_cd,visit_blob,update_date,download_date,import_date,sourcesystem_cd, upload_id)
    SELECT temp.encounter_num
    , pm.patient_num,
    temp.start_date,temp.end_date,temp.inout_cd,temp.location_cd,temp.visit_blob,
    temp.update_date,
    temp.download_date,
    Now(), 
    temp.sourcesystem_cd,
    '|| upload_id ||'
    FROM 
    ' || tempTableName || '  temp , patient_mapping pm 
    WHERE 
    (temp.encounter_num IS NOT NULL AND temp.encounter_num::text <> '''') and 
    NOT EXISTS (SELECT encounter_num 
        FROM visit_dimension vd 
        WHERE 
        vd.encounter_num = temp.encounter_num) 
    AND pm.patient_ide = temp.patient_id 
    AND pm.patient_ide_source = temp.patient_id_source
    ';
    EXCEPTION
    WHEN OTHERS THEN
        RAISE EXCEPTION 'An error was encountered - % -ERROR- %',SQLSTATE,SQLERRM;      
END;
$$;


ALTER FUNCTION i2b2miracum.insert_encountervisit_fromtemp(temptablename text, upload_id bigint, OUT errormsg text) OWNER TO i2b2miracum;

--
-- TOC entry 454 (class 1255 OID 17098)
-- Name: insert_modifier_fromtemp(text, bigint); Type: FUNCTION; Schema: i2b2miracum; Owner: i2b2miracum
--

CREATE FUNCTION i2b2miracum.insert_modifier_fromtemp(tempmodifiertablename text, upload_id bigint, OUT errormsg text) RETURNS text
    LANGUAGE plpgsql
    AS $$
BEGIN 
    --Delete duplicate rows 
    EXECUTE 'DELETE FROM ' || tempModifierTableName || ' t1 WHERE oid > 
    (SELECT  min(oid) FROM ' || tempModifierTableName || ' t2
        WHERE t1.modifier_cd = t2.modifier_cd 
        AND t1.modifier_path = t2.modifier_path
    )';
    EXECUTE ' UPDATE modifier_dimension  SET  
        modifier_cd=temp.modifier_cd
        ,name_char=temp.name_char
        ,modifier_blob=temp.modifier_blob
        ,update_date=temp.update_date
        ,download_date=temp.download_date
        ,import_date=Now()
        ,sourcesystem_cd=temp.SOURCESYSTEM_CD
        ,upload_id=' || UPLOAD_ID  || ' 
        FROM ' || tempModifierTableName || '  temp
        WHERE 
        temp.modifier_path = modifier_dimension.modifier_path 
        AND temp.update_date >= modifier_dimension.update_date
        AND EXISTS (SELECT 1 
            FROM ' || tempModifierTableName || ' temp  
            WHERE temp.modifier_path = modifier_dimension.modifier_path 
            AND temp.update_date >= modifier_dimension.update_date)
        ';
        --Create new modifier if temp table modifier_path does not exists 
        -- in modifier dimension table.
        EXECUTE 'INSERT INTO modifier_dimension  (
            modifier_cd
            ,modifier_path
            ,name_char
            ,modifier_blob
            ,update_date
            ,download_date
            ,import_date
            ,sourcesystem_cd
            ,upload_id
        )
        SELECT  
        modifier_cd
        ,modifier_path
        ,name_char
        ,modifier_blob
        ,update_date
        ,download_date
        ,Now()
        ,sourcesystem_cd
        ,' || upload_id || '  
        FROM
        ' || tempModifierTableName || '  temp
        WHERE NOT EXISTs (SELECT modifier_cd 
            FROM modifier_dimension cd
            WHERE cd.modifier_path = temp.modifier_path
        )
        ';
        EXCEPTION
    WHEN OTHERS THEN
        RAISE EXCEPTION 'An error was encountered - % -ERROR- %',SQLSTATE,SQLERRM;      
END;
$$;


ALTER FUNCTION i2b2miracum.insert_modifier_fromtemp(tempmodifiertablename text, upload_id bigint, OUT errormsg text) OWNER TO i2b2miracum;

--
-- TOC entry 456 (class 1255 OID 17099)
-- Name: insert_patient_fromtemp(text, bigint); Type: FUNCTION; Schema: i2b2miracum; Owner: i2b2miracum
--

CREATE FUNCTION i2b2miracum.insert_patient_fromtemp(temptablename text, upload_id bigint, OUT errormsg text) RETURNS text
    LANGUAGE plpgsql
    AS $$
DECLARE

maxPatientNum bigint; 

BEGIN 
    LOCK TABLE  patient_mapping IN EXCLUSIVE MODE NOWAIT;
    --select max(patient_num) into maxPatientNum from patient_mapping ;
    --Create new patient(patient_mapping) if temp table patient_ide does not exists 
    -- in patient_mapping table.
    EXECUTE ' INSERT INTO patient_mapping (patient_ide,patient_ide_source,patient_num,patient_ide_status, upload_id)
    (SELECT distinctTemp.patient_id, distinctTemp.patient_id_source, CAST(distinctTemp.patient_id AS numeric), ''A'',   '|| upload_id ||'
        FROM 
        (SELECT distinct patient_id, patient_id_source from ' || tempTableName || '  temp
            where  not exists (SELECT patient_ide from patient_mapping pm where pm.patient_ide = temp.patient_id and pm.patient_ide_source = temp.patient_id_source)
            and patient_id_source = ''HIVE'' )   distinctTemp) ';

    -- update patient_num for temp table
    EXECUTE ' UPDATE ' ||  tempTableName
    || ' SET patient_num = (SELECT pm.patient_num
        FROM patient_mapping pm
        WHERE pm.patient_ide = '|| tempTableName ||'.patient_id
        AND pm.patient_ide_source = '|| tempTableName ||'.patient_id_source
    )
    WHERE EXISTS (SELECT pm.patient_num 
        FROM patient_mapping pm
        WHERE pm.patient_ide = '|| tempTableName ||'.patient_id
        AND pm.patient_ide_source = '||tempTableName||'.patient_id_source)';       

    EXECUTE ' UPDATE patient_dimension  SET  
    vital_status_cd = temp.vital_status_cd
    , birth_date = temp.birth_date
    , death_date = temp.death_date
    , sex_cd = temp.sex_cd
    , age_in_years_num = temp.age_in_years_num
    , language_cd = temp.language_cd
    , race_cd = temp.race_cd
    , marital_status_cd = temp.marital_status_cd
    , religion_cd = temp.religion_cd
    , zip_cd = temp.zip_cd
    , statecityzip_path = temp.statecityzip_path
    , patient_blob = temp.patient_blob
    , update_date = temp.update_date
    , download_date = temp.download_date
    , import_date = Now()
    , sourcesystem_cd = temp.sourcesystem_cd 
    , upload_id =  ' || UPLOAD_ID  || '
    FROM  ' || tempTableName || '  temp
    WHERE 
    temp.patient_num = patient_dimension.patient_num 
    AND temp.update_date >= patient_dimension.update_date
    AND EXISTS (select 1 
        FROM ' || tempTableName || ' temp  
        WHERE 
        temp.patient_num = patient_dimension.patient_num 
        AND temp.update_date >= patient_dimension.update_date
    )    ';

    --Create new patient(patient_dimension) for above inserted patient's.
    --If patient_dimension table's patient num does match temp table,
    --then new patient_dimension information is inserted.
    EXECUTE 'INSERT INTO patient_dimension  (patient_num,vital_status_cd, birth_date, death_date,
        sex_cd, age_in_years_num,language_cd,race_cd,marital_status_cd, religion_cd,
        zip_cd,statecityzip_path,patient_blob,update_date,download_date,import_date,sourcesystem_cd,
        upload_id)
    SELECT temp.patient_num,
    temp.vital_status_cd, temp.birth_date, temp.death_date,
    temp.sex_cd, temp.age_in_years_num,temp.language_cd,temp.race_cd,temp.marital_status_cd, temp.religion_cd,
    temp.zip_cd,temp.statecityzip_path,temp.patient_blob,
    temp.update_date,
    temp.download_date,
    Now(),
    temp.sourcesystem_cd,
    '|| upload_id ||'
    FROM 
    ' || tempTableName || '  temp 
    WHERE 
    NOT EXISTS (SELECT patient_num 
        FROM patient_dimension pd 
        WHERE pd.patient_num = temp.patient_num) 
    AND 
    (patient_num IS NOT NULL AND patient_num::text <> '''')
    ';
    EXCEPTION WHEN OTHERS THEN
        RAISE EXCEPTION 'An error was encountered - % -ERROR- %',SQLSTATE,SQLERRM;

END;
$$;


ALTER FUNCTION i2b2miracum.insert_patient_fromtemp(temptablename text, upload_id bigint, OUT errormsg text) OWNER TO i2b2miracum;

--
-- TOC entry 457 (class 1255 OID 17100)
-- Name: insert_patient_map_fromtemp(text, bigint); Type: FUNCTION; Schema: i2b2miracum; Owner: i2b2miracum
--

CREATE FUNCTION i2b2miracum.insert_patient_map_fromtemp(temppatienttablename text, upload_id bigint, OUT errormsg text) RETURNS text
    LANGUAGE plpgsql
    AS $$
BEGIN 
        --Create new patient mapping entry for HIVE patient's if they are not already mapped in mapping table
        EXECUTE 'insert into patient_mapping (
                PERFORM distinct temp.patient_id, temp.patient_id_source,''A'',temp.patient_id ,' || upload_id || '
                from ' || tempPatientTableName ||'  temp 
                where temp.patient_id_source = ''HIVE'' and 
                not exists (select patient_ide from patient_mapping pm where pm.patient_num = temp.patient_id and pm.patient_ide_source = temp.patient_id_source) 
                )'; 
    --Create new visit for above inserted encounter's
        --If Visit table's encounter and patient num does match temp table,
        --then new visit information is created.
        EXECUTE 'MERGE  INTO patient_dimension pd
                   USING ( select case when (ptemp.patient_id_source=''HIVE'') then  cast(ptemp.patient_id as int)
                                       else pmap.patient_num end patient_num,
                                  ptemp.VITAL_STATUS_CD, 
                                  ptemp.BIRTH_DATE,
                                  ptemp.DEATH_DATE, 
                                  ptemp.SEX_CD ,
                                  ptemp.AGE_IN_YEARS_NUM,
                                  ptemp.LANGUAGE_CD,
                                  ptemp.RACE_CD,
                                  ptemp.MARITAL_STATUS_CD,
                                  ptemp.RELIGION_CD,
                                  ptemp.ZIP_CD,
                                                                  ptemp.STATECITYZIP_PATH , 
                                                                  ptemp.PATIENT_BLOB, 
                                                                  ptemp.UPDATE_DATE, 
                                                                  ptemp.DOWNLOAD_DATE, 
                                                                  ptemp.IMPORT_DATE, 
                                                                  ptemp.SOURCESYSTEM_CD
                   from ' || tempPatientTableName || '  ptemp , patient_mapping pmap
                   where   ptemp.patient_id = pmap.patient_ide(+)
                   and ptemp.patient_id_source = pmap.patient_ide_source(+)
           ) temp
                   on (
                                pd.patient_num = temp.patient_num
                    )    
                        when matched then 
                                update  set 
                                        pd.VITAL_STATUS_CD= temp.VITAL_STATUS_CD,
                    pd.BIRTH_DATE= temp.BIRTH_DATE,
                    pd.DEATH_DATE= temp.DEATH_DATE,
                    pd.SEX_CD= temp.SEX_CD,
                    pd.AGE_IN_YEARS_NUM=temp.AGE_IN_YEARS_NUM,
                    pd.LANGUAGE_CD=temp.LANGUAGE_CD,
                    pd.RACE_CD=temp.RACE_CD,
                    pd.MARITAL_STATUS_CD=temp.MARITAL_STATUS_CD,
                    pd.RELIGION_CD=temp.RELIGION_CD,
                    pd.ZIP_CD=temp.ZIP_CD,
                                        pd.STATECITYZIP_PATH =temp.STATECITYZIP_PATH,
                                        pd.PATIENT_BLOB=temp.PATIENT_BLOB,
                                        pd.UPDATE_DATE=temp.UPDATE_DATE,
                                        pd.DOWNLOAD_DATE=temp.DOWNLOAD_DATE,
                                        pd.SOURCESYSTEM_CD=temp.SOURCESYSTEM_CD,
                                        pd.UPLOAD_ID = '||upload_id||'
                    where temp.update_date > pd.update_date
                         when not matched then 
                                insert (
                                        PATIENT_NUM,
                                        VITAL_STATUS_CD,
                    BIRTH_DATE,
                    DEATH_DATE,
                    SEX_CD,
                    AGE_IN_YEARS_NUM,
                    LANGUAGE_CD,
                    RACE_CD,
                    MARITAL_STATUS_CD,
                    RELIGION_CD,
                    ZIP_CD,
                                        STATECITYZIP_PATH,
                                        PATIENT_BLOB,
                                        UPDATE_DATE,
                                        DOWNLOAD_DATE,
                                        SOURCESYSTEM_CD,
                                        import_date,
                        upload_id
                                        ) 
                                values (
                                        temp.PATIENT_NUM,
                                        temp.VITAL_STATUS_CD,
                    temp.BIRTH_DATE,
                    temp.DEATH_DATE,
                    temp.SEX_CD,
                    temp.AGE_IN_YEARS_NUM,
                    temp.LANGUAGE_CD,
                    temp.RACE_CD,
                    temp.MARITAL_STATUS_CD,
                    temp.RELIGION_CD,
                    temp.ZIP_CD,
                                        temp.STATECITYZIP_PATH,
                                        temp.PATIENT_BLOB,
                                        temp.UPDATE_DATE,
                                        temp.DOWNLOAD_DATE,
                                        temp.SOURCESYSTEM_CD,
                                        LOCALTIMESTAMP,
                                '||upload_id||'
                                )';
EXCEPTION
        WHEN OTHERS THEN
                RAISE EXCEPTION 'An error was encountered - % -ERROR- %',SQLSTATE,SQLERRM;      
END;
$$;


ALTER FUNCTION i2b2miracum.insert_patient_map_fromtemp(temppatienttablename text, upload_id bigint, OUT errormsg text) OWNER TO i2b2miracum;

--
-- TOC entry 458 (class 1255 OID 17101)
-- Name: insert_pid_map_fromtemp(text, bigint); Type: FUNCTION; Schema: i2b2miracum; Owner: i2b2miracum
--

CREATE FUNCTION i2b2miracum.insert_pid_map_fromtemp(temppidtablename text, upload_id bigint, OUT errormsg text) RETURNS text
    LANGUAGE plpgsql
    AS $_$
DECLARE
existingPatientNum varchar(32);
maxPatientNum bigint;
distinctPidCur REFCURSOR;
disPatientId varchar(100); 
disPatientIdSource varchar(100);
BEGIN
	--delete the doublons
	EXECUTE ' delete  from ' || tempPidTableName ||  ' t1  where 
	oid > (select min(oid) from ' || tempPidTableName || ' t2 
		where t1.patient_map_id = t2.patient_map_id
		and t1.patient_map_id_source = t2.patient_map_id_source) ';
	LOCK TABLE  patient_mapping IN EXCLUSIVE MODE NOWAIT;
	select max(patient_num) into STRICT  maxPatientNum from patient_mapping ; 
	-- set max patient num to zero of the value is null
	if coalesce(maxPatientNum::text, '') = '' then 
		maxPatientNum := 0;
	end if;
	open distinctPidCur for EXECUTE 'SELECT distinct patient_id,patient_id_source from ' || tempPidTableName || '' ;
	loop
		FETCH distinctPidCur INTO disPatientId, disPatientIdSource;
		IF NOT FOUND THEN EXIT; 
	END IF; -- apply on distinctPidCur
	-- dbms_output.put_line(disPatientId);
	if  disPatientIdSource = 'HIVE'  THEN 
		begin
			--check if hive number exist, if so assign that number to reset of map_id's within that pid
			select patient_num into existingPatientNum from patient_mapping where patient_num = CAST(disPatientId AS numeric) and patient_ide_source = 'HIVE';
			EXCEPTION  when NO_DATA_FOUND THEN
				existingPatientNum := null;
		end;
		if (existingPatientNum IS NOT NULL AND existingPatientNum::text <> '') then 
			EXECUTE ' update ' || tempPidTableName ||' set patient_num = CAST(patient_id AS numeric), process_status_flag = ''P''
			where patient_id = $1 and not exists (select 1 from patient_mapping pm where pm.patient_ide = patient_map_id
				and pm.patient_ide_source = patient_map_id_source)' using disPatientId;
		else 
			-- generate new patient_num i.e. take max(patient_num) + 1 
			if maxPatientNum < CAST(disPatientId AS numeric) then 
				maxPatientNum := disPatientId;
			end if ;
			EXECUTE ' update ' || tempPidTableName ||' set patient_num = CAST(patient_id AS numeric), process_status_flag = ''P'' where 
			patient_id = $1 and patient_id_source = ''HIVE'' and not exists (select 1 from patient_mapping pm where pm.patient_ide = patient_map_id
				and pm.patient_ide_source = patient_map_id_source)' using disPatientId;
		end if;    
		-- test if record fectched
		-- dbms_output.put_line(' HIVE ');
	else 
		begin
			select patient_num into STRICT  existingPatientNum from patient_mapping where patient_ide = disPatientId and 
			patient_ide_source = disPatientIdSource ; 
			-- test if record fetched. 
			EXCEPTION
	WHEN NO_DATA_FOUND THEN
		existingPatientNum := null;
		end;
		if (existingPatientNum IS NOT NULL AND existingPatientNum::text <> '') then 
			EXECUTE ' update ' || tempPidTableName ||' set patient_num = CAST($1 AS numeric) , process_status_flag = ''P''
			where patient_id = $2 and not exists (select 1 from patient_mapping pm where pm.patient_ide = patient_map_id
				and pm.patient_ide_source = patient_map_id_source)' using  existingPatientNum,disPatientId;
		else 
			maxPatientNum := maxPatientNum + 1 ; 
			EXECUTE 'insert into ' || tempPidTableName ||' (
				patient_map_id
				,patient_map_id_source
				,patient_id
				,patient_id_source
				,patient_num
				,process_status_flag
				,patient_map_id_status
				,update_date
				,download_date
				,import_date
				,sourcesystem_cd) 
			values(
				$1
				,''HIVE''
				,$2
				,''HIVE''
				,$3
				,''P''
				,''A''
				,Now()
				,Now()
				,Now()
				,''edu.harvard.i2b2.crc''
			)' using maxPatientNum,maxPatientNum,maxPatientNum; 
			EXECUTE 'update ' || tempPidTableName ||' set patient_num =  $1 , process_status_flag = ''P'' 
			where patient_id = $2 and  not exists (select 1 from 
				patient_mapping pm where pm.patient_ide = patient_map_id
				and pm.patient_ide_source = patient_map_id_source)' using maxPatientNum, disPatientId  ;
		end if ;
		-- dbms_output.put_line(' NOT HIVE ');
	end if; 
	END LOOP;
	close distinctPidCur ;
	-- do the mapping update if the update date is old
EXECUTE ' UPDATE patient_mapping
SET 
patient_num = CAST(temp.patient_id AS numeric)
,patient_ide_status = temp.patient_map_id_status
,update_date = temp.update_date
,download_date  = temp.download_date
,import_date = Now()
,sourcesystem_cd  = temp.sourcesystem_cd
,upload_id = ' || upload_id ||'
FROM '|| tempPidTableName || '  temp
WHERE 
temp.patient_map_id = patient_mapping.patient_ide 
and temp.patient_map_id_source = patient_mapping.patient_ide_source
and temp.patient_id_source = ''HIVE''
and coalesce(temp.process_status_flag::text, '''') = ''''  
and coalesce(patient_mapping.update_date,to_date(''01-JAN-1900'',''DD-MON-YYYY'')) <= coalesce(temp.update_date,to_date(''01-JAN-1900'',''DD-MON-YYYY''))
';
	-- insert new mapping records i.e flagged P
	EXECUTE ' insert into patient_mapping (patient_ide,patient_ide_source,patient_ide_status,patient_num,update_date,download_date,import_date,sourcesystem_cd,upload_id,project_id)
	SELECT patient_map_id,patient_map_id_source,patient_map_id_status,patient_num,update_date,download_date,Now(),sourcesystem_cd,' || upload_id ||', ''@'' project_id from '|| tempPidTableName || ' 
	where process_status_flag = ''P'' ' ; 
	EXCEPTION WHEN OTHERS THEN
		RAISE EXCEPTION 'An error was encountered - % -ERROR- %',SQLSTATE,SQLERRM;
	END;
	$_$;


ALTER FUNCTION i2b2miracum.insert_pid_map_fromtemp(temppidtablename text, upload_id bigint, OUT errormsg text) OWNER TO i2b2miracum;

--
-- TOC entry 440 (class 1255 OID 17104)
-- Name: insert_provider_fromtemp(text, bigint); Type: FUNCTION; Schema: i2b2miracum; Owner: i2b2miracum
--

CREATE FUNCTION i2b2miracum.insert_provider_fromtemp(tempprovidertablename text, upload_id bigint, OUT errormsg text) RETURNS text
    LANGUAGE plpgsql
    AS $$
BEGIN 
    --Delete duplicate rows with same encounter and patient combination
    EXECUTE 'DELETE FROM ' || tempProviderTableName || ' t1 WHERE oid > 
    (SELECT  min(oid) FROM ' || tempProviderTableName || ' t2
        WHERE t1.provider_id = t2.provider_id 
        AND t1.provider_path = t2.provider_path
    )';
    EXECUTE ' UPDATE provider_dimension  SET  
        provider_id =temp.provider_id
        , name_char = temp.name_char
        , provider_blob = temp.provider_blob
        , update_date=temp.update_date
        , download_date=temp.download_date
        , import_date=Now()
        , sourcesystem_cd=temp.sourcesystem_cd
        , upload_id = ' || upload_id || '
        FROM ' || tempProviderTableName || '  temp 
        WHERE 
        temp.provider_path = provider_dimension.provider_path and temp.update_date >= provider_dimension.update_date 
    AND EXISTS (select 1 from ' || tempProviderTableName || ' temp  where temp.provider_path = provider_dimension.provider_path 
        and temp.update_date >= provider_dimension.update_date) ';

    --Create new patient(patient_mapping) if temp table patient_ide does not exists 
    -- in patient_mapping table.
    EXECUTE 'insert into provider_dimension  (provider_id,provider_path,name_char,provider_blob,update_date,download_date,import_date,sourcesystem_cd,upload_id)
    SELECT  provider_id,provider_path, 
    name_char,provider_blob,
    update_date,download_date,
    Now(),sourcesystem_cd, ' || upload_id || '
    FROM ' || tempProviderTableName || '  temp
    WHERE NOT EXISTS (SELECT provider_id 
        FROM provider_dimension pd 
        WHERE pd.provider_path = temp.provider_path 
    )';
    EXCEPTION
    WHEN OTHERS THEN
        RAISE EXCEPTION 'An error was encountered - % -ERROR- %',SQLSTATE,SQLERRM;      
END;
$$;


ALTER FUNCTION i2b2miracum.insert_provider_fromtemp(tempprovidertablename text, upload_id bigint, OUT errormsg text) OWNER TO i2b2miracum;

--
-- TOC entry 447 (class 1255 OID 17421)
-- Name: pat_count_dimensions(character varying, character varying, character varying, character varying, character varying, character varying); Type: FUNCTION; Schema: i2b2miracum; Owner: i2b2miracum
--

CREATE FUNCTION i2b2miracum.pat_count_dimensions(metadatatable character varying, schemaname character varying, observationtable character varying, facttablecolumn character varying, tablename character varying, columnname character varying) RETURNS void
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
declare 
        -- select PAT_COUNT_DIMENSIONS( 'I2B2' ,'public' , 'observation_fact' ,  'concept_cd', 'concept_dimension', 'concept_path'  )
    v_sqlstr text;
    v_num integer;
    curRecord RECORD;
    v_startime timestamp;
    v_duration text = '';
BEGIN
    raise info 'At %, running PAT_COUNT_DIMENSIONS(''%'')',clock_timestamp(), metadataTable;
    v_startime := clock_timestamp();

    DISCARD TEMP;
    -- Modify this query to select a list of all your ontology paths and basecodes.

    v_sqlstr := 'create temp table dimCountOnt AS '
             || ' select c_fullname, c_basecode, c_hlevel '
             || ' from ' || metadataTable  
             || ' where lower(c_facttablecolumn) = '''||facttablecolumn||''' '
             || ' and lower(c_tablename) = '''|| tablename || ''' '
             || ' and lower(c_columnname) = '''|| columnname || ''' '
             || ' and lower(c_synonym_cd) = ''n'' '
             || ' and lower(c_columndatatype) = ''t'' '
             || ' and lower(c_operator) = ''like'' '
             || ' and m_applied_path = ''@'' '
		     || ' and coalesce(c_fullname, '''') <> '''' '
		     || ' and (c_visualattributes not like ''L%'' or  c_basecode in (select distinct concept_cd from observation_fact)) ';
		-- NEW: Sparsify the working ontology by eliminating leaves with no data. HUGE win in ACT meds ontology (10x speedup).
        -- From 1.47M entries to 300k entries!
           
    raise info 'SQL: %',v_sqlstr;
    execute v_sqlstr;

    create index dimCountOntA on dimCountOnt using spgist (c_fullname);
    CREATE INDEX dimCountOntB ON dimCountOnt(c_fullname text_pattern_ops);

    create temp table dimOntWithFolders AS
        select distinct p1.c_fullname, p1.c_basecode
        from dimCountOnt p1
        where 1=0;
        
    CREATE INDEX dimOntWithFoldersIndex ON dimOntWithFolders using btree(c_basecode);


For curRecord IN 
		select c_fullname,c_table_name from table_access 
    LOOP 
if metadataTable = curRecord.c_table_name then
--v_sqlstr := 'insert into dimOntWithFolders select distinct  c_fullname , c_basecode  from  provider_ont where c_fullname like ''' || replace(curRecord.c_fullname,'\','\\') || '%'' ';

--v_sqlstr := 'insert into dimOntWithFolders '
--       || '   select distinct p1.c_fullname, p2.c_basecode '
--       || '   from dimCountOnt p1 '
--       || '   inner join dimCountOnt p2 '
--       || '     on p2.c_fullname like p1.c_fullname || ''%''  '
--       || '     where p2.c_fullname like  ''' || replace(curRecord.c_fullname,'\','\\') || '%'' '
--       || '       and p1.c_fullname like  ''' || replace(curRecord.c_fullname,'\','\\') || '%'' ';


-- Jeff Green's version
v_sqlstr := 'with recursive concepts (c_fullname, c_hlevel, c_basecode) as ('
	|| ' select c_fullname, c_hlevel, c_basecode '
	|| '  from dimCountOnt '
	|| '  where c_fullname like ''' || replace(curRecord.c_fullname,'\','\\') || '%'' '
	|| ' union all ' 
	|| ' select cast( '
	|| '  	left(c_fullname, length(c_fullname)-position(''\'' in right(reverse(c_fullname), length(c_fullname)-1))) '
	|| '	   	as varchar(700) '
	|| '	) c_fullname, ' 
	|| ' c_hlevel-1 c_hlevel, c_basecode '
	|| ' from concepts '
	|| ' where concepts.c_hlevel>0 '
	|| ' ) '
|| ' insert into dimOntWithFolders '
|| ' select distinct c_fullname, c_basecode '
|| '  from concepts '
|| '  where c_fullname like ''' || replace(curRecord.c_fullname,'\','\\') || '%'' '
|| '  order by c_fullname, c_basecode ';

    raise info 'SQL_dimOntWithFolders: %',v_sqlstr;
	execute v_sqlstr;

	--raise notice 'At %, collected concepts for % %',clock_timestamp(),curRecord.c_table_name,curRecord.c_fullname;
	v_duration := clock_timestamp()-v_startime;
	raise info '(BENCH) %,collected_concepts,%',curRecord,v_duration;
	v_startime := clock_timestamp();

 end if;

    END LOOP;

    -- Too slow version
    --v_sqlstr := ' create temp table finalDimCounts AS '
    --    || ' select p1.c_fullname, count(distinct patient_num) as num_patients '
    --    || ' from dimOntWithFolders p1 '
    --    || ' left join ' || schemaName ||'.'|| observationtable ||  '  o '
    --    || '     on p1.c_basecode = o.' || facttablecolumn  --provider id
    --    || '     and coalesce(p1.c_basecode, '''') <> '''' '
    --    || ' group by p1.c_fullname';
    
    -- 10-20x faster version (based on MSSQL optimizations) 
    
    -- Assign a number to each path and use this for the join to the fact table!
    create temp table Path2Num as
    select c_fullname, row_number() over (order by c_fullname) path_num
        from (
            select distinct c_fullname c_fullname
            from dimOntWithFolders
            where c_fullname is not null and c_fullname<>''
        ) t;
    
    alter table Path2Num add primary key (c_fullname);
    
    create temp table ConceptPath as
    select path_num,c_basecode from Path2Num n inner join dimontwithfolders o on o.c_fullname=n.c_fullname
    where o.c_fullname is not null and c_basecode is not null;
    
    alter table ConceptPath add primary key (c_basecode, path_num);
    
    create temp table PathCounts as
    select p1.path_num, count(distinct patient_num) as num_patients  from ConceptPath p1  left join public.observation_fact  o      on p1.c_basecode = o.concept_cd     and coalesce(p1.c_basecode, '') <> ''  group by p1.path_num;
    
    alter table PathCounts add primary key (path_num);
    
    create temp table finalCountsbyConcept as
    select p.c_fullname, c.num_patients num_patients 
        from PathCounts c
          inner join Path2Num p
           on p.path_num=c.path_num
        order by p.c_fullname;


    --raise notice 'At %, done counting.',clock_timestamp();
	v_duration := clock_timestamp()-v_startime;
	raise info '(BENCH) %,counted_concepts,%',curRecord,v_duration;
	v_startime := clock_timestamp();

    create index on finalCountsbyConcept using btree (c_fullname);

    v_sqlstr := ' update ' || metadataTable || ' a set c_totalnum=b.num_patients '
             || ' from finalCountsbyConcept b '
             || ' where a.c_fullname=b.c_fullname '
            || ' and lower(a.c_facttablecolumn)= ''' || facttablecolumn || ''' '
		    || ' and lower(a.c_tablename) = ''' || tablename || ''' '
		    || ' and lower(a.c_columnname) = ''' || columnname || ''' ';
    select count(*) into v_num from finalCountsByConcept where num_patients is not null and num_patients <> 0;
    raise info 'At %, updating c_totalnum in % %',clock_timestamp(), metadataTable, v_num;
    
	execute v_sqlstr;

    discard temp;
END; 
$$;


ALTER FUNCTION i2b2miracum.pat_count_dimensions(metadatatable character varying, schemaname character varying, observationtable character varying, facttablecolumn character varying, tablename character varying, columnname character varying) OWNER TO i2b2miracum;

--
-- TOC entry 448 (class 1255 OID 17424)
-- Name: pat_count_visits(character varying, character varying); Type: FUNCTION; Schema: i2b2miracum; Owner: i2b2miracum
--

CREATE FUNCTION i2b2miracum.pat_count_visits(tabname character varying, tableschema character varying) RETURNS void
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
declare 
    v_sqlstr text;
    -- using cursor defined withing FOR RECORD IN QUERY loop below.
    curRecord RECORD;
    v_num integer;
BEGIN
    --display count and timing information to the user
  
    --using all temporary tables instead of creating and dropping tables
    DISCARD TEMP;
    --checking each text fields for forced lowercase values since DB defaults to case sensitive 
	v_sqlstr = 'create temp table ontPatVisitDims as '
          ||    ' select c_fullname'
          ||          ', c_basecode'
          ||          ', c_facttablecolumn'
          ||          ', c_tablename'
          ||          ', c_columnname'
          ||          ', c_operator'
          ||          ', c_dimcode'
          ||          ', null::integer as numpats'
          ||      ' from ' || tabname
          ||      ' where  m_applied_path = ''@'''
          ||        ' and lower(c_tablename) in (''patient_dimension'', ''visit_dimension'') ';

    /*
     * THE ORIGINAL WUSM implementation did not have the column "visit_dimension.location_zip" in 
     *     ||        ' and lower(c_columnname) not in (''location_zip'') '; --ignoring this often occuring column that we know is not in WUSM schema
     */

    execute v_sqlstr;

    -- rather than creating cursor and fetching rows into local variables, instead using record variable type to 
    -- access each element of the current row of the cursor
	For curRecord IN 
		select c_fullname, c_facttablecolumn, c_tablename, c_columnname, c_operator, c_dimcode from ontPatVisitDims
    LOOP 
 --raise info 'At %: Running: %',curRecord.c_tablename, curRecord.c_columnname;
        -- check first to determine if current columns of current table actually exist in the schema
   --     if exists(select 1 from information_schema.columns 
   --               where table_catalog = current_catalog 
   --                 and table_schema = ' || tableschema || '
   --                 and table_name = lower(curRecord.c_tablename)
   --                 and column_name = lower(curRecord.c_columnname)
   --              ) then 

            -- simplified query to directly query distinct patient_num instead of querying list of patien_num to feed into outer query for the same
            -- result.  New style runs in approximately half the time as tested with all patients with a particular sex_cd value.  Since all rows 
            -- Since c_facttablecolumn is ALWAYS populated with 'patient_num' for all rows accessed by this function the change to the function is 
            -- worthwhile.  Only in rare cases if changes to the ontology tables are made would the original query be needed, but only where 
            -- c_facttablecolumn would not be 'patient_num AND the values saved in that column in the dimension table are shared between patients that 
            -- don't otherwise have the same ontology would the original method return different results.  It is believed that those results would be 
            -- inaccurate since they would reflect the number of patients who have XXX like patients with this ontology rather than the number of patients
            -- with that ontology. 
            v_sqlstr := 'update ontPatVisitDims '
                     || ' set numpats =  ( '                     
                     ||     ' select count(distinct(patient_num)) '
                     ||     ' from ' || tableschema || '.' || curRecord.c_tablename 
                     --||     ' where ' || curRecord.c_facttablecolumn
                     --||     ' in ( '
                     --||         ' select ' || curRecord.c_facttablecolumn 
                     --||         ' from ' || tableschema || '.' || curRecord.c_tablename 
                     ||         ' where '|| curRecord.c_columnname || ' '  ;
--Running: update ontPatVisitDims  set numpats =  (  select count(distinct(patient_num))  from public.PATIENT_DIMENSION where RACE_CD = es ) 
            CASE 
            WHEN lower(curRecord.c_columnname) = 'birth_date' 
                 and lower(curRecord.c_tablename) = 'patient_dimension'
                 and lower(curRecord.c_dimcode) like '%not recorded%' then 
                    -- adding specific change of " WHERE patient_dimension.birth_date in ('not_recorded') " to " WHERE patient_dimension.birth_date IS NULL " 
                    -- since IS NULL syntax is not supported in the ontology tables, but the birth_date column is a timestamp datatype and can be null, but cannot be
                    -- the character string 'not recorded'
                    v_sqlstr := v_sqlstr || ' is null';
            WHEN lower(curRecord.c_operator) = 'like' then 
                -- escaping escape characters and double quotes.  The additon of '\' to '\\' is needed in Postgres. Alternatively, a custom escape character
                -- could be listed in the query if it is known for certain that that character will never be found in any c_dimcode value accessed by this 
                -- function
                v_sqlstr := v_sqlstr || curRecord.c_operator  || ' ' || '''' || replace(replace(curRecord.c_dimcode,'\','\\'),'''','''''') || '%''' ;
           WHEN lower(curRecord.c_operator) = 'in' then 
                v_sqlstr := v_sqlstr || curRecord.c_operator  || ' ' ||  '(' || curRecord.c_dimcode || ')';
            WHEN lower(curRecord.c_operator) = '=' then 
           --     v_sqlstr := v_sqlstr || curRecord.c_operator  || ' ' ||  replace(curRecord.c_dimcode,'''','''''') ;
                v_sqlstr := v_sqlstr || curRecord.c_operator  || ' ''' ||  replace(curRecord.c_dimcode,'''','''''') || '''';
            ELSE 
                -- A mistake in WUSM data existed, requiring special handling in this function.  
                -- The original note is listed next for reference purposes only and the IF THEN 
                -- ELSE block that was needed has been commented out since the original mistake 
                -- in the ontology tables has been corrected.

                /* ORIGINAL NOTE AND CODE
                 *   -- a mistake in WUSM data has this c_dimcode incorrectly listed.  It is being handled in this function until other testing and approvals
                 *   -- are conducted to allow for the correction of this value in the ontology table.
                 *   if curRecord.c_dimcode = 'current_date - interval ''85 year''85 year''' then 
                 *       v_sqlstr := v_sqlstr || curRecord.c_operator  || ' ' || 'current_date - interval ''85 year''';
                 *   else
                 */
                        v_sqlstr := v_sqlstr || curRecord.c_operator  || ' ' || curRecord.c_dimcode;
                /* 
                 *   end if;
                 */
            END CASE;
            
            v_sqlstr := v_sqlstr -- || ' ) ' -- in
                     || ' ) ' -- set
                     || ' where c_fullname = ' || '''' || curRecord.c_fullname || '''' 
                     || ' and numpats is null';

    
			begin
            	execute v_sqlstr;
			EXCEPTION WHEN OTHERS THEN
				raise info 'At %: EROR: %',clock_timestamp()e, v_sqlstr;
		      -- keep looping
   			END;
		--else
            -- do nothing since we do not have the column in our schema
     --   end if;
    END LOOP;

	v_sqlstr := 'update ' || tabname || ' a set c_totalnum=b.numpats '
             || ' from ontPatVisitDims b '
             || ' where a.c_fullname=b.c_fullname ';

    raise info 'At %: Running: %',clock_timestamp()e, v_sqlstr;
 
    --display count and timing information to the user
    select count(*) into v_num from ontPatVisitDims where numpats is not null and numpats <> 0;
    raise info 'At %, updating c_totalnum in % for % records',clock_timestamp(), tabname, v_num;
             
	execute v_sqlstr;
    discard temp;
END;
$$;


ALTER FUNCTION i2b2miracum.pat_count_visits(tabname character varying, tableschema character varying) OWNER TO i2b2miracum;

--
-- TOC entry 441 (class 1255 OID 17105)
-- Name: remove_temp_table(character varying); Type: FUNCTION; Schema: i2b2miracum; Owner: i2b2miracum
--

CREATE FUNCTION i2b2miracum.remove_temp_table(temptablename character varying, OUT errormsg text) RETURNS text
    LANGUAGE plpgsql
    AS $$

DECLARE

BEGIN
    EXECUTE 'DROP TABLE ' || tempTableName|| ' CASCADE ';

EXCEPTION 
WHEN OTHERS THEN
    RAISE EXCEPTION 'An error was encountered - % -ERROR- %',SQLSTATE,SQLERRM;      
END;
$$;


ALTER FUNCTION i2b2miracum.remove_temp_table(temptablename character varying, OUT errormsg text) OWNER TO i2b2miracum;

--
-- TOC entry 449 (class 1255 OID 17427)
-- Name: runtotalnum(text, text); Type: FUNCTION; Schema: i2b2miracum; Owner: i2b2miracum
--

CREATE FUNCTION i2b2miracum.runtotalnum(observationtable text, schemaname text) RETURNS void
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
DECLARE 
    curRecord RECORD;
    v_sqlstring text = '';
    v_union text = '';
    v_numpats integer;
    v_startime timestamp;
    v_duration text = '';
begin
    raise info 'At %, running RunTotalnum()',clock_timestamp();
    v_startime := clock_timestamp();

    for curRecord IN 
        select distinct c_table_name as sqltext
        from TABLE_ACCESS 
        where c_visualattributes like '%A%' 
    LOOP 
        raise info 'At %: Running: %',clock_timestamp(), curRecord.sqltext;

        v_sqlstring := 'select  PAT_COUNT_VISITS( '''||curRecord.sqltext||''' ,'''||schemaName||'''   )';
		execute v_sqlstring;
		v_duration := clock_timestamp()-v_startime;
		raise info '(BENCH) %,PAT_COUNT_VISITS,%',curRecord,v_duration;
		v_startime := clock_timestamp();
		
        v_sqlstring := 'select PAT_COUNT_DIMENSIONS( '''||curRecord.sqltext||''' ,'''||schemaName||''' , '''||observationTable||''' ,  ''concept_cd'', ''concept_dimension'', ''concept_path''  )';
		execute v_sqlstring;
        v_duration :=  clock_timestamp()-v_startime;
		raise info '(BENCH) %,PAT_COUNT_concept_dimension,%',curRecord,v_duration;
		v_startime := clock_timestamp();
        
        v_sqlstring := 'select PAT_COUNT_DIMENSIONS( '''||curRecord.sqltext||''' ,'''||schemaName||''' , '''||observationTable||''' ,  ''provider_id'', ''provider_dimension'', ''provider_path''  )';
		execute v_sqlstring;
		v_duration := clock_timestamp()-v_startime;
		raise info '(BENCH) %,PAT_COUNT_provider_dimension,%',curRecord,v_duration;
		v_startime := clock_timestamp();
		
        v_sqlstring := 'select PAT_COUNT_DIMENSIONS( '''||curRecord.sqltext||''' ,'''||schemaName||''' , '''||observationTable||''' ,  ''modifier_cd'', ''modifier_dimension'', ''modifier_path''  )';
		execute v_sqlstring;
		v_duration := clock_timestamp()-v_startime;
		raise info '(BENCH) %,PAT_COUNT_modifier_dimension,%',curRecord,v_duration;
		v_startime := clock_timestamp();

    END LOOP;
end; 
$$;


ALTER FUNCTION i2b2miracum.runtotalnum(observationtable text, schemaname text) OWNER TO i2b2miracum;

--
-- TOC entry 442 (class 1255 OID 17106)
-- Name: sync_clear_concept_table(text, text, bigint); Type: FUNCTION; Schema: i2b2miracum; Owner: i2b2miracum
--

CREATE FUNCTION i2b2miracum.sync_clear_concept_table(tempconcepttablename text, backupconcepttablename text, uploadid bigint, OUT errormsg text) RETURNS text
    LANGUAGE plpgsql
    AS $$
DECLARE
 
interConceptTableName  varchar(400);

BEGIN 
        interConceptTableName := backupConceptTableName || '_inter';
                --Delete duplicate rows with same encounter and patient combination
        EXECUTE 'DELETE FROM ' || tempConceptTableName || ' t1 WHERE oid > 
                                           (SELECT  min(oid) FROM ' || tempConceptTableName || ' t2
                                             WHERE t1.concept_cd = t2.concept_cd 
                                            AND t1.concept_path = t2.concept_path
                                            )';
    EXECUTE 'create table ' ||  interConceptTableName || ' (
    CONCEPT_CD          varchar(50) NOT NULL,
        CONCEPT_PATH            varchar(700) NOT NULL,
        NAME_CHAR               varchar(2000) NULL,
        CONCEPT_BLOB        text NULL,
        UPDATE_DATE         timestamp NULL,
        DOWNLOAD_DATE       timestamp NULL,
        IMPORT_DATE         timestamp NULL,
        SOURCESYSTEM_CD     varchar(50) NULL,
        UPLOAD_ID               numeric(38,0) NULL,
    CONSTRAINT '|| interConceptTableName ||'_pk  PRIMARY KEY(CONCEPT_PATH)
         )';
    --Create new patient(patient_mapping) if temp table patient_ide does not exists 
        -- in patient_mapping table.
        EXECUTE 'insert into '|| interConceptTableName ||'  (concept_cd,concept_path,name_char,concept_blob,update_date,download_date,import_date,sourcesystem_cd,upload_id)
                            PERFORM  concept_cd, substring(concept_path from 1 for 700),
                        name_char,concept_blob,
                        update_date,download_date,
                        LOCALTIMESTAMP,sourcesystem_cd,
                         ' || uploadId || '  from ' || tempConceptTableName || '  temp ';
        --backup the concept_dimension table before creating a new one
        EXECUTE 'alter table concept_dimension rename to ' || backupConceptTableName  ||'' ;
        -- add index on upload_id 
    EXECUTE 'CREATE INDEX ' || interConceptTableName || '_uid_idx ON ' || interConceptTableName || '(UPLOAD_ID)';
    -- add index on upload_id 
    EXECUTE 'CREATE INDEX ' || interConceptTableName || '_cd_idx ON ' || interConceptTableName || '(concept_cd)';
    --backup the concept_dimension table before creating a new one
        EXECUTE 'alter table ' || interConceptTableName  || ' rename to concept_dimension' ;
EXCEPTION
        WHEN OTHERS THEN
                RAISE EXCEPTION 'An error was encountered - % -ERROR- %',SQLSTATE,SQLERRM;      
END;
$$;


ALTER FUNCTION i2b2miracum.sync_clear_concept_table(tempconcepttablename text, backupconcepttablename text, uploadid bigint, OUT errormsg text) OWNER TO i2b2miracum;

--
-- TOC entry 459 (class 1255 OID 17107)
-- Name: sync_clear_modifier_table(text, text, bigint); Type: FUNCTION; Schema: i2b2miracum; Owner: i2b2miracum
--

CREATE FUNCTION i2b2miracum.sync_clear_modifier_table(tempmodifiertablename text, backupmodifiertablename text, uploadid bigint, OUT errormsg text) RETURNS text
    LANGUAGE plpgsql
    AS $$
DECLARE
 
interModifierTableName  varchar(400);

BEGIN 
        interModifierTableName := backupModifierTableName || '_inter';
        --Delete duplicate rows with same modifier_path and modifier cd
        EXECUTE 'DELETE FROM ' || tempModifierTableName || ' t1 WHERE oid > 
                                           (SELECT  min(oid) FROM ' || tempModifierTableName || ' t2
                                             WHERE t1.modifier_cd = t2.modifier_cd 
                                            AND t1.modifier_path = t2.modifier_path
                                            )';
    EXECUTE 'create table ' ||  interModifierTableName || ' (
        MODIFIER_CD          varchar(50) NOT NULL,
        MODIFIER_PATH           varchar(700) NOT NULL,
        NAME_CHAR               varchar(2000) NULL,
        MODIFIER_BLOB        text NULL,
        UPDATE_DATE         timestamp NULL,
        DOWNLOAD_DATE       timestamp NULL,
        IMPORT_DATE         timestamp NULL,
        SOURCESYSTEM_CD     varchar(50) NULL,
        UPLOAD_ID               numeric(38,0) NULL,
    CONSTRAINT '|| interModifierTableName ||'_pk  PRIMARY KEY(MODIFIER_PATH)
         )';
    --Create new patient(patient_mapping) if temp table patient_ide does not exists 
        -- in patient_mapping table.
        EXECUTE 'insert into '|| interModifierTableName ||'  (modifier_cd,modifier_path,name_char,modifier_blob,update_date,download_date,import_date,sourcesystem_cd,upload_id)
                            PERFORM  modifier_cd, substring(modifier_path from 1 for 700),
                        name_char,modifier_blob,
                        update_date,download_date,
                        LOCALTIMESTAMP,sourcesystem_cd,
                         ' || uploadId || '  from ' || tempModifierTableName || '  temp ';
        --backup the modifier_dimension table before creating a new one
        EXECUTE 'alter table modifier_dimension rename to ' || backupModifierTableName  ||'' ;
        -- add index on upload_id 
    EXECUTE 'CREATE INDEX ' || interModifierTableName || '_uid_idx ON ' || interModifierTableName || '(UPLOAD_ID)';
    -- add index on upload_id 
    EXECUTE 'CREATE INDEX ' || interModifierTableName || '_cd_idx ON ' || interModifierTableName || '(modifier_cd)';
       --backup the modifier_dimension table before creating a new one
        EXECUTE 'alter table ' || interModifierTableName  || ' rename to modifier_dimension' ;
EXCEPTION
        WHEN OTHERS THEN
                RAISE EXCEPTION 'An error was encountered - % -ERROR- %',SQLSTATE,SQLERRM;      
END;
$$;


ALTER FUNCTION i2b2miracum.sync_clear_modifier_table(tempmodifiertablename text, backupmodifiertablename text, uploadid bigint, OUT errormsg text) OWNER TO i2b2miracum;

--
-- TOC entry 460 (class 1255 OID 17108)
-- Name: sync_clear_provider_table(text, text, bigint); Type: FUNCTION; Schema: i2b2miracum; Owner: i2b2miracum
--

CREATE FUNCTION i2b2miracum.sync_clear_provider_table(tempprovidertablename text, backupprovidertablename text, uploadid bigint, OUT errormsg text) RETURNS text
    LANGUAGE plpgsql
    AS $$
DECLARE
 
interProviderTableName  varchar(400);

BEGIN 
        interProviderTableName := backupProviderTableName || '_inter';
                --Delete duplicate rows with same encounter and patient combination
        EXECUTE 'DELETE FROM ' || tempProviderTableName || ' t1 WHERE oid > 
                                           (SELECT  min(oid) FROM ' || tempProviderTableName || ' t2
                                             WHERE t1.provider_id = t2.provider_id 
                                            AND t1.provider_path = t2.provider_path
                                            )';
    EXECUTE 'create table ' ||  interProviderTableName || ' (
    PROVIDER_ID         varchar(50) NOT NULL,
        PROVIDER_PATH       varchar(700) NOT NULL,
        NAME_CHAR               varchar(850) NULL,
        PROVIDER_BLOB       text NULL,
        UPDATE_DATE             timestamp NULL,
        DOWNLOAD_DATE       timestamp NULL,
        IMPORT_DATE         timestamp NULL,
        SOURCESYSTEM_CD     varchar(50) NULL,
        UPLOAD_ID               numeric(38,0) NULL ,
    CONSTRAINT  ' || interProviderTableName || '_pk PRIMARY KEY(PROVIDER_PATH,provider_id)
         )';
    --Create new patient(patient_mapping) if temp table patient_ide does not exists 
        -- in patient_mapping table.
        EXECUTE 'insert into ' ||  interProviderTableName || ' (provider_id,provider_path,name_char,provider_blob,update_date,download_date,import_date,sourcesystem_cd,upload_id)
                            PERFORM  provider_id,provider_path, 
                        name_char,provider_blob,
                        update_date,download_date,
                        LOCALTIMESTAMP,sourcesystem_cd, ' || uploadId || '
                             from ' || tempProviderTableName || '  temp ';
        --backup the concept_dimension table before creating a new one
        EXECUTE 'alter table provider_dimension rename to ' || backupProviderTableName  ||'' ;
        -- add index on provider_id, name_char 
    EXECUTE 'CREATE INDEX ' || interProviderTableName || '_id_idx ON ' || interProviderTableName  || '(Provider_Id,name_char)';
    EXECUTE 'CREATE INDEX ' || interProviderTableName || '_uid_idx ON ' || interProviderTableName  || '(UPLOAD_ID)';
        --backup the concept_dimension table before creating a new one
        EXECUTE 'alter table ' || interProviderTableName  || ' rename to provider_dimension' ;
EXCEPTION
        WHEN OTHERS THEN
                RAISE EXCEPTION 'An error was encountered - % -ERROR- %',SQLSTATE,SQLERRM;      
END;
$$;


ALTER FUNCTION i2b2miracum.sync_clear_provider_table(tempprovidertablename text, backupprovidertablename text, uploadid bigint, OUT errormsg text) OWNER TO i2b2miracum;

--
-- TOC entry 461 (class 1255 OID 17109)
-- Name: update_observation_fact(text, bigint, bigint); Type: FUNCTION; Schema: i2b2miracum; Owner: i2b2miracum
--

CREATE FUNCTION i2b2miracum.update_observation_fact(upload_temptable_name text, upload_id bigint, appendflag bigint, OUT errormsg text) RETURNS text
    LANGUAGE plpgsql
    AS $$
BEGIN
    -- appendFlag = 0 -> remove all and then insert
    -- appendFlag <> 0 -> do update, then insert what have not been updated    

    --Delete duplicate records(encounter_ide,patient_ide,concept_cd,start_date,modifier_cd,provider_id)
    EXECUTE 'DELETE FROM ' || upload_temptable_name ||'  t1 
    WHERE oid > (select min(oid) FROM ' || upload_temptable_name ||' t2 
        WHERE t1.encounter_id = t2.encounter_id  
        AND
        t1.encounter_id_source = t2.encounter_id_source
        AND
        t1.patient_id = t2.patient_id 
        AND 
        t1.patient_id_source = t2.patient_id_source
        AND 
        t1.concept_cd = t2.concept_cd
        AND 
        t1.start_date = t2.start_date
        AND 
        coalesce(t1.modifier_cd,''xyz'') = coalesce(t2.modifier_cd,''xyz'')
        AND 
        t1.instance_num = t2.instance_num
        AND 
        t1.provider_id = t2.provider_id)';
    --Delete records having null in start_date
    EXECUTE 'DELETE FROM ' || upload_temptable_name ||'  t1           
    WHERE coalesce(t1.start_date::text, '''') = '''' 
    ';
    --One time lookup on encounter_ide to get encounter_num 
    EXECUTE 'UPDATE ' ||  upload_temptable_name
    || ' SET encounter_num = (SELECT distinct em.encounter_num
        FROM encounter_mapping em
        WHERE em.encounter_ide = ' || upload_temptable_name||'.encounter_id
        AND em.encounter_ide_source = '|| upload_temptable_name||'.encounter_id_source
        and em.project_id=''@'' and em.patient_ide = ' || upload_temptable_name||'.patient_id
        and em.patient_ide_source = '|| upload_temptable_name||'.patient_id_source
    )
    WHERE EXISTS (SELECT distinct em.encounter_num
        FROM encounter_mapping em
        WHERE em.encounter_ide = '|| upload_temptable_name||'.encounter_id
        AND em.encounter_ide_source = '||upload_temptable_name||'.encounter_id_source
                     and em.project_id=''@'' and em.patient_ide = ' || upload_temptable_name||'.patient_id
                     and em.patient_ide_source = '|| upload_temptable_name||'.patient_id_source)';		     
             
    --One time lookup on patient_ide to get patient_num 
    EXECUTE 'UPDATE ' ||  upload_temptable_name
    || ' SET patient_num = (SELECT distinct pm.patient_num
        FROM patient_mapping pm
        WHERE pm.patient_ide = '|| upload_temptable_name||'.patient_id
        AND pm.patient_ide_source = '|| upload_temptable_name||'.patient_id_source
                     and pm.project_id=''@''

    )
    WHERE EXISTS (SELECT distinct pm.patient_num 
        FROM patient_mapping pm
        WHERE pm.patient_ide = '|| upload_temptable_name||'.patient_id
        AND pm.patient_ide_source = '||upload_temptable_name||'.patient_id_source              
                     and pm.project_id=''@'')';		     

    IF (appendFlag = 0) THEN
        --Archive records which are to be deleted in observation_fact table
        EXECUTE 'INSERT INTO  archive_observation_fact 
        SELECT obsfact.*, ' || upload_id ||'
        FROM observation_fact obsfact
        WHERE obsfact.encounter_num IN 
        (SELECT temp_obsfact.encounter_num
            FROM  ' ||upload_temptable_name ||' temp_obsfact
            GROUP BY temp_obsfact.encounter_num  
        )';
        --Delete above archived row FROM observation_fact
        EXECUTE 'DELETE  
        FROM observation_fact 
        WHERE EXISTS (
            SELECT archive.encounter_num
            FROM archive_observation_fact  archive
            WHERE archive.archive_upload_id = '||upload_id ||'
            AND archive.encounter_num=observation_fact.encounter_num
            AND archive.concept_cd = observation_fact.concept_cd
            AND archive.start_date = observation_fact.start_date
        )';
END IF;
-- if the append is true, then do the update else do insert all
IF (appendFlag <> 0) THEN -- update
    EXECUTE ' 
    UPDATE observation_fact f    
    SET valtype_cd = temp.valtype_cd ,
    tval_char=temp.tval_char, 
    nval_num = temp.nval_num,
    valueflag_cd=temp.valueflag_cd,
    quantity_num=temp.quantity_num,
    confidence_num=temp.confidence_num,
    observation_blob =temp.observation_blob,
    units_cd=temp.units_cd,
    end_date=temp.end_date,
    location_cd =temp.location_cd,
    update_date=temp.update_date ,
    download_date =temp.download_date,
    import_date=temp.import_date,
    sourcesystem_cd =temp.sourcesystem_cd,
    upload_id = temp.upload_id 
    FROM ' || upload_temptable_name ||' temp
    WHERE 
    temp.patient_num is not null 
    and temp.encounter_num is not null 
    and temp.encounter_num = f.encounter_num 
    and temp.patient_num = f.patient_num
    and temp.concept_cd = f.concept_cd
    and temp.start_date = f.start_date
    and temp.provider_id = f.provider_id
    and temp.modifier_cd = f.modifier_cd 
    and temp.instance_num = f.instance_num
    and coalesce(f.update_date,to_date(''01-JAN-1900'',''DD-MON-YYYY'')) <= coalesce(temp.update_date,to_date(''01-JAN-1900'',''DD-MON-YYYY''))';

    EXECUTE  'DELETE FROM ' || upload_temptable_name ||' temp WHERE EXISTS (SELECT 1 
        FROM observation_fact f 
        WHERE temp.patient_num is not null 
        and temp.encounter_num is not null 
        and temp.encounter_num = f.encounter_num 
        and temp.patient_num = f.patient_num
        and temp.concept_cd = f.concept_cd
        and temp.start_date = f.start_date
        and temp.provider_id = f.provider_id
        and temp.modifier_cd = f.modifier_cd 
        and temp.instance_num = f.instance_num
    )';

END IF;
--Transfer all rows FROM temp_obsfact to observation_fact
EXECUTE 'INSERT INTO observation_fact(
    encounter_num
    ,concept_cd
    , patient_num
    ,provider_id
    , start_date
    ,modifier_cd
    ,instance_num
    ,valtype_cd
    ,tval_char
    ,nval_num
    ,valueflag_cd
    ,quantity_num
    ,confidence_num
    ,observation_blob
    ,units_cd
    ,end_date
    ,location_cd
    , update_date
    ,download_date
    ,import_date
    ,sourcesystem_cd
    ,upload_id)
SELECT encounter_num
,concept_cd
, patient_num
,provider_id
, start_date
,modifier_cd
,instance_num
,valtype_cd
,tval_char
,nval_num
,valueflag_cd
,quantity_num
,confidence_num
,observation_blob
,units_cd
,end_date
,location_cd
, update_date
,download_date
,Now()
,sourcesystem_cd
,temp.upload_id 
FROM ' || upload_temptable_name ||' temp
WHERE (temp.patient_num IS NOT NULL AND temp.patient_num::text <> '''') AND  (temp.encounter_num IS NOT NULL AND temp.encounter_num::text <> '''')';


EXCEPTION
    WHEN OTHERS THEN
        RAISE EXCEPTION 'An error was encountered - % -ERROR- %',SQLSTATE,SQLERRM;      
END;
$$;


ALTER FUNCTION i2b2miracum.update_observation_fact(upload_temptable_name text, upload_id bigint, appendflag bigint, OUT errormsg text) OWNER TO i2b2miracum;

SET default_tablespace = '';

--
-- TOC entry 293 (class 1259 OID 17112)
-- Name: archive_observation_fact; Type: TABLE; Schema: i2b2miracum; Owner: i2b2miracum
--

CREATE TABLE i2b2miracum.archive_observation_fact (
    encounter_num integer,
    patient_num integer,
    concept_cd character varying(50),
    provider_id character varying(50),
    start_date timestamp without time zone,
    modifier_cd character varying(100),
    instance_num integer,
    valtype_cd character varying(50),
    tval_char character varying(255),
    nval_num numeric(18,5),
    valueflag_cd character varying(50),
    quantity_num numeric(18,5),
    units_cd character varying(50),
    end_date timestamp without time zone,
    location_cd character varying(50),
    observation_blob text,
    confidence_num numeric(18,5),
    update_date timestamp without time zone,
    download_date timestamp without time zone,
    import_date timestamp without time zone,
    sourcesystem_cd character varying(50),
    upload_id integer,
    text_search_index integer,
    archive_upload_id integer
);


ALTER TABLE i2b2miracum.archive_observation_fact OWNER TO i2b2miracum;

--
-- TOC entry 332 (class 1259 OID 17428)
-- Name: birn; Type: TABLE; Schema: i2b2miracum; Owner: i2b2miracum
--

CREATE TABLE i2b2miracum.birn (
    c_hlevel integer NOT NULL,
    c_fullname character varying(700) NOT NULL,
    c_name character varying(2000) NOT NULL,
    c_synonym_cd character(1) NOT NULL,
    c_visualattributes character(3) NOT NULL,
    c_totalnum integer,
    c_basecode character varying(50),
    c_metadataxml text,
    c_facttablecolumn character varying(50) NOT NULL,
    c_tablename character varying(50) NOT NULL,
    c_columnname character varying(50) NOT NULL,
    c_columndatatype character varying(50) NOT NULL,
    c_operator character varying(10) NOT NULL,
    c_dimcode character varying(700) NOT NULL,
    c_comment text,
    c_tooltip character varying(900),
    m_applied_path character varying(700) NOT NULL,
    update_date timestamp without time zone NOT NULL,
    download_date timestamp without time zone,
    import_date timestamp without time zone,
    sourcesystem_cd character varying(50),
    valuetype_cd character varying(50),
    m_exclusion_cd character varying(25),
    c_path character varying(700),
    c_symbol character varying(50)
);


ALTER TABLE i2b2miracum.birn OWNER TO i2b2miracum;

--
-- TOC entry 294 (class 1259 OID 17118)
-- Name: code_lookup; Type: TABLE; Schema: i2b2miracum; Owner: i2b2miracum
--

CREATE TABLE i2b2miracum.code_lookup (
    table_cd character varying(100) NOT NULL,
    column_cd character varying(100) NOT NULL,
    code_cd character varying(50) NOT NULL,
    name_char character varying(650),
    lookup_blob text,
    upload_date timestamp without time zone,
    update_date timestamp without time zone,
    download_date timestamp without time zone,
    import_date timestamp without time zone,
    sourcesystem_cd character varying(50),
    upload_id integer
);


ALTER TABLE i2b2miracum.code_lookup OWNER TO i2b2miracum;

--
-- TOC entry 295 (class 1259 OID 17124)
-- Name: concept_dimension; Type: TABLE; Schema: i2b2miracum; Owner: i2b2miracum
--

CREATE TABLE i2b2miracum.concept_dimension (
    concept_path character varying(700) NOT NULL,
    concept_cd character varying(50),
    name_char character varying(2000),
    concept_blob text,
    update_date timestamp without time zone,
    download_date timestamp without time zone,
    import_date timestamp without time zone,
    sourcesystem_cd character varying(50),
    upload_id integer
);


ALTER TABLE i2b2miracum.concept_dimension OWNER TO i2b2miracum;

--
-- TOC entry 333 (class 1259 OID 17434)
-- Name: custom_meta; Type: TABLE; Schema: i2b2miracum; Owner: i2b2miracum
--

CREATE TABLE i2b2miracum.custom_meta (
    c_hlevel integer NOT NULL,
    c_fullname character varying(700) NOT NULL,
    c_name character varying(2000) NOT NULL,
    c_synonym_cd character(1) NOT NULL,
    c_visualattributes character(3) NOT NULL,
    c_totalnum integer,
    c_basecode character varying(50),
    c_metadataxml text,
    c_facttablecolumn character varying(50) NOT NULL,
    c_tablename character varying(50) NOT NULL,
    c_columnname character varying(50) NOT NULL,
    c_columndatatype character varying(50) NOT NULL,
    c_operator character varying(10) NOT NULL,
    c_dimcode character varying(700) NOT NULL,
    c_comment text,
    c_tooltip character varying(900),
    m_applied_path character varying(700) NOT NULL,
    update_date timestamp without time zone NOT NULL,
    download_date timestamp without time zone,
    import_date timestamp without time zone,
    sourcesystem_cd character varying(50),
    valuetype_cd character varying(50),
    m_exclusion_cd character varying(25),
    c_path character varying(700),
    c_symbol character varying(50)
);


ALTER TABLE i2b2miracum.custom_meta OWNER TO i2b2miracum;

--
-- TOC entry 296 (class 1259 OID 17130)
-- Name: datamart_report; Type: TABLE; Schema: i2b2miracum; Owner: i2b2miracum
--

CREATE TABLE i2b2miracum.datamart_report (
    total_patient integer,
    total_observationfact integer,
    total_event integer,
    report_date timestamp without time zone
);


ALTER TABLE i2b2miracum.datamart_report OWNER TO i2b2miracum;

--
-- TOC entry 297 (class 1259 OID 17133)
-- Name: encounter_mapping; Type: TABLE; Schema: i2b2miracum; Owner: i2b2miracum
--

CREATE TABLE i2b2miracum.encounter_mapping (
    encounter_ide character varying(200) NOT NULL,
    encounter_ide_source character varying(50) NOT NULL,
    project_id character varying(50) NOT NULL,
    encounter_num integer NOT NULL,
    patient_ide character varying(200) NOT NULL,
    patient_ide_source character varying(50) NOT NULL,
    encounter_ide_status character varying(50),
    upload_date timestamp without time zone,
    update_date timestamp without time zone,
    download_date timestamp without time zone,
    import_date timestamp without time zone,
    sourcesystem_cd character varying(50),
    upload_id integer
);


ALTER TABLE i2b2miracum.encounter_mapping OWNER TO i2b2miracum;

--
-- TOC entry 334 (class 1259 OID 17440)
-- Name: i2b2; Type: TABLE; Schema: i2b2miracum; Owner: i2b2miracum
--

CREATE TABLE i2b2miracum.i2b2 (
    c_hlevel integer NOT NULL,
    c_fullname character varying(700) NOT NULL,
    c_name character varying(2000) NOT NULL,
    c_synonym_cd character(1) NOT NULL,
    c_visualattributes character(3) NOT NULL,
    c_totalnum integer,
    c_basecode character varying(50),
    c_metadataxml text,
    c_facttablecolumn character varying(50) NOT NULL,
    c_tablename character varying(50) NOT NULL,
    c_columnname character varying(50) NOT NULL,
    c_columndatatype character varying(50) NOT NULL,
    c_operator character varying(10) NOT NULL,
    c_dimcode character varying(700) NOT NULL,
    c_comment text,
    c_tooltip character varying(900),
    m_applied_path character varying(700) NOT NULL,
    update_date timestamp without time zone NOT NULL,
    download_date timestamp without time zone,
    import_date timestamp without time zone,
    sourcesystem_cd character varying(50),
    valuetype_cd character varying(50),
    m_exclusion_cd character varying(25),
    c_path character varying(700),
    c_symbol character varying(50)
);


ALTER TABLE i2b2miracum.i2b2 OWNER TO i2b2miracum;

--
-- TOC entry 335 (class 1259 OID 17446)
-- Name: icd10_icd9; Type: TABLE; Schema: i2b2miracum; Owner: i2b2miracum
--

CREATE TABLE i2b2miracum.icd10_icd9 (
    c_hlevel integer NOT NULL,
    c_fullname character varying(700) NOT NULL,
    c_name character varying(2000) NOT NULL,
    c_synonym_cd character(1) NOT NULL,
    c_visualattributes character(3) NOT NULL,
    c_totalnum integer,
    c_basecode character varying(50),
    c_metadataxml text,
    c_facttablecolumn character varying(50) NOT NULL,
    c_tablename character varying(50) NOT NULL,
    c_columnname character varying(50) NOT NULL,
    c_columndatatype character varying(50) NOT NULL,
    c_operator character varying(10) NOT NULL,
    c_dimcode character varying(700) NOT NULL,
    c_comment text,
    c_tooltip character varying(900),
    m_applied_path character varying(700) NOT NULL,
    update_date timestamp without time zone NOT NULL,
    download_date timestamp without time zone,
    import_date timestamp without time zone,
    sourcesystem_cd character varying(50),
    valuetype_cd character varying(50),
    m_exclusion_cd character varying(25),
    c_path character varying(700),
    c_symbol character varying(50),
    plain_code character varying(25)
);


ALTER TABLE i2b2miracum.icd10_icd9 OWNER TO i2b2miracum;

--
-- TOC entry 340 (class 1259 OID 17488)
-- Name: im_audit; Type: TABLE; Schema: i2b2miracum; Owner: i2b2miracum
--

CREATE TABLE i2b2miracum.im_audit (
    query_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    lcl_site character varying(50) NOT NULL,
    lcl_id character varying(200) NOT NULL,
    user_id character varying(50) NOT NULL,
    project_id character varying(50) NOT NULL,
    comments text
);


ALTER TABLE i2b2miracum.im_audit OWNER TO i2b2miracum;

--
-- TOC entry 341 (class 1259 OID 17495)
-- Name: im_mpi_demographics; Type: TABLE; Schema: i2b2miracum; Owner: i2b2miracum
--

CREATE TABLE i2b2miracum.im_mpi_demographics (
    global_id character varying(200) NOT NULL,
    global_status character varying(50),
    demographics character varying(400),
    update_date timestamp without time zone,
    download_date timestamp without time zone,
    import_date timestamp without time zone,
    sourcesystem_cd character varying(50),
    upload_id integer
);


ALTER TABLE i2b2miracum.im_mpi_demographics OWNER TO i2b2miracum;

--
-- TOC entry 342 (class 1259 OID 17501)
-- Name: im_mpi_mapping; Type: TABLE; Schema: i2b2miracum; Owner: i2b2miracum
--

CREATE TABLE i2b2miracum.im_mpi_mapping (
    global_id character varying(200) NOT NULL,
    lcl_site character varying(50) NOT NULL,
    lcl_id character varying(200) NOT NULL,
    lcl_status character varying(50),
    update_date timestamp without time zone NOT NULL,
    download_date timestamp without time zone,
    import_date timestamp without time zone,
    sourcesystem_cd character varying(50),
    upload_id integer
);


ALTER TABLE i2b2miracum.im_mpi_mapping OWNER TO i2b2miracum;

--
-- TOC entry 343 (class 1259 OID 17507)
-- Name: im_project_patients; Type: TABLE; Schema: i2b2miracum; Owner: i2b2miracum
--

CREATE TABLE i2b2miracum.im_project_patients (
    project_id character varying(50) NOT NULL,
    global_id character varying(200) NOT NULL,
    patient_project_status character varying(50),
    update_date timestamp without time zone,
    download_date timestamp without time zone,
    import_date timestamp without time zone,
    sourcesystem_cd character varying(50),
    upload_id integer
);


ALTER TABLE i2b2miracum.im_project_patients OWNER TO i2b2miracum;

--
-- TOC entry 344 (class 1259 OID 17510)
-- Name: im_project_sites; Type: TABLE; Schema: i2b2miracum; Owner: i2b2miracum
--

CREATE TABLE i2b2miracum.im_project_sites (
    project_id character varying(50) NOT NULL,
    lcl_site character varying(50) NOT NULL,
    project_status character varying(50),
    update_date timestamp without time zone,
    download_date timestamp without time zone,
    import_date timestamp without time zone,
    sourcesystem_cd character varying(50),
    upload_id integer
);


ALTER TABLE i2b2miracum.im_project_sites OWNER TO i2b2miracum;

--
-- TOC entry 298 (class 1259 OID 17139)
-- Name: modifier_dimension; Type: TABLE; Schema: i2b2miracum; Owner: i2b2miracum
--

CREATE TABLE i2b2miracum.modifier_dimension (
    modifier_path character varying(700) NOT NULL,
    modifier_cd character varying(50),
    name_char character varying(2000),
    modifier_blob text,
    update_date timestamp without time zone,
    download_date timestamp without time zone,
    import_date timestamp without time zone,
    sourcesystem_cd character varying(50),
    upload_id integer
);


ALTER TABLE i2b2miracum.modifier_dimension OWNER TO i2b2miracum;

--
-- TOC entry 299 (class 1259 OID 17145)
-- Name: observation_fact; Type: TABLE; Schema: i2b2miracum; Owner: i2b2miracum
--

CREATE TABLE i2b2miracum.observation_fact (
    encounter_num integer NOT NULL,
    patient_num integer NOT NULL,
    concept_cd character varying(50) NOT NULL,
    provider_id character varying(50) NOT NULL,
    start_date timestamp without time zone NOT NULL,
    modifier_cd character varying(100) DEFAULT '@'::character varying NOT NULL,
    instance_num integer DEFAULT 1 NOT NULL,
    valtype_cd character varying(50),
    tval_char character varying(255),
    nval_num numeric(18,5),
    valueflag_cd character varying(50),
    quantity_num numeric(18,5),
    units_cd character varying(50),
    end_date timestamp without time zone,
    location_cd character varying(50),
    observation_blob text,
    confidence_num numeric(18,5),
    update_date timestamp without time zone,
    download_date timestamp without time zone,
    import_date timestamp without time zone,
    sourcesystem_cd character varying(50),
    upload_id integer,
    text_search_index integer NOT NULL
);


ALTER TABLE i2b2miracum.observation_fact OWNER TO i2b2miracum;

--
-- TOC entry 300 (class 1259 OID 17153)
-- Name: observation_fact_text_search_index_seq; Type: SEQUENCE; Schema: i2b2miracum; Owner: i2b2miracum
--

CREATE SEQUENCE i2b2miracum.observation_fact_text_search_index_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE i2b2miracum.observation_fact_text_search_index_seq OWNER TO i2b2miracum;

--
-- TOC entry 3849 (class 0 OID 0)
-- Dependencies: 300
-- Name: observation_fact_text_search_index_seq; Type: SEQUENCE OWNED BY; Schema: i2b2miracum; Owner: i2b2miracum
--

ALTER SEQUENCE i2b2miracum.observation_fact_text_search_index_seq OWNED BY i2b2miracum.observation_fact.text_search_index;


--
-- TOC entry 336 (class 1259 OID 17452)
-- Name: ont_process_status; Type: TABLE; Schema: i2b2miracum; Owner: i2b2miracum
--

CREATE TABLE i2b2miracum.ont_process_status (
    process_id integer NOT NULL,
    process_type_cd character varying(50),
    start_date timestamp without time zone,
    end_date timestamp without time zone,
    process_step_cd character varying(50),
    process_status_cd character varying(50),
    crc_upload_id integer,
    status_cd character varying(50),
    message text,
    entry_date timestamp without time zone,
    change_date timestamp without time zone,
    changedby_char character(50)
);


ALTER TABLE i2b2miracum.ont_process_status OWNER TO i2b2miracum;

--
-- TOC entry 337 (class 1259 OID 17458)
-- Name: ont_process_status_process_id_seq; Type: SEQUENCE; Schema: i2b2miracum; Owner: i2b2miracum
--

CREATE SEQUENCE i2b2miracum.ont_process_status_process_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE i2b2miracum.ont_process_status_process_id_seq OWNER TO i2b2miracum;

--
-- TOC entry 3850 (class 0 OID 0)
-- Dependencies: 337
-- Name: ont_process_status_process_id_seq; Type: SEQUENCE OWNED BY; Schema: i2b2miracum; Owner: i2b2miracum
--

ALTER SEQUENCE i2b2miracum.ont_process_status_process_id_seq OWNED BY i2b2miracum.ont_process_status.process_id;


--
-- TOC entry 301 (class 1259 OID 17155)
-- Name: patient_dimension; Type: TABLE; Schema: i2b2miracum; Owner: i2b2miracum
--

CREATE TABLE i2b2miracum.patient_dimension (
    patient_num integer NOT NULL,
    vital_status_cd character varying(50),
    birth_date timestamp without time zone,
    death_date timestamp without time zone,
    sex_cd character varying(50),
    age_in_years_num integer,
    language_cd character varying(50),
    race_cd character varying(50),
    marital_status_cd character varying(50),
    religion_cd character varying(50),
    zip_cd character varying(10),
    statecityzip_path character varying(700),
    income_cd character varying(50),
    patient_blob text,
    update_date timestamp without time zone,
    download_date timestamp without time zone,
    import_date timestamp without time zone,
    sourcesystem_cd character varying(50),
    upload_id integer
);


ALTER TABLE i2b2miracum.patient_dimension OWNER TO i2b2miracum;

--
-- TOC entry 302 (class 1259 OID 17161)
-- Name: patient_mapping; Type: TABLE; Schema: i2b2miracum; Owner: i2b2miracum
--

CREATE TABLE i2b2miracum.patient_mapping (
    patient_ide character varying(200) NOT NULL,
    patient_ide_source character varying(50) NOT NULL,
    patient_num integer NOT NULL,
    patient_ide_status character varying(50),
    project_id character varying(50) NOT NULL,
    upload_date timestamp without time zone,
    update_date timestamp without time zone,
    download_date timestamp without time zone,
    import_date timestamp without time zone,
    sourcesystem_cd character varying(50),
    upload_id integer
);


ALTER TABLE i2b2miracum.patient_mapping OWNER TO i2b2miracum;

--
-- TOC entry 303 (class 1259 OID 17164)
-- Name: provider_dimension; Type: TABLE; Schema: i2b2miracum; Owner: i2b2miracum
--

CREATE TABLE i2b2miracum.provider_dimension (
    provider_id character varying(50) NOT NULL,
    provider_path character varying(700) NOT NULL,
    name_char character varying(850),
    provider_blob text,
    update_date timestamp without time zone,
    download_date timestamp without time zone,
    import_date timestamp without time zone,
    sourcesystem_cd character varying(50),
    upload_id integer
);


ALTER TABLE i2b2miracum.provider_dimension OWNER TO i2b2miracum;

--
-- TOC entry 304 (class 1259 OID 17170)
-- Name: qt_analysis_plugin; Type: TABLE; Schema: i2b2miracum; Owner: i2b2miracum
--

CREATE TABLE i2b2miracum.qt_analysis_plugin (
    plugin_id integer NOT NULL,
    plugin_name character varying(2000),
    description character varying(2000),
    version_cd character varying(50),
    parameter_info text,
    parameter_info_xsd text,
    command_line text,
    working_folder text,
    commandoption_cd text,
    plugin_icon text,
    status_cd character varying(50),
    user_id character varying(50),
    group_id character varying(50),
    create_date timestamp without time zone,
    update_date timestamp without time zone
);


ALTER TABLE i2b2miracum.qt_analysis_plugin OWNER TO i2b2miracum;

--
-- TOC entry 305 (class 1259 OID 17176)
-- Name: qt_analysis_plugin_result_type; Type: TABLE; Schema: i2b2miracum; Owner: i2b2miracum
--

CREATE TABLE i2b2miracum.qt_analysis_plugin_result_type (
    plugin_id integer NOT NULL,
    result_type_id integer NOT NULL
);


ALTER TABLE i2b2miracum.qt_analysis_plugin_result_type OWNER TO i2b2miracum;

--
-- TOC entry 306 (class 1259 OID 17179)
-- Name: qt_breakdown_path; Type: TABLE; Schema: i2b2miracum; Owner: i2b2miracum
--

CREATE TABLE i2b2miracum.qt_breakdown_path (
    name character varying(100),
    value character varying(2000),
    create_date timestamp without time zone,
    update_date timestamp without time zone,
    user_id character varying(50)
);


ALTER TABLE i2b2miracum.qt_breakdown_path OWNER TO i2b2miracum;

--
-- TOC entry 307 (class 1259 OID 17185)
-- Name: qt_patient_enc_collection; Type: TABLE; Schema: i2b2miracum; Owner: i2b2miracum
--

CREATE TABLE i2b2miracum.qt_patient_enc_collection (
    patient_enc_coll_id integer NOT NULL,
    result_instance_id integer,
    set_index integer,
    patient_num integer,
    encounter_num integer
);


ALTER TABLE i2b2miracum.qt_patient_enc_collection OWNER TO i2b2miracum;

--
-- TOC entry 308 (class 1259 OID 17188)
-- Name: qt_patient_enc_collection_patient_enc_coll_id_seq; Type: SEQUENCE; Schema: i2b2miracum; Owner: i2b2miracum
--

CREATE SEQUENCE i2b2miracum.qt_patient_enc_collection_patient_enc_coll_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE i2b2miracum.qt_patient_enc_collection_patient_enc_coll_id_seq OWNER TO i2b2miracum;

--
-- TOC entry 3851 (class 0 OID 0)
-- Dependencies: 308
-- Name: qt_patient_enc_collection_patient_enc_coll_id_seq; Type: SEQUENCE OWNED BY; Schema: i2b2miracum; Owner: i2b2miracum
--

ALTER SEQUENCE i2b2miracum.qt_patient_enc_collection_patient_enc_coll_id_seq OWNED BY i2b2miracum.qt_patient_enc_collection.patient_enc_coll_id;


--
-- TOC entry 309 (class 1259 OID 17190)
-- Name: qt_patient_set_collection; Type: TABLE; Schema: i2b2miracum; Owner: i2b2miracum
--

CREATE TABLE i2b2miracum.qt_patient_set_collection (
    patient_set_coll_id bigint NOT NULL,
    result_instance_id integer,
    set_index integer,
    patient_num integer
);


ALTER TABLE i2b2miracum.qt_patient_set_collection OWNER TO i2b2miracum;

--
-- TOC entry 310 (class 1259 OID 17193)
-- Name: qt_patient_set_collection_patient_set_coll_id_seq; Type: SEQUENCE; Schema: i2b2miracum; Owner: i2b2miracum
--

CREATE SEQUENCE i2b2miracum.qt_patient_set_collection_patient_set_coll_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE i2b2miracum.qt_patient_set_collection_patient_set_coll_id_seq OWNER TO i2b2miracum;

--
-- TOC entry 3852 (class 0 OID 0)
-- Dependencies: 310
-- Name: qt_patient_set_collection_patient_set_coll_id_seq; Type: SEQUENCE OWNED BY; Schema: i2b2miracum; Owner: i2b2miracum
--

ALTER SEQUENCE i2b2miracum.qt_patient_set_collection_patient_set_coll_id_seq OWNED BY i2b2miracum.qt_patient_set_collection.patient_set_coll_id;


--
-- TOC entry 311 (class 1259 OID 17195)
-- Name: qt_pdo_query_master; Type: TABLE; Schema: i2b2miracum; Owner: i2b2miracum
--

CREATE TABLE i2b2miracum.qt_pdo_query_master (
    query_master_id integer NOT NULL,
    user_id character varying(50) NOT NULL,
    group_id character varying(50) NOT NULL,
    create_date timestamp without time zone NOT NULL,
    request_xml text,
    i2b2_request_xml text
);


ALTER TABLE i2b2miracum.qt_pdo_query_master OWNER TO i2b2miracum;

--
-- TOC entry 312 (class 1259 OID 17201)
-- Name: qt_pdo_query_master_query_master_id_seq; Type: SEQUENCE; Schema: i2b2miracum; Owner: i2b2miracum
--

CREATE SEQUENCE i2b2miracum.qt_pdo_query_master_query_master_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE i2b2miracum.qt_pdo_query_master_query_master_id_seq OWNER TO i2b2miracum;

--
-- TOC entry 3853 (class 0 OID 0)
-- Dependencies: 312
-- Name: qt_pdo_query_master_query_master_id_seq; Type: SEQUENCE OWNED BY; Schema: i2b2miracum; Owner: i2b2miracum
--

ALTER SEQUENCE i2b2miracum.qt_pdo_query_master_query_master_id_seq OWNED BY i2b2miracum.qt_pdo_query_master.query_master_id;


--
-- TOC entry 313 (class 1259 OID 17203)
-- Name: qt_privilege; Type: TABLE; Schema: i2b2miracum; Owner: i2b2miracum
--

CREATE TABLE i2b2miracum.qt_privilege (
    protection_label_cd character varying(1500) NOT NULL,
    dataprot_cd character varying(1000),
    hivemgmt_cd character varying(1000),
    plugin_id integer
);


ALTER TABLE i2b2miracum.qt_privilege OWNER TO i2b2miracum;

--
-- TOC entry 314 (class 1259 OID 17209)
-- Name: qt_query_instance; Type: TABLE; Schema: i2b2miracum; Owner: i2b2miracum
--

CREATE TABLE i2b2miracum.qt_query_instance (
    query_instance_id integer NOT NULL,
    query_master_id integer,
    user_id character varying(50) NOT NULL,
    group_id character varying(50) NOT NULL,
    batch_mode character varying(50),
    start_date timestamp without time zone NOT NULL,
    end_date timestamp without time zone,
    delete_flag character varying(3),
    status_type_id integer,
    message text
);


ALTER TABLE i2b2miracum.qt_query_instance OWNER TO i2b2miracum;

--
-- TOC entry 315 (class 1259 OID 17215)
-- Name: qt_query_instance_query_instance_id_seq; Type: SEQUENCE; Schema: i2b2miracum; Owner: i2b2miracum
--

CREATE SEQUENCE i2b2miracum.qt_query_instance_query_instance_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE i2b2miracum.qt_query_instance_query_instance_id_seq OWNER TO i2b2miracum;

--
-- TOC entry 3854 (class 0 OID 0)
-- Dependencies: 315
-- Name: qt_query_instance_query_instance_id_seq; Type: SEQUENCE OWNED BY; Schema: i2b2miracum; Owner: i2b2miracum
--

ALTER SEQUENCE i2b2miracum.qt_query_instance_query_instance_id_seq OWNED BY i2b2miracum.qt_query_instance.query_instance_id;


--
-- TOC entry 316 (class 1259 OID 17217)
-- Name: qt_query_master; Type: TABLE; Schema: i2b2miracum; Owner: i2b2miracum
--

CREATE TABLE i2b2miracum.qt_query_master (
    query_master_id integer NOT NULL,
    name character varying(250) NOT NULL,
    user_id character varying(50) NOT NULL,
    group_id character varying(50) NOT NULL,
    master_type_cd character varying(2000),
    plugin_id integer,
    create_date timestamp without time zone NOT NULL,
    delete_date timestamp without time zone,
    delete_flag character varying(3),
    request_xml text,
    generated_sql text,
    i2b2_request_xml text,
    pm_xml text
);


ALTER TABLE i2b2miracum.qt_query_master OWNER TO i2b2miracum;

--
-- TOC entry 317 (class 1259 OID 17223)
-- Name: qt_query_master_query_master_id_seq; Type: SEQUENCE; Schema: i2b2miracum; Owner: i2b2miracum
--

CREATE SEQUENCE i2b2miracum.qt_query_master_query_master_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE i2b2miracum.qt_query_master_query_master_id_seq OWNER TO i2b2miracum;

--
-- TOC entry 3855 (class 0 OID 0)
-- Dependencies: 317
-- Name: qt_query_master_query_master_id_seq; Type: SEQUENCE OWNED BY; Schema: i2b2miracum; Owner: i2b2miracum
--

ALTER SEQUENCE i2b2miracum.qt_query_master_query_master_id_seq OWNED BY i2b2miracum.qt_query_master.query_master_id;


--
-- TOC entry 318 (class 1259 OID 17225)
-- Name: qt_query_result_instance; Type: TABLE; Schema: i2b2miracum; Owner: i2b2miracum
--

CREATE TABLE i2b2miracum.qt_query_result_instance (
    result_instance_id integer NOT NULL,
    query_instance_id integer,
    result_type_id integer NOT NULL,
    set_size integer,
    start_date timestamp without time zone NOT NULL,
    end_date timestamp without time zone,
    status_type_id integer NOT NULL,
    delete_flag character varying(3),
    message text,
    description character varying(200),
    real_set_size integer,
    obfusc_method character varying(500)
);


ALTER TABLE i2b2miracum.qt_query_result_instance OWNER TO i2b2miracum;

--
-- TOC entry 319 (class 1259 OID 17231)
-- Name: qt_query_result_instance_result_instance_id_seq; Type: SEQUENCE; Schema: i2b2miracum; Owner: i2b2miracum
--

CREATE SEQUENCE i2b2miracum.qt_query_result_instance_result_instance_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE i2b2miracum.qt_query_result_instance_result_instance_id_seq OWNER TO i2b2miracum;

--
-- TOC entry 3856 (class 0 OID 0)
-- Dependencies: 319
-- Name: qt_query_result_instance_result_instance_id_seq; Type: SEQUENCE OWNED BY; Schema: i2b2miracum; Owner: i2b2miracum
--

ALTER SEQUENCE i2b2miracum.qt_query_result_instance_result_instance_id_seq OWNED BY i2b2miracum.qt_query_result_instance.result_instance_id;


--
-- TOC entry 320 (class 1259 OID 17233)
-- Name: qt_query_result_type; Type: TABLE; Schema: i2b2miracum; Owner: i2b2miracum
--

CREATE TABLE i2b2miracum.qt_query_result_type (
    result_type_id integer NOT NULL,
    name character varying(100),
    description character varying(200),
    display_type_id character varying(500),
    visual_attribute_type_id character varying(3),
    user_role_cd character varying(255),
    classname character varying(200)
);


ALTER TABLE i2b2miracum.qt_query_result_type OWNER TO i2b2miracum;

--
-- TOC entry 321 (class 1259 OID 17239)
-- Name: qt_query_status_type; Type: TABLE; Schema: i2b2miracum; Owner: i2b2miracum
--

CREATE TABLE i2b2miracum.qt_query_status_type (
    status_type_id integer NOT NULL,
    name character varying(100),
    description character varying(200)
);


ALTER TABLE i2b2miracum.qt_query_status_type OWNER TO i2b2miracum;

--
-- TOC entry 322 (class 1259 OID 17242)
-- Name: qt_xml_result; Type: TABLE; Schema: i2b2miracum; Owner: i2b2miracum
--

CREATE TABLE i2b2miracum.qt_xml_result (
    xml_result_id integer NOT NULL,
    result_instance_id integer,
    xml_value text
);


ALTER TABLE i2b2miracum.qt_xml_result OWNER TO i2b2miracum;

--
-- TOC entry 323 (class 1259 OID 17248)
-- Name: qt_xml_result_xml_result_id_seq; Type: SEQUENCE; Schema: i2b2miracum; Owner: i2b2miracum
--

CREATE SEQUENCE i2b2miracum.qt_xml_result_xml_result_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE i2b2miracum.qt_xml_result_xml_result_id_seq OWNER TO i2b2miracum;

--
-- TOC entry 3857 (class 0 OID 0)
-- Dependencies: 323
-- Name: qt_xml_result_xml_result_id_seq; Type: SEQUENCE OWNED BY; Schema: i2b2miracum; Owner: i2b2miracum
--

ALTER SEQUENCE i2b2miracum.qt_xml_result_xml_result_id_seq OWNED BY i2b2miracum.qt_xml_result.xml_result_id;


--
-- TOC entry 338 (class 1259 OID 17460)
-- Name: schemes; Type: TABLE; Schema: i2b2miracum; Owner: i2b2miracum
--

CREATE TABLE i2b2miracum.schemes (
    c_key character varying(50) NOT NULL,
    c_name character varying(50) NOT NULL,
    c_description character varying(100)
);


ALTER TABLE i2b2miracum.schemes OWNER TO i2b2miracum;

--
-- TOC entry 324 (class 1259 OID 17250)
-- Name: seq_encounter_num; Type: SEQUENCE; Schema: i2b2miracum; Owner: i2b2miracum
--

CREATE SEQUENCE i2b2miracum.seq_encounter_num
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE i2b2miracum.seq_encounter_num OWNER TO i2b2miracum;

--
-- TOC entry 325 (class 1259 OID 17252)
-- Name: seq_patient_num; Type: SEQUENCE; Schema: i2b2miracum; Owner: i2b2miracum
--

CREATE SEQUENCE i2b2miracum.seq_patient_num
    START WITH 10
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE i2b2miracum.seq_patient_num OWNER TO i2b2miracum;

--
-- TOC entry 326 (class 1259 OID 17254)
-- Name: set_type; Type: TABLE; Schema: i2b2miracum; Owner: i2b2miracum
--

CREATE TABLE i2b2miracum.set_type (
    id integer NOT NULL,
    name character varying(500),
    create_date timestamp without time zone
);


ALTER TABLE i2b2miracum.set_type OWNER TO i2b2miracum;

--
-- TOC entry 327 (class 1259 OID 17260)
-- Name: set_upload_status; Type: TABLE; Schema: i2b2miracum; Owner: i2b2miracum
--

CREATE TABLE i2b2miracum.set_upload_status (
    upload_id integer NOT NULL,
    set_type_id integer NOT NULL,
    source_cd character varying(50) NOT NULL,
    no_of_record bigint,
    loaded_record bigint,
    deleted_record bigint,
    load_date timestamp without time zone NOT NULL,
    end_date timestamp without time zone,
    load_status character varying(100),
    message text,
    input_file_name text,
    log_file_name text,
    transform_name character varying(500)
);


ALTER TABLE i2b2miracum.set_upload_status OWNER TO i2b2miracum;

--
-- TOC entry 328 (class 1259 OID 17266)
-- Name: source_master; Type: TABLE; Schema: i2b2miracum; Owner: i2b2miracum
--

CREATE TABLE i2b2miracum.source_master (
    source_cd character varying(50) NOT NULL,
    description character varying(300),
    create_date timestamp without time zone
);


ALTER TABLE i2b2miracum.source_master OWNER TO i2b2miracum;

--
-- TOC entry 339 (class 1259 OID 17463)
-- Name: table_access; Type: TABLE; Schema: i2b2miracum; Owner: i2b2miracum
--

CREATE TABLE i2b2miracum.table_access (
    c_table_cd character varying(50) NOT NULL,
    c_table_name character varying(50) NOT NULL,
    c_protected_access character(1),
    c_ontology_protection text,
    c_hlevel integer NOT NULL,
    c_fullname character varying(700) NOT NULL,
    c_name character varying(2000) NOT NULL,
    c_synonym_cd character(1) NOT NULL,
    c_visualattributes character(3) NOT NULL,
    c_totalnum integer,
    c_basecode character varying(50),
    c_metadataxml text,
    c_facttablecolumn character varying(50) NOT NULL,
    c_dimtablename character varying(50) NOT NULL,
    c_columnname character varying(50) NOT NULL,
    c_columndatatype character varying(50) NOT NULL,
    c_operator character varying(10) NOT NULL,
    c_dimcode character varying(700) NOT NULL,
    c_comment text,
    c_tooltip character varying(900),
    c_entry_date timestamp without time zone,
    c_change_date timestamp without time zone,
    c_status_cd character(1),
    valuetype_cd character varying(50)
);


ALTER TABLE i2b2miracum.table_access OWNER TO i2b2miracum;

--
-- TOC entry 329 (class 1259 OID 17269)
-- Name: upload_status; Type: TABLE; Schema: i2b2miracum; Owner: i2b2miracum
--

CREATE TABLE i2b2miracum.upload_status (
    upload_id integer NOT NULL,
    upload_label character varying(500) NOT NULL,
    user_id character varying(100) NOT NULL,
    source_cd character varying(50) NOT NULL,
    no_of_record bigint,
    loaded_record bigint,
    deleted_record bigint,
    load_date timestamp without time zone NOT NULL,
    end_date timestamp without time zone,
    load_status character varying(100),
    message text,
    input_file_name text,
    log_file_name text,
    transform_name character varying(500)
);


ALTER TABLE i2b2miracum.upload_status OWNER TO i2b2miracum;

--
-- TOC entry 330 (class 1259 OID 17275)
-- Name: upload_status_upload_id_seq; Type: SEQUENCE; Schema: i2b2miracum; Owner: i2b2miracum
--

CREATE SEQUENCE i2b2miracum.upload_status_upload_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE i2b2miracum.upload_status_upload_id_seq OWNER TO i2b2miracum;

--
-- TOC entry 3858 (class 0 OID 0)
-- Dependencies: 330
-- Name: upload_status_upload_id_seq; Type: SEQUENCE OWNED BY; Schema: i2b2miracum; Owner: i2b2miracum
--

ALTER SEQUENCE i2b2miracum.upload_status_upload_id_seq OWNED BY i2b2miracum.upload_status.upload_id;


--
-- TOC entry 331 (class 1259 OID 17277)
-- Name: visit_dimension; Type: TABLE; Schema: i2b2miracum; Owner: i2b2miracum
--

CREATE TABLE i2b2miracum.visit_dimension (
    encounter_num integer NOT NULL,
    patient_num integer NOT NULL,
    active_status_cd character varying(50),
    start_date timestamp without time zone,
    end_date timestamp without time zone,
    inout_cd character varying(50),
    location_cd character varying(50),
    location_path character varying(900),
    length_of_stay integer,
    visit_blob text,
    update_date timestamp without time zone,
    download_date timestamp without time zone,
    import_date timestamp without time zone,
    sourcesystem_cd character varying(50),
    upload_id integer
);


ALTER TABLE i2b2miracum.visit_dimension OWNER TO i2b2miracum;

--
-- TOC entry 291 (class 1259 OID 17069)
-- Name: workplace; Type: TABLE; Schema: i2b2miracum; Owner: i2b2miracum
--

CREATE TABLE i2b2miracum.workplace (
    c_name character varying(255) NOT NULL,
    c_user_id character varying(255) NOT NULL,
    c_group_id character varying(255) NOT NULL,
    c_share_id character varying(255),
    c_index character varying(255) NOT NULL,
    c_parent_index character varying(255),
    c_visualattributes character(3) NOT NULL,
    c_protected_access character(1),
    c_tooltip character varying(255),
    c_work_xml text,
    c_work_xml_schema text,
    c_work_xml_i2b2_type character varying(255),
    c_entry_date timestamp without time zone,
    c_change_date timestamp without time zone,
    c_status_cd character(1)
);


ALTER TABLE i2b2miracum.workplace OWNER TO i2b2miracum;

--
-- TOC entry 292 (class 1259 OID 17075)
-- Name: workplace_access; Type: TABLE; Schema: i2b2miracum; Owner: i2b2miracum
--

CREATE TABLE i2b2miracum.workplace_access (
    c_table_cd character varying(255) NOT NULL,
    c_table_name character varying(255) NOT NULL,
    c_protected_access character(1),
    c_hlevel integer NOT NULL,
    c_name character varying(255) NOT NULL,
    c_user_id character varying(255) NOT NULL,
    c_group_id character varying(255) NOT NULL,
    c_share_id character varying(255),
    c_index character varying(255) NOT NULL,
    c_parent_index character varying(255),
    c_visualattributes character(3) NOT NULL,
    c_tooltip character varying(255),
    c_entry_date timestamp without time zone,
    c_change_date timestamp without time zone,
    c_status_cd character(1)
);


ALTER TABLE i2b2miracum.workplace_access OWNER TO i2b2miracum;

--
-- TOC entry 3534 (class 2604 OID 17283)
-- Name: observation_fact text_search_index; Type: DEFAULT; Schema: i2b2miracum; Owner: i2b2miracum
--

ALTER TABLE ONLY i2b2miracum.observation_fact ALTER COLUMN text_search_index SET DEFAULT nextval('i2b2miracum.observation_fact_text_search_index_seq'::regclass);


--
-- TOC entry 3543 (class 2604 OID 17469)
-- Name: ont_process_status process_id; Type: DEFAULT; Schema: i2b2miracum; Owner: i2b2miracum
--

ALTER TABLE ONLY i2b2miracum.ont_process_status ALTER COLUMN process_id SET DEFAULT nextval('i2b2miracum.ont_process_status_process_id_seq'::regclass);


--
-- TOC entry 3535 (class 2604 OID 17284)
-- Name: qt_patient_enc_collection patient_enc_coll_id; Type: DEFAULT; Schema: i2b2miracum; Owner: i2b2miracum
--

ALTER TABLE ONLY i2b2miracum.qt_patient_enc_collection ALTER COLUMN patient_enc_coll_id SET DEFAULT nextval('i2b2miracum.qt_patient_enc_collection_patient_enc_coll_id_seq'::regclass);


--
-- TOC entry 3536 (class 2604 OID 17285)
-- Name: qt_patient_set_collection patient_set_coll_id; Type: DEFAULT; Schema: i2b2miracum; Owner: i2b2miracum
--

ALTER TABLE ONLY i2b2miracum.qt_patient_set_collection ALTER COLUMN patient_set_coll_id SET DEFAULT nextval('i2b2miracum.qt_patient_set_collection_patient_set_coll_id_seq'::regclass);


--
-- TOC entry 3537 (class 2604 OID 17286)
-- Name: qt_pdo_query_master query_master_id; Type: DEFAULT; Schema: i2b2miracum; Owner: i2b2miracum
--

ALTER TABLE ONLY i2b2miracum.qt_pdo_query_master ALTER COLUMN query_master_id SET DEFAULT nextval('i2b2miracum.qt_pdo_query_master_query_master_id_seq'::regclass);


--
-- TOC entry 3538 (class 2604 OID 17287)
-- Name: qt_query_instance query_instance_id; Type: DEFAULT; Schema: i2b2miracum; Owner: i2b2miracum
--

ALTER TABLE ONLY i2b2miracum.qt_query_instance ALTER COLUMN query_instance_id SET DEFAULT nextval('i2b2miracum.qt_query_instance_query_instance_id_seq'::regclass);


--
-- TOC entry 3539 (class 2604 OID 17288)
-- Name: qt_query_master query_master_id; Type: DEFAULT; Schema: i2b2miracum; Owner: i2b2miracum
--

ALTER TABLE ONLY i2b2miracum.qt_query_master ALTER COLUMN query_master_id SET DEFAULT nextval('i2b2miracum.qt_query_master_query_master_id_seq'::regclass);


--
-- TOC entry 3540 (class 2604 OID 17289)
-- Name: qt_query_result_instance result_instance_id; Type: DEFAULT; Schema: i2b2miracum; Owner: i2b2miracum
--

ALTER TABLE ONLY i2b2miracum.qt_query_result_instance ALTER COLUMN result_instance_id SET DEFAULT nextval('i2b2miracum.qt_query_result_instance_result_instance_id_seq'::regclass);


--
-- TOC entry 3541 (class 2604 OID 17290)
-- Name: qt_xml_result xml_result_id; Type: DEFAULT; Schema: i2b2miracum; Owner: i2b2miracum
--

ALTER TABLE ONLY i2b2miracum.qt_xml_result ALTER COLUMN xml_result_id SET DEFAULT nextval('i2b2miracum.qt_xml_result_xml_result_id_seq'::regclass);


--
-- TOC entry 3542 (class 2604 OID 17291)
-- Name: upload_status upload_id; Type: DEFAULT; Schema: i2b2miracum; Owner: i2b2miracum
--

ALTER TABLE ONLY i2b2miracum.upload_status ALTER COLUMN upload_id SET DEFAULT nextval('i2b2miracum.upload_status_upload_id_seq'::regclass);


--
-- TOC entry 3791 (class 0 OID 17112)
-- Dependencies: 293
-- Data for Name: archive_observation_fact; Type: TABLE DATA; Schema: i2b2miracum; Owner: i2b2miracum
--



--
-- TOC entry 3830 (class 0 OID 17428)
-- Dependencies: 332
-- Data for Name: birn; Type: TABLE DATA; Schema: i2b2miracum; Owner: i2b2miracum
--



--
-- TOC entry 3792 (class 0 OID 17118)
-- Dependencies: 294
-- Data for Name: code_lookup; Type: TABLE DATA; Schema: i2b2miracum; Owner: i2b2miracum
--

--
-- TOC entry 3793 (class 0 OID 17124)
-- Dependencies: 295
-- Data for Name: concept_dimension; Type: TABLE DATA; Schema: i2b2miracum; Owner: i2b2miracum
--



--
-- TOC entry 3831 (class 0 OID 17434)
-- Dependencies: 333
-- Data for Name: custom_meta; Type: TABLE DATA; Schema: i2b2miracum; Owner: i2b2miracum
--



--
-- TOC entry 3794 (class 0 OID 17130)
-- Dependencies: 296
-- Data for Name: datamart_report; Type: TABLE DATA; Schema: i2b2miracum; Owner: i2b2miracum
--



--
-- TOC entry 3795 (class 0 OID 17133)
-- Dependencies: 297
-- Data for Name: encounter_mapping; Type: TABLE DATA; Schema: i2b2miracum; Owner: i2b2miracum
--



--
-- TOC entry 3832 (class 0 OID 17440)
-- Dependencies: 334
-- Data for Name: i2b2; Type: TABLE DATA; Schema: i2b2miracum; Owner: i2b2miracum
--



--
-- TOC entry 3833 (class 0 OID 17446)
-- Dependencies: 335
-- Data for Name: icd10_icd9; Type: TABLE DATA; Schema: i2b2miracum; Owner: i2b2miracum
--



--
-- TOC entry 3838 (class 0 OID 17488)
-- Dependencies: 340
-- Data for Name: im_audit; Type: TABLE DATA; Schema: i2b2miracum; Owner: i2b2miracum
--



--
-- TOC entry 3839 (class 0 OID 17495)
-- Dependencies: 341
-- Data for Name: im_mpi_demographics; Type: TABLE DATA; Schema: i2b2miracum; Owner: i2b2miracum
--



--
-- TOC entry 3840 (class 0 OID 17501)
-- Dependencies: 342
-- Data for Name: im_mpi_mapping; Type: TABLE DATA; Schema: i2b2miracum; Owner: i2b2miracum
--



--
-- TOC entry 3841 (class 0 OID 17507)
-- Dependencies: 343
-- Data for Name: im_project_patients; Type: TABLE DATA; Schema: i2b2miracum; Owner: i2b2miracum
--



--
-- TOC entry 3842 (class 0 OID 17510)
-- Dependencies: 344
-- Data for Name: im_project_sites; Type: TABLE DATA; Schema: i2b2miracum; Owner: i2b2miracum
--



--
-- TOC entry 3796 (class 0 OID 17139)
-- Dependencies: 298
-- Data for Name: modifier_dimension; Type: TABLE DATA; Schema: i2b2miracum; Owner: i2b2miracum
--



--
-- TOC entry 3797 (class 0 OID 17145)
-- Dependencies: 299
-- Data for Name: observation_fact; Type: TABLE DATA; Schema: i2b2miracum; Owner: i2b2miracum
--



--
-- TOC entry 3834 (class 0 OID 17452)
-- Dependencies: 336
-- Data for Name: ont_process_status; Type: TABLE DATA; Schema: i2b2miracum; Owner: i2b2miracum
--



--
-- TOC entry 3799 (class 0 OID 17155)
-- Dependencies: 301
-- Data for Name: patient_dimension; Type: TABLE DATA; Schema: i2b2miracum; Owner: i2b2miracum
--



--
-- TOC entry 3800 (class 0 OID 17161)
-- Dependencies: 302
-- Data for Name: patient_mapping; Type: TABLE DATA; Schema: i2b2miracum; Owner: i2b2miracum
--



--
-- TOC entry 3801 (class 0 OID 17164)
-- Dependencies: 303
-- Data for Name: provider_dimension; Type: TABLE DATA; Schema: i2b2miracum; Owner: i2b2miracum
--



--
-- TOC entry 3802 (class 0 OID 17170)
-- Dependencies: 304
-- Data for Name: qt_analysis_plugin; Type: TABLE DATA; Schema: i2b2miracum; Owner: i2b2miracum
--



--
-- TOC entry 3803 (class 0 OID 17176)
-- Dependencies: 305
-- Data for Name: qt_analysis_plugin_result_type; Type: TABLE DATA; Schema: i2b2miracum; Owner: i2b2miracum
--



--
-- TOC entry 3804 (class 0 OID 17179)
-- Dependencies: 306
-- Data for Name: qt_breakdown_path; Type: TABLE DATA; Schema: i2b2miracum; Owner: i2b2miracum
--



--
-- TOC entry 3805 (class 0 OID 17185)
-- Dependencies: 307
-- Data for Name: qt_patient_enc_collection; Type: TABLE DATA; Schema: i2b2miracum; Owner: i2b2miracum
--



--
-- TOC entry 3807 (class 0 OID 17190)
-- Dependencies: 309
-- Data for Name: qt_patient_set_collection; Type: TABLE DATA; Schema: i2b2miracum; Owner: i2b2miracum
--



--
-- TOC entry 3809 (class 0 OID 17195)
-- Dependencies: 311
-- Data for Name: qt_pdo_query_master; Type: TABLE DATA; Schema: i2b2miracum; Owner: i2b2miracum
--



--
-- TOC entry 3811 (class 0 OID 17203)
-- Dependencies: 313
-- Data for Name: qt_privilege; Type: TABLE DATA; Schema: i2b2miracum; Owner: i2b2miracum
--

INSERT INTO i2b2miracum.qt_privilege VALUES ('PDO_WITHOUT_BLOB', 'DATA_LDS', 'USER', NULL);
INSERT INTO i2b2miracum.qt_privilege VALUES ('PDO_WITH_BLOB', 'DATA_DEID', 'USER', NULL);
INSERT INTO i2b2miracum.qt_privilege VALUES ('SETFINDER_QRY_WITH_DATAOBFSC', 'DATA_OBFSC', 'USER', NULL);
INSERT INTO i2b2miracum.qt_privilege VALUES ('SETFINDER_QRY_WITHOUT_DATAOBFSC', 'DATA_AGG', 'USER', NULL);
INSERT INTO i2b2miracum.qt_privilege VALUES ('UPLOAD', 'DATA_OBFSC', 'MANAGER', NULL);
INSERT INTO i2b2miracum.qt_privilege VALUES ('SETFINDER_QRY_WITH_LGTEXT', 'DATA_DEID', 'USER', NULL);
INSERT INTO i2b2miracum.qt_privilege VALUES ('SETFINDER_QRY_PROTECTED', 'DATA_PROT', 'USER', NULL);


--
-- TOC entry 3812 (class 0 OID 17209)
-- Dependencies: 314
-- Data for Name: qt_query_instance; Type: TABLE DATA; Schema: i2b2miracum; Owner: i2b2miracum
--



--
-- TOC entry 3814 (class 0 OID 17217)
-- Dependencies: 316
-- Data for Name: qt_query_master; Type: TABLE DATA; Schema: i2b2miracum; Owner: i2b2miracum
--



--
-- TOC entry 3816 (class 0 OID 17225)
-- Dependencies: 318
-- Data for Name: qt_query_result_instance; Type: TABLE DATA; Schema: i2b2miracum; Owner: i2b2miracum
--



--
-- TOC entry 3818 (class 0 OID 17233)
-- Dependencies: 320
-- Data for Name: qt_query_result_type; Type: TABLE DATA; Schema: i2b2miracum; Owner: i2b2miracum
--

INSERT INTO i2b2miracum.qt_query_result_type VALUES (1, 'PATIENTSET', 'Patient set', 'LIST', 'LA', NULL, 'edu.harvard.i2b2.crc.dao.setfinder.QueryResultPatientSetGenerator');
INSERT INTO i2b2miracum.qt_query_result_type VALUES (2, 'PATIENT_ENCOUNTER_SET', 'Encounter set', 'LIST', 'LA', NULL, 'edu.harvard.i2b2.crc.dao.setfinder.QueryResultEncounterSetGenerator');
INSERT INTO i2b2miracum.qt_query_result_type VALUES (3, 'XML', 'Generic query result', 'CATNUM', 'LH', NULL, NULL);
INSERT INTO i2b2miracum.qt_query_result_type VALUES (4, 'PATIENT_COUNT_XML', 'Number of patients', 'CATNUM', 'LA', NULL, 'edu.harvard.i2b2.crc.dao.setfinder.QueryResultPatientCountGenerator');
INSERT INTO i2b2miracum.qt_query_result_type VALUES (5, 'PATIENT_GENDER_COUNT_XML', 'Gender patient breakdown', 'CATNUM', 'LA', NULL, 'edu.harvard.i2b2.crc.dao.setfinder.QueryResultGenerator');
INSERT INTO i2b2miracum.qt_query_result_type VALUES (6, 'PATIENT_VITALSTATUS_COUNT_XML', 'Vital Status patient breakdown', 'CATNUM', 'LA', NULL, 'edu.harvard.i2b2.crc.dao.setfinder.QueryResultGenerator');
INSERT INTO i2b2miracum.qt_query_result_type VALUES (7, 'PATIENT_RACE_COUNT_XML', 'Race patient breakdown', 'CATNUM', 'LA', NULL, 'edu.harvard.i2b2.crc.dao.setfinder.QueryResultGenerator');
INSERT INTO i2b2miracum.qt_query_result_type VALUES (8, 'PATIENT_AGE_COUNT_XML', 'Age patient breakdown', 'CATNUM', 'LA', NULL, 'edu.harvard.i2b2.crc.dao.setfinder.QueryResultGenerator');
INSERT INTO i2b2miracum.qt_query_result_type VALUES (9, 'PATIENTSET', 'Timeline', 'LIST', 'LA', NULL, 'edu.harvard.i2b2.crc.dao.setfinder.QueryResultPatientSetGenerator');
INSERT INTO i2b2miracum.qt_query_result_type VALUES (10, 'PATIENT_LOS_XML', 'Length of stay breakdown', 'CATNUM', 'LA', 'DATA_LDS', 'edu.harvard.i2b2.crc.dao.setfinder.QueryResultPatientSQLCountGenerator');
INSERT INTO i2b2miracum.qt_query_result_type VALUES (11, 'PATIENT_TOP20MEDS_XML', 'Top 20 medications breakdown', 'CATNUM', 'LA', 'DATA_LDS', 'edu.harvard.i2b2.crc.dao.setfinder.QueryResultPatientSQLCountGenerator');
INSERT INTO i2b2miracum.qt_query_result_type VALUES (12, 'PATIENT_TOP20DIAG_XML', 'Top 20 diagnoses breakdown', 'CATNUM', 'LA', 'DATA_LDS', 'edu.harvard.i2b2.crc.dao.setfinder.QueryResultPatientSQLCountGenerator');
INSERT INTO i2b2miracum.qt_query_result_type VALUES (13, 'PATIENT_INOUT_XML', 'Inpatient and outpatient breakdown', 'CATNUM', 'LA', 'DATA_LDS', 'edu.harvard.i2b2.crc.dao.setfinder.QueryResultPatientSQLCountGenerator');


--
-- TOC entry 3819 (class 0 OID 17239)
-- Dependencies: 321
-- Data for Name: qt_query_status_type; Type: TABLE DATA; Schema: i2b2miracum; Owner: i2b2miracum
--

INSERT INTO i2b2miracum.qt_query_status_type VALUES (1, 'QUEUED', ' WAITING IN QUEUE TO START PROCESS');
INSERT INTO i2b2miracum.qt_query_status_type VALUES (2, 'PROCESSING', 'PROCESSING');
INSERT INTO i2b2miracum.qt_query_status_type VALUES (3, 'FINISHED', 'FINISHED');
INSERT INTO i2b2miracum.qt_query_status_type VALUES (4, 'ERROR', 'ERROR');
INSERT INTO i2b2miracum.qt_query_status_type VALUES (5, 'INCOMPLETE', 'INCOMPLETE');
INSERT INTO i2b2miracum.qt_query_status_type VALUES (6, 'COMPLETED', 'COMPLETED');
INSERT INTO i2b2miracum.qt_query_status_type VALUES (7, 'MEDIUM_QUEUE', 'MEDIUM QUEUE');
INSERT INTO i2b2miracum.qt_query_status_type VALUES (8, 'LARGE_QUEUE', 'LARGE QUEUE');
INSERT INTO i2b2miracum.qt_query_status_type VALUES (9, 'CANCELLED', 'CANCELLED');
INSERT INTO i2b2miracum.qt_query_status_type VALUES (10, 'TIMEDOUT', 'TIMEDOUT');


--
-- TOC entry 3820 (class 0 OID 17242)
-- Dependencies: 322
-- Data for Name: qt_xml_result; Type: TABLE DATA; Schema: i2b2miracum; Owner: i2b2miracum
--



--
-- TOC entry 3836 (class 0 OID 17460)
-- Dependencies: 338
-- Data for Name: schemes; Type: TABLE DATA; Schema: i2b2miracum; Owner: i2b2miracum
--



--
-- TOC entry 3824 (class 0 OID 17254)
-- Dependencies: 326
-- Data for Name: set_type; Type: TABLE DATA; Schema: i2b2miracum; Owner: i2b2miracum
--

INSERT INTO i2b2miracum.set_type VALUES (1, 'event_set', '2022-05-27 12:34:53.686804');
INSERT INTO i2b2miracum.set_type VALUES (2, 'patient_set', '2022-05-27 12:34:53.688425');
INSERT INTO i2b2miracum.set_type VALUES (3, 'concept_set', '2022-05-27 12:34:53.68962');
INSERT INTO i2b2miracum.set_type VALUES (4, 'observer_set', '2022-05-27 12:34:53.690833');
INSERT INTO i2b2miracum.set_type VALUES (5, 'observation_set', '2022-05-27 12:34:53.691936');
INSERT INTO i2b2miracum.set_type VALUES (6, 'pid_set', '2022-05-27 12:34:53.693137');
INSERT INTO i2b2miracum.set_type VALUES (7, 'eid_set', '2022-05-27 12:34:53.694291');
INSERT INTO i2b2miracum.set_type VALUES (8, 'modifier_set', '2022-05-27 12:34:53.696205');


--
-- TOC entry 3825 (class 0 OID 17260)
-- Dependencies: 327
-- Data for Name: set_upload_status; Type: TABLE DATA; Schema: i2b2miracum; Owner: i2b2miracum
--



--
-- TOC entry 3826 (class 0 OID 17266)
-- Dependencies: 328
-- Data for Name: source_master; Type: TABLE DATA; Schema: i2b2miracum; Owner: i2b2miracum
--



--
-- TOC entry 3837 (class 0 OID 17463)
-- Dependencies: 339
-- Data for Name: table_access; Type: TABLE DATA; Schema: i2b2miracum; Owner: i2b2miracum
--

INSERT INTO i2b2miracum.table_access VALUES ('i2b2', 'i2b2', 'N', NULL, 0, '\i2b2\', 'Ontology', 'N', 'CA ', NULL, NULL, NULL, 'concept_cd', 'concept_dimension', 'concept_path', 'T', 'LIKE', '\i2b2\', NULL, 'Ontology', NULL, NULL, NULL, NULL);


--
-- TOC entry 3827 (class 0 OID 17269)
-- Dependencies: 329
-- Data for Name: upload_status; Type: TABLE DATA; Schema: i2b2miracum; Owner: i2b2miracum
--



--
-- TOC entry 3829 (class 0 OID 17277)
-- Dependencies: 331
-- Data for Name: visit_dimension; Type: TABLE DATA; Schema: i2b2miracum; Owner: i2b2miracum
--



--
-- TOC entry 3789 (class 0 OID 17069)
-- Dependencies: 291
-- Data for Name: workplace; Type: TABLE DATA; Schema: i2b2miracum; Owner: i2b2miracum
--



--
-- TOC entry 3790 (class 0 OID 17075)
-- Dependencies: 292
-- Data for Name: workplace_access; Type: TABLE DATA; Schema: i2b2miracum; Owner: i2b2miracum
--

INSERT INTO i2b2miracum.workplace_access VALUES ('demo', 'WORKPLACE', 'N', 0, 'SHARED', 'shared', 'demo', 'Y', '100', NULL, 'CA ', 'SHARED', NULL, NULL, NULL);
INSERT INTO i2b2miracum.workplace_access VALUES ('demo', 'WORKPLACE', 'N', 0, '@', '@', '@', 'N', '0', NULL, 'CA ', '@', NULL, NULL, NULL);


--
-- TOC entry 3859 (class 0 OID 0)
-- Dependencies: 300
-- Name: observation_fact_text_search_index_seq; Type: SEQUENCE SET; Schema: i2b2miracum; Owner: i2b2miracum
--

SELECT pg_catalog.setval('i2b2miracum.observation_fact_text_search_index_seq', 1, false);


--
-- TOC entry 3860 (class 0 OID 0)
-- Dependencies: 337
-- Name: ont_process_status_process_id_seq; Type: SEQUENCE SET; Schema: i2b2miracum; Owner: i2b2miracum
--

SELECT pg_catalog.setval('i2b2miracum.ont_process_status_process_id_seq', 1, false);


--
-- TOC entry 3861 (class 0 OID 0)
-- Dependencies: 308
-- Name: qt_patient_enc_collection_patient_enc_coll_id_seq; Type: SEQUENCE SET; Schema: i2b2miracum; Owner: i2b2miracum
--

SELECT pg_catalog.setval('i2b2miracum.qt_patient_enc_collection_patient_enc_coll_id_seq', 1, false);


--
-- TOC entry 3862 (class 0 OID 0)
-- Dependencies: 310
-- Name: qt_patient_set_collection_patient_set_coll_id_seq; Type: SEQUENCE SET; Schema: i2b2miracum; Owner: i2b2miracum
--

SELECT pg_catalog.setval('i2b2miracum.qt_patient_set_collection_patient_set_coll_id_seq', 1, false);


--
-- TOC entry 3863 (class 0 OID 0)
-- Dependencies: 312
-- Name: qt_pdo_query_master_query_master_id_seq; Type: SEQUENCE SET; Schema: i2b2miracum; Owner: i2b2miracum
--

SELECT pg_catalog.setval('i2b2miracum.qt_pdo_query_master_query_master_id_seq', 1, false);


--
-- TOC entry 3864 (class 0 OID 0)
-- Dependencies: 315
-- Name: qt_query_instance_query_instance_id_seq; Type: SEQUENCE SET; Schema: i2b2miracum; Owner: i2b2miracum
--

SELECT pg_catalog.setval('i2b2miracum.qt_query_instance_query_instance_id_seq', 1, false);


--
-- TOC entry 3865 (class 0 OID 0)
-- Dependencies: 317
-- Name: qt_query_master_query_master_id_seq; Type: SEQUENCE SET; Schema: i2b2miracum; Owner: i2b2miracum
--

SELECT pg_catalog.setval('i2b2miracum.qt_query_master_query_master_id_seq', 1, false);


--
-- TOC entry 3866 (class 0 OID 0)
-- Dependencies: 319
-- Name: qt_query_result_instance_result_instance_id_seq; Type: SEQUENCE SET; Schema: i2b2miracum; Owner: i2b2miracum
--

SELECT pg_catalog.setval('i2b2miracum.qt_query_result_instance_result_instance_id_seq', 1, false);


--
-- TOC entry 3867 (class 0 OID 0)
-- Dependencies: 323
-- Name: qt_xml_result_xml_result_id_seq; Type: SEQUENCE SET; Schema: i2b2miracum; Owner: i2b2miracum
--

SELECT pg_catalog.setval('i2b2miracum.qt_xml_result_xml_result_id_seq', 1, false);


--
-- TOC entry 3868 (class 0 OID 0)
-- Dependencies: 324
-- Name: seq_encounter_num; Type: SEQUENCE SET; Schema: i2b2miracum; Owner: i2b2miracum
--

SELECT pg_catalog.setval('i2b2miracum.seq_encounter_num', 1, false);


--
-- TOC entry 3869 (class 0 OID 0)
-- Dependencies: 325
-- Name: seq_patient_num; Type: SEQUENCE SET; Schema: i2b2miracum; Owner: i2b2miracum
--

SELECT pg_catalog.setval('i2b2miracum.seq_patient_num', 10, false);


--
-- TOC entry 3870 (class 0 OID 0)
-- Dependencies: 330
-- Name: upload_status_upload_id_seq; Type: SEQUENCE SET; Schema: i2b2miracum; Owner: i2b2miracum
--

SELECT pg_catalog.setval('i2b2miracum.upload_status_upload_id_seq', 1, false);


--
-- TOC entry 3591 (class 2606 OID 17293)
-- Name: qt_analysis_plugin analysis_plugin_pk; Type: CONSTRAINT; Schema: i2b2miracum; Owner: i2b2miracum
--

ALTER TABLE ONLY i2b2miracum.qt_analysis_plugin
    ADD CONSTRAINT analysis_plugin_pk PRIMARY KEY (plugin_id);


--
-- TOC entry 3594 (class 2606 OID 17295)
-- Name: qt_analysis_plugin_result_type analysis_plugin_result_pk; Type: CONSTRAINT; Schema: i2b2miracum; Owner: i2b2miracum
--

ALTER TABLE ONLY i2b2miracum.qt_analysis_plugin_result_type
    ADD CONSTRAINT analysis_plugin_result_pk PRIMARY KEY (plugin_id, result_type_id);


--
-- TOC entry 3553 (class 2606 OID 17297)
-- Name: code_lookup code_lookup_pk; Type: CONSTRAINT; Schema: i2b2miracum; Owner: i2b2miracum
--

ALTER TABLE ONLY i2b2miracum.code_lookup
    ADD CONSTRAINT code_lookup_pk PRIMARY KEY (table_cd, column_cd, code_cd);


--
-- TOC entry 3556 (class 2606 OID 17299)
-- Name: concept_dimension concept_dimension_pk; Type: CONSTRAINT; Schema: i2b2miracum; Owner: i2b2miracum
--

ALTER TABLE ONLY i2b2miracum.concept_dimension
    ADD CONSTRAINT concept_dimension_pk PRIMARY KEY (concept_path);


--
-- TOC entry 3561 (class 2606 OID 17301)
-- Name: encounter_mapping encounter_mapping_pk; Type: CONSTRAINT; Schema: i2b2miracum; Owner: i2b2miracum
--

ALTER TABLE ONLY i2b2miracum.encounter_mapping
    ADD CONSTRAINT encounter_mapping_pk PRIMARY KEY (encounter_ide, encounter_ide_source, project_id, patient_ide, patient_ide_source);


--
-- TOC entry 3652 (class 2606 OID 17514)
-- Name: im_mpi_demographics im_mpi_demographics_pk; Type: CONSTRAINT; Schema: i2b2miracum; Owner: i2b2miracum
--

ALTER TABLE ONLY i2b2miracum.im_mpi_demographics
    ADD CONSTRAINT im_mpi_demographics_pk PRIMARY KEY (global_id);


--
-- TOC entry 3654 (class 2606 OID 17516)
-- Name: im_mpi_mapping im_mpi_mapping_pk; Type: CONSTRAINT; Schema: i2b2miracum; Owner: i2b2miracum
--

ALTER TABLE ONLY i2b2miracum.im_mpi_mapping
    ADD CONSTRAINT im_mpi_mapping_pk PRIMARY KEY (lcl_site, lcl_id, update_date);


--
-- TOC entry 3656 (class 2606 OID 17518)
-- Name: im_project_patients im_project_patients_pk; Type: CONSTRAINT; Schema: i2b2miracum; Owner: i2b2miracum
--

ALTER TABLE ONLY i2b2miracum.im_project_patients
    ADD CONSTRAINT im_project_patients_pk PRIMARY KEY (project_id, global_id);


--
-- TOC entry 3658 (class 2606 OID 17520)
-- Name: im_project_sites im_project_sites_pk; Type: CONSTRAINT; Schema: i2b2miracum; Owner: i2b2miracum
--

ALTER TABLE ONLY i2b2miracum.im_project_sites
    ADD CONSTRAINT im_project_sites_pk PRIMARY KEY (project_id, lcl_site);


--
-- TOC entry 3564 (class 2606 OID 17303)
-- Name: modifier_dimension modifier_dimension_pk; Type: CONSTRAINT; Schema: i2b2miracum; Owner: i2b2miracum
--

ALTER TABLE ONLY i2b2miracum.modifier_dimension
    ADD CONSTRAINT modifier_dimension_pk PRIMARY KEY (modifier_path);


--
-- TOC entry 3566 (class 2606 OID 17305)
-- Name: observation_fact observation_fact_pk; Type: CONSTRAINT; Schema: i2b2miracum; Owner: i2b2miracum
--

ALTER TABLE ONLY i2b2miracum.observation_fact
    ADD CONSTRAINT observation_fact_pk PRIMARY KEY (patient_num, concept_cd, modifier_cd, start_date, encounter_num, instance_num, provider_id);


--
-- TOC entry 3648 (class 2606 OID 17471)
-- Name: ont_process_status ont_process_status_pkey; Type: CONSTRAINT; Schema: i2b2miracum; Owner: i2b2miracum
--

ALTER TABLE ONLY i2b2miracum.ont_process_status
    ADD CONSTRAINT ont_process_status_pkey PRIMARY KEY (process_id);


--
-- TOC entry 3577 (class 2606 OID 17307)
-- Name: patient_dimension patient_dimension_pk; Type: CONSTRAINT; Schema: i2b2miracum; Owner: i2b2miracum
--

ALTER TABLE ONLY i2b2miracum.patient_dimension
    ADD CONSTRAINT patient_dimension_pk PRIMARY KEY (patient_num);


--
-- TOC entry 3582 (class 2606 OID 17309)
-- Name: patient_mapping patient_mapping_pk; Type: CONSTRAINT; Schema: i2b2miracum; Owner: i2b2miracum
--

ALTER TABLE ONLY i2b2miracum.patient_mapping
    ADD CONSTRAINT patient_mapping_pk PRIMARY KEY (patient_ide, patient_ide_source, project_id);


--
-- TOC entry 3625 (class 2606 OID 17311)
-- Name: source_master pk_sourcemaster_sourcecd; Type: CONSTRAINT; Schema: i2b2miracum; Owner: i2b2miracum
--

ALTER TABLE ONLY i2b2miracum.source_master
    ADD CONSTRAINT pk_sourcemaster_sourcecd PRIMARY KEY (source_cd);


--
-- TOC entry 3621 (class 2606 OID 17313)
-- Name: set_type pk_st_id; Type: CONSTRAINT; Schema: i2b2miracum; Owner: i2b2miracum
--

ALTER TABLE ONLY i2b2miracum.set_type
    ADD CONSTRAINT pk_st_id PRIMARY KEY (id);


--
-- TOC entry 3623 (class 2606 OID 17315)
-- Name: set_upload_status pk_up_upstatus_idsettypeid; Type: CONSTRAINT; Schema: i2b2miracum; Owner: i2b2miracum
--

ALTER TABLE ONLY i2b2miracum.set_upload_status
    ADD CONSTRAINT pk_up_upstatus_idsettypeid PRIMARY KEY (upload_id, set_type_id);


--
-- TOC entry 3589 (class 2606 OID 17317)
-- Name: provider_dimension provider_dimension_pk; Type: CONSTRAINT; Schema: i2b2miracum; Owner: i2b2miracum
--

ALTER TABLE ONLY i2b2miracum.provider_dimension
    ADD CONSTRAINT provider_dimension_pk PRIMARY KEY (provider_path, provider_id);


--
-- TOC entry 3596 (class 2606 OID 17319)
-- Name: qt_patient_enc_collection qt_patient_enc_collection_pkey; Type: CONSTRAINT; Schema: i2b2miracum; Owner: i2b2miracum
--

ALTER TABLE ONLY i2b2miracum.qt_patient_enc_collection
    ADD CONSTRAINT qt_patient_enc_collection_pkey PRIMARY KEY (patient_enc_coll_id);


--
-- TOC entry 3599 (class 2606 OID 17321)
-- Name: qt_patient_set_collection qt_patient_set_collection_pkey; Type: CONSTRAINT; Schema: i2b2miracum; Owner: i2b2miracum
--

ALTER TABLE ONLY i2b2miracum.qt_patient_set_collection
    ADD CONSTRAINT qt_patient_set_collection_pkey PRIMARY KEY (patient_set_coll_id);


--
-- TOC entry 3602 (class 2606 OID 17323)
-- Name: qt_pdo_query_master qt_pdo_query_master_pkey; Type: CONSTRAINT; Schema: i2b2miracum; Owner: i2b2miracum
--

ALTER TABLE ONLY i2b2miracum.qt_pdo_query_master
    ADD CONSTRAINT qt_pdo_query_master_pkey PRIMARY KEY (query_master_id);


--
-- TOC entry 3604 (class 2606 OID 17325)
-- Name: qt_privilege qt_privilege_pkey; Type: CONSTRAINT; Schema: i2b2miracum; Owner: i2b2miracum
--

ALTER TABLE ONLY i2b2miracum.qt_privilege
    ADD CONSTRAINT qt_privilege_pkey PRIMARY KEY (protection_label_cd);


--
-- TOC entry 3608 (class 2606 OID 17327)
-- Name: qt_query_instance qt_query_instance_pkey; Type: CONSTRAINT; Schema: i2b2miracum; Owner: i2b2miracum
--

ALTER TABLE ONLY i2b2miracum.qt_query_instance
    ADD CONSTRAINT qt_query_instance_pkey PRIMARY KEY (query_instance_id);


--
-- TOC entry 3611 (class 2606 OID 17329)
-- Name: qt_query_master qt_query_master_pkey; Type: CONSTRAINT; Schema: i2b2miracum; Owner: i2b2miracum
--

ALTER TABLE ONLY i2b2miracum.qt_query_master
    ADD CONSTRAINT qt_query_master_pkey PRIMARY KEY (query_master_id);


--
-- TOC entry 3613 (class 2606 OID 17331)
-- Name: qt_query_result_instance qt_query_result_instance_pkey; Type: CONSTRAINT; Schema: i2b2miracum; Owner: i2b2miracum
--

ALTER TABLE ONLY i2b2miracum.qt_query_result_instance
    ADD CONSTRAINT qt_query_result_instance_pkey PRIMARY KEY (result_instance_id);


--
-- TOC entry 3615 (class 2606 OID 17333)
-- Name: qt_query_result_type qt_query_result_type_pkey; Type: CONSTRAINT; Schema: i2b2miracum; Owner: i2b2miracum
--

ALTER TABLE ONLY i2b2miracum.qt_query_result_type
    ADD CONSTRAINT qt_query_result_type_pkey PRIMARY KEY (result_type_id);


--
-- TOC entry 3617 (class 2606 OID 17335)
-- Name: qt_query_status_type qt_query_status_type_pkey; Type: CONSTRAINT; Schema: i2b2miracum; Owner: i2b2miracum
--

ALTER TABLE ONLY i2b2miracum.qt_query_status_type
    ADD CONSTRAINT qt_query_status_type_pkey PRIMARY KEY (status_type_id);


--
-- TOC entry 3619 (class 2606 OID 17337)
-- Name: qt_xml_result qt_xml_result_pkey; Type: CONSTRAINT; Schema: i2b2miracum; Owner: i2b2miracum
--

ALTER TABLE ONLY i2b2miracum.qt_xml_result
    ADD CONSTRAINT qt_xml_result_pkey PRIMARY KEY (xml_result_id);


--
-- TOC entry 3650 (class 2606 OID 17473)
-- Name: schemes schemes_pk; Type: CONSTRAINT; Schema: i2b2miracum; Owner: i2b2miracum
--

ALTER TABLE ONLY i2b2miracum.schemes
    ADD CONSTRAINT schemes_pk PRIMARY KEY (c_key);


--
-- TOC entry 3627 (class 2606 OID 17339)
-- Name: upload_status upload_status_pkey; Type: CONSTRAINT; Schema: i2b2miracum; Owner: i2b2miracum
--

ALTER TABLE ONLY i2b2miracum.upload_status
    ADD CONSTRAINT upload_status_pkey PRIMARY KEY (upload_id);


--
-- TOC entry 3632 (class 2606 OID 17341)
-- Name: visit_dimension visit_dimension_pk; Type: CONSTRAINT; Schema: i2b2miracum; Owner: i2b2miracum
--

ALTER TABLE ONLY i2b2miracum.visit_dimension
    ADD CONSTRAINT visit_dimension_pk PRIMARY KEY (encounter_num, patient_num);


--
-- TOC entry 3548 (class 2606 OID 17082)
-- Name: workplace_access workplace_access_pk; Type: CONSTRAINT; Schema: i2b2miracum; Owner: i2b2miracum
--

ALTER TABLE ONLY i2b2miracum.workplace_access
    ADD CONSTRAINT workplace_access_pk PRIMARY KEY (c_index);


--
-- TOC entry 3546 (class 2606 OID 17084)
-- Name: workplace workplace_pk; Type: CONSTRAINT; Schema: i2b2miracum; Owner: i2b2miracum
--

ALTER TABLE ONLY i2b2miracum.workplace
    ADD CONSTRAINT workplace_pk PRIMARY KEY (c_index);


--
-- TOC entry 3554 (class 1259 OID 17342)
-- Name: cd_idx_uploadid; Type: INDEX; Schema: i2b2miracum; Owner: i2b2miracum
--

CREATE INDEX cd_idx_uploadid ON i2b2miracum.concept_dimension USING btree (upload_id);


--
-- TOC entry 3550 (class 1259 OID 17343)
-- Name: cl_idx_name_char; Type: INDEX; Schema: i2b2miracum; Owner: i2b2miracum
--

CREATE INDEX cl_idx_name_char ON i2b2miracum.code_lookup USING btree (name_char);


--
-- TOC entry 3551 (class 1259 OID 17344)
-- Name: cl_idx_uploadid; Type: INDEX; Schema: i2b2miracum; Owner: i2b2miracum
--

CREATE INDEX cl_idx_uploadid ON i2b2miracum.code_lookup USING btree (upload_id);


--
-- TOC entry 3557 (class 1259 OID 17345)
-- Name: em_encnum_idx; Type: INDEX; Schema: i2b2miracum; Owner: i2b2miracum
--

CREATE INDEX em_encnum_idx ON i2b2miracum.encounter_mapping USING btree (encounter_num);


--
-- TOC entry 3558 (class 1259 OID 17346)
-- Name: em_idx_encpath; Type: INDEX; Schema: i2b2miracum; Owner: i2b2miracum
--

CREATE INDEX em_idx_encpath ON i2b2miracum.encounter_mapping USING btree (encounter_ide, encounter_ide_source, patient_ide, patient_ide_source, encounter_num);


--
-- TOC entry 3559 (class 1259 OID 17347)
-- Name: em_idx_uploadid; Type: INDEX; Schema: i2b2miracum; Owner: i2b2miracum
--

CREATE INDEX em_idx_uploadid ON i2b2miracum.encounter_mapping USING btree (upload_id);


--
-- TOC entry 3562 (class 1259 OID 17348)
-- Name: md_idx_uploadid; Type: INDEX; Schema: i2b2miracum; Owner: i2b2miracum
--

CREATE INDEX md_idx_uploadid ON i2b2miracum.modifier_dimension USING btree (upload_id);


--
-- TOC entry 3642 (class 1259 OID 17474)
-- Name: meta_appl_path_icd10_icd9_idx; Type: INDEX; Schema: i2b2miracum; Owner: i2b2miracum
--

CREATE INDEX meta_appl_path_icd10_icd9_idx ON i2b2miracum.icd10_icd9 USING btree (m_applied_path);


--
-- TOC entry 3633 (class 1259 OID 17475)
-- Name: meta_applied_path_idx_birn; Type: INDEX; Schema: i2b2miracum; Owner: i2b2miracum
--

CREATE INDEX meta_applied_path_idx_birn ON i2b2miracum.birn USING btree (m_applied_path);


--
-- TOC entry 3635 (class 1259 OID 17476)
-- Name: meta_applied_path_idx_custom; Type: INDEX; Schema: i2b2miracum; Owner: i2b2miracum
--

CREATE INDEX meta_applied_path_idx_custom ON i2b2miracum.custom_meta USING btree (m_applied_path);


--
-- TOC entry 3637 (class 1259 OID 17477)
-- Name: meta_applied_path_idx_i2b2; Type: INDEX; Schema: i2b2miracum; Owner: i2b2miracum
--

CREATE INDEX meta_applied_path_idx_i2b2 ON i2b2miracum.i2b2 USING btree (m_applied_path);


--
-- TOC entry 3643 (class 1259 OID 17478)
-- Name: meta_exclusion_icd10_icd9_idx; Type: INDEX; Schema: i2b2miracum; Owner: i2b2miracum
--

CREATE INDEX meta_exclusion_icd10_icd9_idx ON i2b2miracum.icd10_icd9 USING btree (m_exclusion_cd);


--
-- TOC entry 3638 (class 1259 OID 17479)
-- Name: meta_exclusion_idx_i2b2; Type: INDEX; Schema: i2b2miracum; Owner: i2b2miracum
--

CREATE INDEX meta_exclusion_idx_i2b2 ON i2b2miracum.i2b2 USING btree (m_exclusion_cd);


--
-- TOC entry 3634 (class 1259 OID 17480)
-- Name: meta_fullname_idx_birn; Type: INDEX; Schema: i2b2miracum; Owner: i2b2miracum
--

CREATE INDEX meta_fullname_idx_birn ON i2b2miracum.birn USING btree (c_fullname);


--
-- TOC entry 3636 (class 1259 OID 17481)
-- Name: meta_fullname_idx_custom; Type: INDEX; Schema: i2b2miracum; Owner: i2b2miracum
--

CREATE INDEX meta_fullname_idx_custom ON i2b2miracum.custom_meta USING btree (c_fullname);


--
-- TOC entry 3639 (class 1259 OID 17482)
-- Name: meta_fullname_idx_i2b2; Type: INDEX; Schema: i2b2miracum; Owner: i2b2miracum
--

CREATE INDEX meta_fullname_idx_i2b2 ON i2b2miracum.i2b2 USING btree (c_fullname);


--
-- TOC entry 3644 (class 1259 OID 17483)
-- Name: meta_fullname_idx_icd10_icd9; Type: INDEX; Schema: i2b2miracum; Owner: i2b2miracum
--

CREATE INDEX meta_fullname_idx_icd10_icd9 ON i2b2miracum.icd10_icd9 USING btree (c_fullname);


--
-- TOC entry 3645 (class 1259 OID 17484)
-- Name: meta_hlevel_icd10_icd9_idx; Type: INDEX; Schema: i2b2miracum; Owner: i2b2miracum
--

CREATE INDEX meta_hlevel_icd10_icd9_idx ON i2b2miracum.icd10_icd9 USING btree (c_hlevel);


--
-- TOC entry 3640 (class 1259 OID 17485)
-- Name: meta_hlevel_idx_i2b2; Type: INDEX; Schema: i2b2miracum; Owner: i2b2miracum
--

CREATE INDEX meta_hlevel_idx_i2b2 ON i2b2miracum.i2b2 USING btree (c_hlevel);


--
-- TOC entry 3646 (class 1259 OID 17486)
-- Name: meta_synonym_icd10_icd9_idx; Type: INDEX; Schema: i2b2miracum; Owner: i2b2miracum
--

CREATE INDEX meta_synonym_icd10_icd9_idx ON i2b2miracum.icd10_icd9 USING btree (c_synonym_cd);


--
-- TOC entry 3641 (class 1259 OID 17487)
-- Name: meta_synonym_idx_i2b2; Type: INDEX; Schema: i2b2miracum; Owner: i2b2miracum
--

CREATE INDEX meta_synonym_idx_i2b2 ON i2b2miracum.i2b2 USING btree (c_synonym_cd);


--
-- TOC entry 3567 (class 1259 OID 17349)
-- Name: of_idx_allobservation_fact; Type: INDEX; Schema: i2b2miracum; Owner: i2b2miracum
--

CREATE INDEX of_idx_allobservation_fact ON i2b2miracum.observation_fact USING btree (patient_num, encounter_num, concept_cd, start_date, provider_id, modifier_cd, instance_num, valtype_cd, tval_char, nval_num, valueflag_cd, quantity_num, units_cd, end_date, location_cd, confidence_num);


--
-- TOC entry 3568 (class 1259 OID 17350)
-- Name: of_idx_clusteredconcept; Type: INDEX; Schema: i2b2miracum; Owner: i2b2miracum
--

CREATE INDEX of_idx_clusteredconcept ON i2b2miracum.observation_fact USING btree (concept_cd);


--
-- TOC entry 3569 (class 1259 OID 17351)
-- Name: of_idx_encounter_patient; Type: INDEX; Schema: i2b2miracum; Owner: i2b2miracum
--

CREATE INDEX of_idx_encounter_patient ON i2b2miracum.observation_fact USING btree (encounter_num, patient_num, instance_num);


--
-- TOC entry 3570 (class 1259 OID 17352)
-- Name: of_idx_modifier; Type: INDEX; Schema: i2b2miracum; Owner: i2b2miracum
--

CREATE INDEX of_idx_modifier ON i2b2miracum.observation_fact USING btree (modifier_cd);


--
-- TOC entry 3571 (class 1259 OID 17353)
-- Name: of_idx_sourcesystem_cd; Type: INDEX; Schema: i2b2miracum; Owner: i2b2miracum
--

CREATE INDEX of_idx_sourcesystem_cd ON i2b2miracum.observation_fact USING btree (sourcesystem_cd);


--
-- TOC entry 3572 (class 1259 OID 17354)
-- Name: of_idx_start_date; Type: INDEX; Schema: i2b2miracum; Owner: i2b2miracum
--

CREATE INDEX of_idx_start_date ON i2b2miracum.observation_fact USING btree (start_date, patient_num);


--
-- TOC entry 3573 (class 1259 OID 17355)
-- Name: of_idx_uploadid; Type: INDEX; Schema: i2b2miracum; Owner: i2b2miracum
--

CREATE INDEX of_idx_uploadid ON i2b2miracum.observation_fact USING btree (upload_id);


--
-- TOC entry 3574 (class 1259 OID 17356)
-- Name: of_text_search_unique; Type: INDEX; Schema: i2b2miracum; Owner: i2b2miracum
--

CREATE UNIQUE INDEX of_text_search_unique ON i2b2miracum.observation_fact USING btree (text_search_index);


--
-- TOC entry 3575 (class 1259 OID 17357)
-- Name: pa_idx_uploadid; Type: INDEX; Schema: i2b2miracum; Owner: i2b2miracum
--

CREATE INDEX pa_idx_uploadid ON i2b2miracum.patient_dimension USING btree (upload_id);


--
-- TOC entry 3578 (class 1259 OID 17358)
-- Name: pd_idx_allpatientdim; Type: INDEX; Schema: i2b2miracum; Owner: i2b2miracum
--

CREATE INDEX pd_idx_allpatientdim ON i2b2miracum.patient_dimension USING btree (patient_num, vital_status_cd, birth_date, death_date, sex_cd, age_in_years_num, language_cd, race_cd, marital_status_cd, income_cd, religion_cd, zip_cd);


--
-- TOC entry 3579 (class 1259 OID 17359)
-- Name: pd_idx_dates; Type: INDEX; Schema: i2b2miracum; Owner: i2b2miracum
--

CREATE INDEX pd_idx_dates ON i2b2miracum.patient_dimension USING btree (patient_num, vital_status_cd, birth_date, death_date);


--
-- TOC entry 3586 (class 1259 OID 17360)
-- Name: pd_idx_name_char; Type: INDEX; Schema: i2b2miracum; Owner: i2b2miracum
--

CREATE INDEX pd_idx_name_char ON i2b2miracum.provider_dimension USING btree (provider_id, name_char);


--
-- TOC entry 3580 (class 1259 OID 17361)
-- Name: pd_idx_statecityzip; Type: INDEX; Schema: i2b2miracum; Owner: i2b2miracum
--

CREATE INDEX pd_idx_statecityzip ON i2b2miracum.patient_dimension USING btree (statecityzip_path, patient_num);


--
-- TOC entry 3587 (class 1259 OID 17362)
-- Name: pd_idx_uploadid; Type: INDEX; Schema: i2b2miracum; Owner: i2b2miracum
--

CREATE INDEX pd_idx_uploadid ON i2b2miracum.provider_dimension USING btree (upload_id);


--
-- TOC entry 3549 (class 1259 OID 17363)
-- Name: pk_archive_obsfact; Type: INDEX; Schema: i2b2miracum; Owner: i2b2miracum
--

CREATE INDEX pk_archive_obsfact ON i2b2miracum.archive_observation_fact USING btree (encounter_num, patient_num, concept_cd, provider_id, start_date, modifier_cd, archive_upload_id);


--
-- TOC entry 3583 (class 1259 OID 17364)
-- Name: pm_encpnum_idx; Type: INDEX; Schema: i2b2miracum; Owner: i2b2miracum
--

CREATE INDEX pm_encpnum_idx ON i2b2miracum.patient_mapping USING btree (patient_ide, patient_ide_source, patient_num);


--
-- TOC entry 3584 (class 1259 OID 17365)
-- Name: pm_idx_uploadid; Type: INDEX; Schema: i2b2miracum; Owner: i2b2miracum
--

CREATE INDEX pm_idx_uploadid ON i2b2miracum.patient_mapping USING btree (upload_id);


--
-- TOC entry 3585 (class 1259 OID 17366)
-- Name: pm_patnum_idx; Type: INDEX; Schema: i2b2miracum; Owner: i2b2miracum
--

CREATE INDEX pm_patnum_idx ON i2b2miracum.patient_mapping USING btree (patient_num);


--
-- TOC entry 3592 (class 1259 OID 17367)
-- Name: qt_apnamevergrp_idx; Type: INDEX; Schema: i2b2miracum; Owner: i2b2miracum
--

CREATE INDEX qt_apnamevergrp_idx ON i2b2miracum.qt_analysis_plugin USING btree (plugin_name, version_cd, group_id);


--
-- TOC entry 3600 (class 1259 OID 17368)
-- Name: qt_idx_pqm_ugid; Type: INDEX; Schema: i2b2miracum; Owner: i2b2miracum
--

CREATE INDEX qt_idx_pqm_ugid ON i2b2miracum.qt_pdo_query_master USING btree (user_id, group_id);


--
-- TOC entry 3605 (class 1259 OID 17369)
-- Name: qt_idx_qi_mstartid; Type: INDEX; Schema: i2b2miracum; Owner: i2b2miracum
--

CREATE INDEX qt_idx_qi_mstartid ON i2b2miracum.qt_query_instance USING btree (query_master_id, start_date);


--
-- TOC entry 3606 (class 1259 OID 17370)
-- Name: qt_idx_qi_ugid; Type: INDEX; Schema: i2b2miracum; Owner: i2b2miracum
--

CREATE INDEX qt_idx_qi_ugid ON i2b2miracum.qt_query_instance USING btree (user_id, group_id);


--
-- TOC entry 3609 (class 1259 OID 17371)
-- Name: qt_idx_qm_ugid; Type: INDEX; Schema: i2b2miracum; Owner: i2b2miracum
--

CREATE INDEX qt_idx_qm_ugid ON i2b2miracum.qt_query_master USING btree (user_id, group_id, master_type_cd);


--
-- TOC entry 3597 (class 1259 OID 17372)
-- Name: qt_idx_qpsc_riid; Type: INDEX; Schema: i2b2miracum; Owner: i2b2miracum
--

CREATE INDEX qt_idx_qpsc_riid ON i2b2miracum.qt_patient_set_collection USING btree (result_instance_id);


--
-- TOC entry 3628 (class 1259 OID 17373)
-- Name: vd_idx_allvisitdim; Type: INDEX; Schema: i2b2miracum; Owner: i2b2miracum
--

CREATE INDEX vd_idx_allvisitdim ON i2b2miracum.visit_dimension USING btree (encounter_num, patient_num, inout_cd, location_cd, start_date, length_of_stay, end_date);


--
-- TOC entry 3629 (class 1259 OID 17374)
-- Name: vd_idx_dates; Type: INDEX; Schema: i2b2miracum; Owner: i2b2miracum
--

CREATE INDEX vd_idx_dates ON i2b2miracum.visit_dimension USING btree (encounter_num, start_date, end_date);


--
-- TOC entry 3630 (class 1259 OID 17375)
-- Name: vd_idx_uploadid; Type: INDEX; Schema: i2b2miracum; Owner: i2b2miracum
--

CREATE INDEX vd_idx_uploadid ON i2b2miracum.visit_dimension USING btree (upload_id);


--
-- TOC entry 3667 (class 2606 OID 17376)
-- Name: set_upload_status fk_up_set_type_id; Type: FK CONSTRAINT; Schema: i2b2miracum; Owner: i2b2miracum
--

ALTER TABLE ONLY i2b2miracum.set_upload_status
    ADD CONSTRAINT fk_up_set_type_id FOREIGN KEY (set_type_id) REFERENCES i2b2miracum.set_type(id);


--
-- TOC entry 3659 (class 2606 OID 17381)
-- Name: qt_patient_enc_collection qt_fk_pesc_ri; Type: FK CONSTRAINT; Schema: i2b2miracum; Owner: i2b2miracum
--

ALTER TABLE ONLY i2b2miracum.qt_patient_enc_collection
    ADD CONSTRAINT qt_fk_pesc_ri FOREIGN KEY (result_instance_id) REFERENCES i2b2miracum.qt_query_result_instance(result_instance_id);


--
-- TOC entry 3660 (class 2606 OID 17386)
-- Name: qt_patient_set_collection qt_fk_psc_ri; Type: FK CONSTRAINT; Schema: i2b2miracum; Owner: i2b2miracum
--

ALTER TABLE ONLY i2b2miracum.qt_patient_set_collection
    ADD CONSTRAINT qt_fk_psc_ri FOREIGN KEY (result_instance_id) REFERENCES i2b2miracum.qt_query_result_instance(result_instance_id);


--
-- TOC entry 3661 (class 2606 OID 17391)
-- Name: qt_query_instance qt_fk_qi_mid; Type: FK CONSTRAINT; Schema: i2b2miracum; Owner: i2b2miracum
--

ALTER TABLE ONLY i2b2miracum.qt_query_instance
    ADD CONSTRAINT qt_fk_qi_mid FOREIGN KEY (query_master_id) REFERENCES i2b2miracum.qt_query_master(query_master_id);


--
-- TOC entry 3662 (class 2606 OID 17396)
-- Name: qt_query_instance qt_fk_qi_stid; Type: FK CONSTRAINT; Schema: i2b2miracum; Owner: i2b2miracum
--

ALTER TABLE ONLY i2b2miracum.qt_query_instance
    ADD CONSTRAINT qt_fk_qi_stid FOREIGN KEY (status_type_id) REFERENCES i2b2miracum.qt_query_status_type(status_type_id);


--
-- TOC entry 3663 (class 2606 OID 17401)
-- Name: qt_query_result_instance qt_fk_qri_rid; Type: FK CONSTRAINT; Schema: i2b2miracum; Owner: i2b2miracum
--

ALTER TABLE ONLY i2b2miracum.qt_query_result_instance
    ADD CONSTRAINT qt_fk_qri_rid FOREIGN KEY (query_instance_id) REFERENCES i2b2miracum.qt_query_instance(query_instance_id);


--
-- TOC entry 3664 (class 2606 OID 17406)
-- Name: qt_query_result_instance qt_fk_qri_rtid; Type: FK CONSTRAINT; Schema: i2b2miracum; Owner: i2b2miracum
--

ALTER TABLE ONLY i2b2miracum.qt_query_result_instance
    ADD CONSTRAINT qt_fk_qri_rtid FOREIGN KEY (result_type_id) REFERENCES i2b2miracum.qt_query_result_type(result_type_id);


--
-- TOC entry 3665 (class 2606 OID 17411)
-- Name: qt_query_result_instance qt_fk_qri_stid; Type: FK CONSTRAINT; Schema: i2b2miracum; Owner: i2b2miracum
--

ALTER TABLE ONLY i2b2miracum.qt_query_result_instance
    ADD CONSTRAINT qt_fk_qri_stid FOREIGN KEY (status_type_id) REFERENCES i2b2miracum.qt_query_status_type(status_type_id);


--
-- TOC entry 3666 (class 2606 OID 17416)
-- Name: qt_xml_result qt_fk_xmlr_riid; Type: FK CONSTRAINT; Schema: i2b2miracum; Owner: i2b2miracum
--

ALTER TABLE ONLY i2b2miracum.qt_xml_result
    ADD CONSTRAINT qt_fk_xmlr_riid FOREIGN KEY (result_instance_id) REFERENCES i2b2miracum.qt_query_result_instance(result_instance_id);


--
-- TOC entry 3848 (class 0 OID 0)
-- Dependencies: 10
-- Name: SCHEMA i2b2miracum; Type: ACL; Schema: -; Owner: i2b2miracum
--

GRANT ALL ON SCHEMA i2b2miracum TO i2b2miracum;


-- Completed on 2022-05-27 17:30:33

--
-- PostgreSQL database dump complete
--


