-- procedure to insert news intern diz-ids
    
create or replace procedure diz_intern.insert_new_id()
  language plpgsql
  as $$
  begin 
    
    -- information from kis
    if exists(
      select true
      from information_schema.tables
      where table_schema = 'kis'
    )
    then
      -- patients from kis
      insert into diz_intern.diziduuid (fall_pat_nummer, uuid_id, is_fall, imput_source)
        select distinct on(patnr) patnr , gen_random_uuid()::varchar, false, 'kis' s 
	from kis.npat n
        left join diz_intern.diziduuid d on n.patnr = d.fall_pat_nummer
        where d.fall_pat_nummer isnull
	and n.patnr notnull
      ;
    
      -- cases from kis
      insert into diz_intern.diziduuid (fall_pat_nummer, uuid_id, is_fall, imput_source)
        select distinct on(falnr) falnr , gen_random_uuid()::varchar, true, 'kis' s 
	from kis.nfal n
        left join diz_intern.diziduuid d on n.falnr = d.fall_pat_nummer
        where d.fall_pat_nummer isnull
	and n.falnr notnull
      ;
     end if;

    --information from copra
    if exists(
      select true
      from information_schema.tables
      where table_schema = 'copra'
    )
    then
      -- patients from copra
      insert into diz_intern.diziduuid (fall_pat_nummer, uuid_id, is_fall, imput_source)
        select distinct  on (patid) patid , gen_random_uuid()::varchar, false, 'copra' s 
	from copra.co6_medic_data_patient cmdp
        left join diz_intern.diziduuid d on cmdp.patid = d.fall_pat_nummer
        where d.fall_pat_nummer isnull
        and cmdp.patid notnull
      ;
    end if;

    -- information from imagic
    if exists(
      select true
        from information_schema.tables
	where table_schema = 'imagic'
     )
    then
      -- patients from imagic
      insert into diz_intern.diziduuid (fall_pat_nummer, uuid_id, is_fall, imput_source)
        select distinct  on (i_patid) i_patid , gen_random_uuid()::varchar, false, 'imagic' s 
	from imagic.patient p
        left join diz_intern.diziduuid d on p.i_patid = d.fall_pat_nummer
        where d.fall_pat_nummer isnull
        and p.i_patid notnull
      ;
    
      -- cases from imagic
      insert into diz_intern.diziduuid (fall_pat_nummer, uuid_id, is_fall, imput_source)
        select distinct  on (i_visitid) i_visitid , gen_random_uuid()::varchar, true, 'imagic' s 
	from imagic.visit v
        left join diz_intern.diziduuid d on v.i_visitid = d.fall_pat_nummer
        where d.fall_pat_nummer isnull
        and v.i_visitid notnull
      ;
    end if;
    
    -- information from gtds
    if exists(
      select true
      from information_schema.tables
      where table_schema = 'gtds'
    )
    then
    -- patients from gtds
      insert into diz_intern.diziduuid (fall_pat_nummer, uuid_id, is_fall, imput_source)
        select distinct on(patienten_id) patienten_id , gen_random_uuid()::varchar, false, 'gtds' s 
	from gtds.auswertung_diz ad
        left join diz_intern.diziduuid d on ad.patienten_id = d.fall_pat_nummer
        where d.fall_pat_nummer isnull
        and ad.patienten_id notnull
    ;
    end if;
    
    -- information from aktin
    if exists(
      select true
      from information_schema.tables
      where table_schema = 'aktin'
    )
    then
      -- cases from aktin
      insert into diz_intern.diziduuid (fall_pat_nummer, uuid_id, is_fall, imput_source)
        select distinct on(fall_nummer) fall_nummer , gen_random_uuid()::varchar, true, 'aktin' s 
	from aktin.aktin_copra ac
        left join diz_intern.diziduuid d on ac.fall_nummer = d.fall_pat_nummer
        where d.fall_pat_nummer isnull
        and ac.fall_nummer notnull
      ;
    end if;
    
    -- information from central lab
    if exists(
      select true
      from information_schema.tables
      where table_schema = 'centrallab'
    )
    then
      -- patients from central lab
      insert into diz_intern.diziduuid (fall_pat_nummer, uuid_id, is_fall, imput_source)
        select distinct on(patient) patient , gen_random_uuid()::varchar, false, 'centrallab' s 
	from centrallab.observationreport o
        left join diz_intern.diziduuid d on o.patient = d.fall_pat_nummer
        where d.fall_pat_nummer isnull
        and o.patient notnull
    ;
    end if;
    
    -- information from p21
    if exists(
      select true
      from information_schema.tables
      where table_schema = 'p21'
    )
    then
      -- patients from p21
      insert into diz_intern.diziduuid (fall_pat_nummer, uuid_id, is_fall, imput_source)
        select distinct on(patientid) pe.patientid , gen_random_uuid()::varchar, false, 'p21' s 
	from p21.p21_encounter pe
        left join diz_intern.diziduuid d on pe.patientid = d.fall_pat_nummer
        where d.fall_pat_nummer isnull
        and pe.patientid notnull
      ;
    
      -- cases from p21 (encounter)
      insert into diz_intern.diziduuid (fall_pat_nummer, uuid_id, is_fall, imput_source)
        select distinct on(pe.id) pe.id , gen_random_uuid()::varchar, true, 'p21' s 
        from p21.p21_encounter pe
        left join diz_intern.diziduuid d on pe.id = d.fall_pat_nummer
        where d.fall_pat_nummer isnull
        and pe.id notnull
      ;
    
      -- cases from p21 (diagnosis)
      insert into diz_intern.diziduuid (fall_pat_nummer, uuid_id, is_fall, imput_source)
        select distinct on(pd.encounterid) pd.encounterid , gen_random_uuid()::varchar, true, 'p21' s 
	from p21.p21_diagnosis pd
        left join diz_intern.diziduuid d on pd.encounterid = d.fall_pat_nummer
        where d.fall_pat_nummer isnull
        and pd.encounterid notnull
      ;
    
      -- cases from p21 (department)
      insert into diz_intern.diziduuid (fall_pat_nummer, uuid_id, is_fall, imput_source)
        select distinct on(pd.encounterid) pd.encounterid , gen_random_uuid()::varchar, true, 'p21' s 
	from p21.p21_department pd
        left join diz_intern.diziduuid d on pd.encounterid = d.fall_pat_nummer
        where d.fall_pat_nummer isnull
        and pd.encounterid notnull
      ;
    
      -- cases from p21 (operation)
      insert into diz_intern.diziduuid (fall_pat_nummer, uuid_id, is_fall, imput_source)
        select distinct on(po.encounterid) po.encounterid , gen_random_uuid()::varchar, true, 'p21' s 
        from p21.p21_operation po
        left join diz_intern.diziduuid d on po.encounterid = d.fall_pat_nummer
        where d.fall_pat_nummer isnull
        and po.encounterid notnull
      ;
    end if;
end; $$; 
