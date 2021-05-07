-- Id of DIZ
/*create schema diz_intern;

drop table if exists diz_intern.diziduuid;

--Tabel with DIZ-IDs and extern-IDs
create table diz_intern.dizIdUuid(
  id bigserial primary key,
  fall_pat_nummer varchar(40) not null unique,
  uuid_id varchar(40) not null unique,
  is_fall boolean default true,
  imput_source varchar(40) not null
);
*/
--truncate diz_intern.dizIdUuid restart identity;

-- patients from kis
insert into diz_intern.diziduuid (fall_pat_nummer, uuid_id, is_fall, imput_source)
  select distinct on(patnr) patnr , gen_random_uuid()::varchar, false, 'kis' s from kis.npat n
  left join diz_intern.diziduuid d on n.patnr = d.fall_pat_nummer
  where d.fall_pat_nummer isnull
;

-- cases from kis
insert into diz_intern.diziduuid (fall_pat_nummer, uuid_id, is_fall, imput_source)
  select distinct on(falnr) falnr , gen_random_uuid()::varchar, true, 'kis' s from kis.nfal n
  left join diz_intern.diziduuid d on n.falnr = d.fall_pat_nummer
  where d.fall_pat_nummer isnull
;

-- patients from copra
insert into diz_intern.diziduuid (fall_pat_nummer, uuid_id, is_fall, imput_source)
  select distinct  on (patid) patid , gen_random_uuid()::varchar, false, 'copra' s from copra.co6_medic_data_patient cmdp
  left join diz_intern.diziduuid d on cmdp.patid = d.fall_pat_nummer
  where d.fall_pat_nummer isnull
  and cmdp.patid notnull
;

-- patients from imagic
insert into diz_intern.diziduuid (fall_pat_nummer, uuid_id, is_fall, imput_source)
  select distinct  on (i_patid) i_patid , gen_random_uuid()::varchar, false, 'imagic' s from imagic.patient p
  left join diz_intern.diziduuid d on p.i_patid = d.fall_pat_nummer
  where d.fall_pat_nummer isnull
  and p.i_patid notnull
;

-- cases from imagic
insert into diz_intern.diziduuid (fall_pat_nummer, uuid_id, is_fall, imput_source)
  select distinct  on (i_visitid) i_visitid , gen_random_uuid()::varchar, true, 'imagic' s from imagic.visit v
  left join diz_intern.diziduuid d on v.i_visitid = d.fall_pat_nummer
  where d.fall_pat_nummer isnull
  and v.i_visitid notnull
;

-- patients from gtds
insert into diz_intern.diziduuid (fall_pat_nummer, uuid_id, is_fall, imput_source)
  select distinct on(patienten_id) patienten_id , gen_random_uuid()::varchar, false, 'gtds' s from gtds.auswertung_diz ad
  left join diz_intern.diziduuid d on ad.patienten_id = d.fall_pat_nummer
  where d.fall_pat_nummer isnull
  and ad.patienten_id notnull
;

-- cases from aktin
insert into diz_intern.diziduuid (fall_pat_nummer, uuid_id, is_fall, imput_source)
  select distinct on(fall_nummer) fall_nummer , gen_random_uuid()::varchar, true, 'aktin' s from aktin.aktin_copra ac
  left join diz_intern.diziduuid d on ac.fall_nummer = d.fall_pat_nummer
  where d.fall_pat_nummer isnull
  and ac.fall_nummer notnull
;

-- patients from central lab
insert into diz_intern.diziduuid (fall_pat_nummer, uuid_id, is_fall, imput_source)
  select distinct on(patient) patient , gen_random_uuid()::varchar, false, 'centrallab' s from centrallab.observationreport o
  left join diz_intern.diziduuid d on o.patient = d.fall_pat_nummer
  where d.fall_pat_nummer isnull
  and o.patient notnull
;

-- patients from p21
insert into diz_intern.diziduuid (fall_pat_nummer, uuid_id, is_fall, imput_source)
  select distinct on(patientid) pe.patientid , gen_random_uuid()::varchar, false, 'p21' s from p21.p21_encounter pe
  left join diz_intern.diziduuid d on pe.patientid = d.fall_pat_nummer
  where d.fall_pat_nummer isnull
  and pe.patientid notnull
;

-- cases from p21 (encounter)
insert into diz_intern.diziduuid (fall_pat_nummer, uuid_id, is_fall, imput_source)
  select distinct on(pe.id) pe.id , gen_random_uuid()::varchar, true, 'p21' s from p21.p21_encounter pe
  left join diz_intern.diziduuid d on pe.id = d.fall_pat_nummer
  where d.fall_pat_nummer isnull
  and pe.id notnull
;

-- cases from p21 (diagnosis)
insert into diz_intern.diziduuid (fall_pat_nummer, uuid_id, is_fall, imput_source)
  select distinct on(pd.encounterid) pd.encounterid , gen_random_uuid()::varchar, true, 'p21' s from p21.p21_diagnosis pd
  left join diz_intern.diziduuid d on pd.encounterid = d.fall_pat_nummer
  where d.fall_pat_nummer isnull
  and pd.encounterid notnull
;

-- cases from p21 (department)
insert into diz_intern.diziduuid (fall_pat_nummer, uuid_id, is_fall, imput_source)
  select distinct on(pd.encounterid) pd.encounterid , gen_random_uuid()::varchar, true, 'p21' s from p21.p21_department pd
  left join diz_intern.diziduuid d on pd.encounterid = d.fall_pat_nummer
  where d.fall_pat_nummer isnull
  and pd.encounterid notnull
;


-- cases from p21 (operation)
insert into diz_intern.diziduuid (fall_pat_nummer, uuid_id, is_fall, imput_source)
  select distinct on(po.encounterid) po.encounterid , gen_random_uuid()::varchar, true, 'p21' s from p21.p21_operation po
  left join diz_intern.diziduuid d on po.encounterid = d.fall_pat_nummer
  where d.fall_pat_nummer isnull
  and po.encounterid notnull
;

