-- table for releases
/*drop table if exists icd_metainfo.icd10gm_release_info;
create table icd_metainfo.icd10gm_release_info(
  icd10gm_version varchar(10) primary key,
  icd10gm_release date not null unique
);*/

--truncate icd_metainfo.icd10gm_release_info;
/*COPY icd_metainfo.icd10gm_release_info from '/home/abel/cdw/ICD/icd_versions/codes/icd10gm_versions.dat' WITH DELIMITER E';' CSV QUOTE E'\b' Header;
insert into icd_metainfo.icd10gm_release_info
  values ('2021', '2020-11-11');
 */
--select * from icd_metainfo.icd10gm_release_info;

-- all icd10gm from 2007 till now
drop table if exists icd_metainfo.icd10gm cascade;
create table icd_metainfo.icd10gm(
  ver varchar references icd_metainfo.icd10gm_release_info(icd10gm_version), -- current version
  ebene varchar,
  ort varchar,
  art varchar,
  kapnr varchar,
  grvon varchar,
  code varchar primary key,
  normcode varchar,
  codeohnepunkt varchar,
  titel varchar,
  dreisteller varchar,
  viersteller varchar,
  fuenfsteller varchar, -- look off!! this column hat a strange character in the original name
  p295 varchar,
  p301 varchar,
  mortl1code varchar,
  mortl2code varchar,
  mortl3code varchar,
  mortl4code varchar,
  morblcode varchar,
  sexcode varchar,
  sexfehlertyp varchar,
  altunt varchar,
  altob varchar,
  altfehlertyp varchar,
  exot varchar,
  belegt varchar,
  ifsgmeldung varchar,
  ifsglabor varchar
);

--table for history of icd10gm
drop table if exists icd_metainfo.icd10gm_history cascade;
create table icd_metainfo.icd10gm_history(
  --id bigserial primary key,
  ver varchar references icd_metainfo.icd10gm_release_info(icd10gm_version), -- insert/update version 
  ebene varchar,
  ort varchar,
  art varchar,
  kapnr varchar,
  grvon varchar,
  code varchar REFERENCES icd_metainfo.icd10gm(code),
  normcode varchar,
  codeohnepunkt varchar,
  titel varchar,
  dreisteller varchar,
  viersteller varchar,
  fuenfsteller varchar,
  p295 varchar,
  p301 varchar,
  mortl1code varchar,
  mortl2code varchar,
  mortl3code varchar,
  mortl4code varchar,
  morblcode varchar,
  sexcode varchar,
  sexfehlertyp varchar,
  altunt varchar,
  altob varchar,
  altfehlertyp varchar,
  exot varchar,
  belegt varchar,
  ifsgmeldung varchar,
  ifsglabor varchar,
  oldver varchar references icd_metainfo.icd10gm_release_info(icd10gm_version), -- old version
  verevent varchar check(verevent in ('D', 'I', 'U', 'DI')), --change in the new release
  isdeleted boolean default false,
  primary key (code, ver, verevent)
);
