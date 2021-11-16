-- Null
--create or replace view p21.dqa_department_null_doku
--as
  select 
    count(id) quantity,
    case 
      when institutionmark isnull then 'institutionmark_nicht_dokumentiert'
      else 'institutionmark_dokumentiert'
    end doku
  from p21.p21_department 
  group by doku
    union all
  select 
    count(id),
    case 
      when dismissinglocation isnull then 'dismissinglocation_nicht_dokumentiert'
      else 'dismissinglocation_dokumentiert'
    end doku
  from p21.p21_department 
  group by doku
    union all
  select 
    count(id),
    case 
      when remunerationarea isnull then 'remunerationarea_nicht_dokumentiert'
      else 'remunerationarea_dokumentiert'
    end doku
  from p21.p21_department 
  group by doku
    union all
  select 
    count(id),
    case 
      when encounterid isnull then 'encounterid_nicht_dokumentiert'
      else 'encounterid_dokumentiert'
    end doku
  from p21.p21_department 
  group by doku
    union all
  select 
    count(id),
    case 
      when numbertreatmentplace isnull then 'numbertreatmentplace_nicht_dokumentiert'
      else 'numbertreatmentplace_dokumentiert'
    end doku
  from p21.p21_department 
  group by doku
    union all
  select 
    count(id),
    case 
      when departmentcode isnull then 'departmentcode_nicht_dokumentiert'
      else 'departmentcode_dokumentiert'
    end doku
  from p21.p21_department 
  group by doku
    union all
  select 
    count(id),
    case 
      when admissiondate isnull then 'admissiondate_nicht_dokumentiert'
      else 'admissiondate_dokumentiert'
    end doku
  from p21.p21_department 
  group by doku
    union all
  select 
    count(id),
    case 
      when dischargedate isnull then 'dischargedate_nicht_dokumentiert'
      else 'dischargedate_dokumentiert'
    end doku
  from p21.p21_department 
  group by doku
  order by doku
;

-- Dismissinglocation
--create or replace view p21.dqa_department_dismissinglocation
--as
  select 
    count(id) quantity,
    dismissinglocation
  from p21.p21_department
  --where dismissinglocation ~'\d+'
  group by dismissinglocation
  order by quantity
;

-- Remuneration area
--create or replace view p21.dqa_department_remunerationarea
--as
  select 
    count(id) quantity,
    remunerationarea 
  from p21.p21_department
  --where remunerationarea ~'\w+'
  group by remunerationarea 
  order by quantity
;

-- Number treatment place
--create or replace view p21.dqa_department_numbertreatmentplace
--as
  select 
    count(id) quantity,
    numbertreatmentplace 
  from p21.p21_department
  --where numbertreatmentplace ~'\w+'
  group by numbertreatmentplace 
  order by quantity
;

-- Department code
--create or replace view p21.dqa_department_departmentcode
--as
  select 
    count(p21dep.id) quantity,
    departmentcode,
    case 
      when pd.id isnull then '--'
      else pd.department 
    end department
  from p21.p21_department p21dep
  left join metadata_repository.p21_department pd 
    on p21dep.departmentcode = pd.id 
  --where pd.id isnull
  --and departmentcode notnull
  group by departmentcode, department, pd.id
  order by quantity
;
