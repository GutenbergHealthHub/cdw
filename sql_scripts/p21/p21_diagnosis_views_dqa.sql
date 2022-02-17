-- Null
create or replace view p21.dqa_diagnosis_null_doku
as
  select 
    count(id) quantity,
    case 
      when institutionmark !~ '^\w+' then 'institutionmark_nicht_dokumentiert'
      else 'institutionmark_dokumentiert'
    end doku
  from p21.p21_diagnosis
  group by doku
    union 
  select 
    count(id),
    case 
      when dismissinglocation !~ '^\w+' then 'dismissinglocation_nicht_dokumentiert'
      else 'dismissinglocation_dokumentiert'
    end doku
  from p21.p21_diagnosis
  group by doku
    union 
  select 
    count(id),
    case 
      when remunerationarea !~ '^\w+' then 'remunerationarea_nicht_dokumentiert'
      else 'remunerationarea_dokumentiert'
    end doku
  from p21.p21_diagnosis
  group by doku
    union 
  select 
    count(id),
    case 
      when encounterid !~ '^\w+' then 'encounterid_nicht_dokumentiert'
      else 'encounterid_dokumentiert'
    end doku
  from p21.p21_diagnosis
  group by doku
    union 
  select 
    count(id),
    case 
      when diagnosistyp !~ '^\w+' then 'diagnosistyp_nicht_dokumentiert'
      else 'diagnosistyp_dokumentiert'
    end doku
  from p21.p21_diagnosis
  group by doku
    union
  select 
    count(id),
    case 
      when icdversion !~ '^\w+' then 'icdversion_nicht_dokumentiert'
      else 'icdversion_dokumentiert'
    end doku
  from p21.p21_diagnosis
  group by doku
    union 
  select 
    count(id),
    case 
      when icdcode !~ '^\w+' then 'icdcode_nicht_dokumentiert'
      else 'icdcode_dokumentiert'
    end doku
  from p21.p21_diagnosis
  group by doku
    union 
  select 
    count(id),
    case 
      when localisation !~ '^\w+' then 'localisation_nicht_dokumentiert'
      else 'localisation_dokumentiert'
    end doku
  from p21.p21_diagnosis
  group by doku
    union 
  select 
    count(id),
    case 
      when diagnosticsecurity !~ '^\w+' then 'diagnosticsecurity_nicht_dokumentiert'
      else 'diagnosticsecurity_dokumentiert'
    end doku
  from p21.p21_diagnosis
  group by doku
    union 
  select 
    count(id),
    case 
      when icdcode2 !~ '^\w+' then 'icdcode2_nicht_dokumentiert'
      else 'icdcode2_dokumentiert'
    end doku
  from p21.p21_diagnosis
  group by doku
    union 
  select 
    count(id),
    case 
      when localisation2 !~ '^\w+' then 'localisation2_nicht_dokumentiert'
      else 'localisation2_dokumentiert'
    end doku
  from p21.p21_diagnosis
  where icdcode2 ~ '^\w+'
  group by doku
    union 
  select 
    count(id),
    case 
      when diagnosticsecurity2 !~ '^\w+' then 'diagnosticsecurity2_nicht_dokumentiert'
      else 'diagnosticsecurity2_dokumentiert'
    end doku
  from p21.p21_diagnosis
  where icdcode2 ~ '^\w+'
  group by doku
  order by doku
;

-- icdcode2 analyse 
create or replace view p21.dqa_diagnosis_icdcode2_analysis
as
  select 
    count(id) quantity,
    'localisation2' icdcode2_analysis
  from p21.p21_diagnosis pd 
  where icdcode2 !~ '\w+' 
  and localisation2 ~ '\w+' 
  group by icdcode2_analysis
    union 
  select 
    count(id),
    'diagnosticsecurity2' icdcode2_analysis
  from p21.p21_diagnosis pd 
  where icdcode2 !~ '\w+' 
  and diagnosticsecurity2 ~ '\w+'
  group by icdcode2_analysis 
;

-- icdcode analyse 
create or replace view p21.dqa_diagnosis_icdcode_analysis
as
  select 
    count(id) quantity,
    'localisation' icdcode_analysis
  from p21.p21_diagnosis pd 
  where icdcode !~ '\w+' 
  and localisation ~ '\w+' 
  group by icdcode_analysis
    union 
  select 
    count(id),
    'diagnosticsecurity' icdcode_analysis
  from p21.p21_diagnosis pd 
  where icdcode !~ '\w+' 
  and diagnosticsecurity ~ '\w+'
  group by icdcode_analysis
    union 
  select 
    count(id),
    'version' icdcode_analysis
  from p21.p21_diagnosis pd 
  where icdcode !~ '\w+' 
  and icdversion ~ '\w+'
  group by icdcode_analysis 
    union 
  select 
    count(id),
    'diagnosistyp' icdcode_analysis
  from p21.p21_diagnosis pd 
  where icdcode !~ '\w+' 
  and diagnosistyp ~ '\w+'
  group by icdcode_analysis 
  order by icdcode_analysis
;

-- Krankheiten bestimmter Geschlechter
drop view p21.dqa_diagnosis_geschlechter_krankheiten;
create or replace view p21.dqa_diagnosis_geschlechter_krankheiten
as
  select 
    count(distinct patientid) quantity, 
   'männer' gender,
    icdcode,
    titel
  from p21.p21_encounter pe 
  join p21.p21_diagnosis pd 
    on pe.id = pd.encounterid 
  join icd_metainfo.icd10gm im
    on im.code = pd.icdcode 
  where im.sexcode = 'W'--icdcode ~'C5[1-8]|N7[0-7]|N8|N9[0-8]|^O|N99\.[2-3]|A34|Z3[2-7|9]|Z31\.[123]|Z30\.[135]'
  and pe.gender like 'm'
  group by icdcode, im.titel
    union
  select 
    count(distinct patientid) quantity, 
   'männer' gender,
    icdcode2,
    titel
  from p21.p21_encounter pe 
  join p21.p21_diagnosis pd 
    on pe.id = pd.encounterid 
  join icd_metainfo.icd10gm im
    on im.code  = pd.icdcode2
  where im.sexcode = 'W' --icdcode2 ~'C5[1-8]|N7[0-7]|N8|N9[0-8]|^O|N99\.[2-3]|A34|Z3[2-7|9]|Z31\.[123]|Z30\.[135]'
  and pe.gender like 'm'
  group by icdcode2, im.titel
    union 
  select 
    count(distinct patientid),
    'frauen',
    icdcode,
    titel
  from p21.p21_encounter pe 
  join p21.p21_diagnosis pd 
    on pe.id = pd.encounterid 
  left join icd_metainfo.icd10gm ifr
    on ifr.code = pd.icdcode 
  where ifr.sexcode = 'M' --icdcode ~'C6[0-3]|N4[0-9]|N5[0-1]|D29|D07\.[4-5]'
  and pe.gender like 'w'
  group by icdcode, ifr.titel 
    union
  select 
    count(distinct patientid),
    'frauen',
    icdcode2,
    titel
  from p21.p21_encounter pe 
  join p21.p21_diagnosis pd 
    on pe.id = pd.encounterid 
  join icd_metainfo.icd10gm ifr
    on ifr.code = pd.icdcode2 
  where ifr.sexcode = 'M'--icdcode2 ~'C6[0-3]|N4[0-9]|N5[0-1]|D29|D07\.[4-5]'
  and pe.gender like 'w'
  group by icdcode2, ifr.titel
    union
  select 
    count(distinct patientid), 
    'divers_unbekannt_null',
    icdcode,
    titel
  from p21.p21_encounter pe 
  join p21.p21_diagnosis pd 
    on pe.id = pd.encounterid 
  join icd_metainfo.icd10gm ifr
    on ifr.code = pd.icdcode 
  where ifr.sexcode in ('M', 'W') --icdcode ~'C5[1-8]|N7[0-7]|N8|N9[0-8]|^O|N99\.[2-3]|A34|Z3[2-7|9]|Z31\.[123]|Z30\.[135]|C6[0-3]|N4[0-9]|N5[0-1]|D29|D07\.[4-5]'
  and pe.gender not in ('w', 'm') 
  group by icdcode, ifr.titel
    union
  select 
    count(distinct patientid), 
    'divers_unbekannt_null',
    icdcode2,
    titel
  from p21.p21_encounter pe 
  join p21.p21_diagnosis pd 
    on pe.id = pd.encounterid 
  left join icd_metainfo.icd10gm ifr
    on ifr.code = pd.icdcode2 
  where ifr.sexcode in ('M', 'W') --icdcode2 ~'C5[1-8]|N7[0-7]|N8|N9[0-8]|^O|N99\.[2-3]|A34|Z3[2-7|9]|Z31\.[123]|Z30\.[135]|C6[0-3]|N4[0-9]|N5[0-1]|D29|D07\.[4-5]'
  and pe.gender not in ('w', 'm') 
  group by icdcode2, ifr.titel
  order by quantity desc
;
