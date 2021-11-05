
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
  ver varchar references icd_metainfo.icd10gm_release_info(icd10gm_version), -- new version
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
  primary key (code, ver, verevent)
);
