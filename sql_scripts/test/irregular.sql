-- in ops but not in fab ok
select 
  po.* 
from staging.p21_operation po 
left join staging.p21_department pd2 
  on po.encounterid = pd2.encounterid 
where pd2.encounterid isnull;


-- in icd but not in fab
select 
  pd1.*, 
  --pe.remunerationarea, 
  pe.admissiondate, 
  pe.dischargedate 
from staging.p21_diagnosis pd1
join staging.p21_encounter pe 
  on pe.id = pd1.encounterid
left join staging.p21_department pd2 
  on pd1.encounterid = pd2.encounterid 
where pd2.encounterid isnull
order by pe.admissiondate ;


-- in icd but not in fab 6589
select 
  count(pd1.*) 
from staging.p21_diagnosis pd1 
left join staging.p21_department pd2 
  on pd1.encounterid = pd2.encounterid 
where pd2.encounterid isnull;


-- in icd but not in fab (dif remune_area)  pia & null
select 
  distinct pd1.remunerationarea 
from staging.p21_diagnosis pd1 
left join staging.p21_department pd2 
  on pd1.encounterid = pd2.encounterid 
where pd2.encounterid isnull;


-- in icd but not in fab remunerationArea null (182)
select 
  pd1.*, 
  --pe.remunerationarea, 
  pe.admissiondate, 
  pe.dischargedate  
from staging.p21_diagnosis pd1 
join staging.p21_encounter pe 
  on pe.id = pd1.encounterid
left join staging.p21_department pd2 
  on pd1.encounterid = pd2.encounterid 
where pd2.encounterid isnull 
and pd1.remunerationarea isnull
order by pe.admissiondate ;


-- in icd but not in fab
select 
  pd1.*, 
  pe.remunerationarea, 
  pe.admissiondate, 
  pe.dischargedate 
from staging.p21_diagnosis pd1 
join staging.p21_encounter pe 
  on pe.id = pd1.encounterid 
left join staging.p21_department pd2 
  on pd1.encounterid = pd2.encounterid 
where pd2.encounterid isnull 
and pd1.remunerationarea isnull
order by pe.admissiondate ;


-- in icd but not icd 
select 
  pd1.*, 
  --pe.remunerationarea, 
  pe.admissiondate, 
  pe.dischargedate  
from staging.p21_diagnosis pd1 
join staging.p21_encounter pe 
  on pe.id = pd1.encounterid
where pd1.icdcode isnull
order by pe.admissiondate ;

-- in icd but not icd (1679)
select 
  count(pd1.*) 
from staging.p21_diagnosis pd1 
join staging.p21_encounter pe 
  on pe.id = pd1.encounterid
where pd1.icdcode isnull;

