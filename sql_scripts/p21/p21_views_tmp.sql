--create schema p21;

drop view if exists p21.fall;

create or replace view p21.fall as
  select institutionMark "IK",
    case 
        when length(dismissingLocation) < 1 then null
        else dismissingLocation
     end "Entlassender-Standort",
    remunerationArea "Entgeltbereich",
    id "KH-internes-Kennzeichen",
    null "Versicherten-ID",
    null "Vertragskennzeichen-64b-Modellvorhaben",
    null "IK-der-Krankenkasse",
    yearBirth "Geburtsjahr",
    monthBirth "Geburtsmonat",
    case 
        when length(gender) < 1 then null
        else gender
     end "Geschlecht",   
    zipCode "PLZ", 
    case 
        when length(placeResidence) < 1 then null
        else placeResidence
     end "Wohnort",
    to_char(admissionDate, 'YYYYMMDDHH24MI') "Aufnahmedatum",
    admissionCause "Aufnahmeanlass",
    admissionReason "Aufnahmegrund",
      case         
        when isMerging isnull then null
	when isMerging then 'J'
        else 'N'
      end "Fallzusammenführung",
      case 
        when mergingreason like '' then null
        else mergingreason 
      end "Fallzusammenführungsgrund",
    admissionWeight "Aufnahmegewicht",    
    to_char(dischargeDate, 'YYYYMMDDHH24MI') "Entlassungsdatum",
     case 
        when length(dischargeReason) < 1 then null
        else dischargeReason 
      end "Entlassungsgrund",     
    ageDay "Alter-in-Tagen-am-Aufnahmetag",
    ageYear "Alter-in-Jahren-am-Aufnahmetag",
    patientId "Patientennummer",
    numberIntercompetitiveDialyses "interkurrente-Dialysen",
    ventilationHours Beatmungsstunden,
    to_char(startTreatmentPreinpatient, 'YYYYMMDD') "Behandlungsbeginn-vorstationär",
    treatmentDaysPreinpatient "Behandlungstage-vorstationär",
    to_char(endTreatmentInpatient, 'YYYYMMDD') "Behandlungsende-nachstationär",
    treatmentDaysAfterInpatient "Behandlungstage-nachstationär",
      case 
        when length(institutionalrelocatinghospitalid) < 1 then null
        else institutionalrelocatinghospitalid 
      end "IK-Verlegungs-KH",
    occupancyDaysDifferentPayRange "Belegungstage-in-anderem-Entgeltbereich",
    leaveAbsenceBPflVPayArea "Beurlaubungstage-PSY",
    isspecialcasemodelproject "Kennung-Besonderer-Fall-Modellvorhaben",
    intensiveDwellTime "Verweildauer-intensiv"--, --(noch nicht in unseren Dateien)
    --source "Quelle"
      from staging.p21_encounter;

 

drop view if exists p21.fab;

create or replace view p21.fab as
  select --id,
    institutionMark "IK",
    case 
        when length(dismissingLocation) < 1 then null
        else dismissingLocation
     end "Entlassender-Standort",
    remunerationArea "Entgeltbereich",
    encounterId "KH-internes-Kennzeichen",
    numberTreatmentPlace "Standortnummer-Behandlungsort", --(neue eingefügte Spalte in 2020)
    departmentCode "Fachabteilung",
    to_char(admissionDate, 'YYYYMMDDHH24MI') "FAB-Aufnahmedatum",
    to_char(dischargeDate, 'YYYYMMDDHH24MI') "FAB-Entlassungsdatum",
      case 
        when isintensivecarebed isnull then null
        when isintensivecarebed then 'J'
        else 'N'
      end "Kennung-Intensivbett", --(noch nicht in unseren Dateien) [J/N]
    source "Quelle" 
      from staging.p21_department; 

     
drop view if exists p21.ops;

create or replace view p21.ops as
  select --id ,
    institutionMark "IK",
    dismissingLocation "Entlassender-Standort",
    remunerationArea "Entgeltbereich",
    encounterId "KH-internes-Kennzeichen",
    opsVersion "OPS-Version",
    opsCode "OPS-Kode",
      case 
        when length(localisation) < 1 then null 
        else localisation 
      end "Lokalisation",
    to_char(opsDate, 'YYYYMMDDHH24MI') "OPS-Datum",
      case 
        when surgeon then 'J'
        when surgeon isnull then null
        else 'N'
      end "Belegoperateur",
      case 
        when anesthetist isnull then null
        when anesthetist then 'J'
        else 'N'
      end "Beleganästhesist",
      case         
        when midwife isnull then null
        when midwife then 'J'
        else 'N'
      end "Beleghebamme",     
    source "Quelle" 
      from staging.p21_operation;

--select * from data_mart.p21_ops;  

drop view if exists p21.icd;

create or replace view p21.icd as
  select --id ,
    institutionMark "IK",
    dismissingLocation "Entlassender-Standort",
    remunerationArea "Entgeltbereich",
    encounterId "KH-internes-Kennzeichen",
    diagnosisTyp "Diagnoseart",
    icdVersion "ICD-Version",
    icdCode "ICD-Kode", 
    case 
        when length(localisation) < 1 then null 
        else localisation 
      end "Lokalisation",
    case 
        when length(diagnosticSecurity) < 1 then null 
        else diagnosticSecurity
      end "Diagnosensicherheit",
      case 
        when length(icdCode2) < 1 then null 
        else icdCode2
      end "Sekundär-Kode",
    case 
        when length(localisation2) < 1 then null 
        else localisation2
      end "Lokalisation2",
      case 
        when length(diagnosticSecurity2) < 1 then null 
        else diagnosticSecurity2
      end "Diagnosensicherheit2",
    source "Quelle" 
      from staging.p21_diagnosis;
     
--select * from data_mart.p21_icd;  
    
drop view if exists p21.p21_quantity;

create or replace view p21.p21_quantity
as
select count(*) quantity, 'p21_department' "tables" from staging.p21_department
  union
select count(*), 'p21_encounter' from staging.p21_encounter
  union
select count(*), 'p21_diagnosis' from staging.p21_diagnosis
  union
select count(*), 'p21_operation' from staging.p21_operation;


drop view if exists p21.encounter_remission_relocation_year;

create or replace view p21.encounter_remission_year 
  as
  select 
    distinct date_part('year', dischargedate) "year", 
    count(*) cases 
      from staging.p21_encounter 
      group by date_part('year', dischargedate);
 
drop view if exists p21.encounter_admission_year;

create or replace view p21.encounter_admission_year 
  as
  select 
    distinct date_part('year', admissiondate ) "year", 
    count(*) cases 
      from staging.p21_encounter 
      group by date_part('year', admissiondate );

drop view if exists p21.operation_year;

create or replace view p21.operation_year 
  as
  select 
    distinct date_part('year', opsdate ) "year", 
    count(*) cases 
      from staging.p21_operation
      group by date_part('year', opsdate);


drop view if exists p21.each_department_year;

create or replace view p21.each_department_year
as
select 
  pd.departmentcode,
  date_part('year', admissiondate) "year",
  mrp.mean "department_type",
  mrm.mean "department",
  count(*) cases
  from staging.p21_department pd
    join metadata_repository.p21_department_prefix mrp
      on substring(departmentcode, 1, 2) = mrp.prefix
    join metadata_repository.p21_department_code_mean mrm
      on substring(departmentcode, 3, 4) = mrm.code
  group by departmentcode, date_part('year', admissiondate), mrp.mean, mrm.mean
;


drop view if exists p21.patient_quantity_cases;

create or replace view p21.patient_quantity_cases
  as
  select
    distinct patientid,
    gender,
    yearbirth,
    monthbirth,
    count(*) cases
      from staging.p21_encounter
      group by patientid, gender, yearbirth, monthbirth
;


drop view if exists p21.v_patient;

create or replace view p21.v_patient
  as
  select distinct on (patientid) 
    patientid, 
    gender, 
    yearbirth, 
    monthbirth, 
    zipcode 
      from staging.p21_encounter 
      order by patientid, admissiondate desc
;

drop view if exists p21.encounter_admission_reason;

create or replace view p21.encounter_admission_reason 
as
select count (e.*) cases, admissionreason,   
  admissionreason12 first_second_position,  
  admissionreason3 thirth_position,  
  admissionreason4 fourth_position
  from staging.p21_encounter e
    left join metadata_repository.p21_admission_reason_1_2 m12  
     on substring(admissionreason, 1, 2) = m12.id
    left join metadata_repository.p21_admission_reason_3 m3
     on substring(admissionreason, 3, 1) = m3.id
    left join metadata_repository.p21_admission_reason_4 m4
     on substring(admissionreason, 4) = m4.id
     where length(admissionreason) = 4 and  (admissionreason like '0%' or admissionreason like '1%') 
     group by admissionreason, admissionreason12,admissionreason3,admissionreason4
  union
  select count (e.*) cases, admissionreason,
    null,
    null,
    null
      from staging.p21_encounter e
        where length(admissionreason) < 4 or 
          ((length(admissionreason) = 4 and 
          admissionreason not like '0%' and 
          admissionreason not like '1%'))
        group by admissionreason
        order by cases
;


drop view if exists p21.department_year;

create or replace view p21.department_year
as
select
  date_part('year', admissiondate) "year",
  count(*) cases
  from staging.p21_department pd
    group by date_part('year', admissiondate)
;


drop view if exists p21.encounter_remission_relocation;

create or replace view p21.encounter_remission_relocation 
as 
select count(e.*) cases, 
  dischargeReason,
  mrrr12.mean remission_relocation,
  mrrr3.mean specification
    from staging.p21_encounter e
      join metadata_repository.p21_remission_relocation_1_2 mrrr12
        on substring(dischargeReason, 1,2) =  mrrr12.id
      join metadata_repository.p21_remission_relocation_3 mrrr3
        on substring(dischargeReason, 3,1) =  mrrr3.id        
     group by dischargeReason, mrrr12.mean, mrrr3.mean
  union
  	select count(e.*) cases, 
  	dischargeReason,
    null,
    null
      from staging.p21_encounter e
        where dischargeReason isnull or dischargeReason like ''
      group by dischargeReason
;


drop view if exists p21.encounter_gender;

create or replace view p21.encounter_gender
as
select 
  e.gender code,
  mrg.gender,
  count(e.*) cases
  from staging.p21_encounter e
    left join metadata_repository.p21_gender mrg
      on e.gender = mrg.id 
    group by e.gender, mrg.gender
;

drop view if exists p21.encounter_admission_cause;

create or replace view p21.encounter_admission_cause
as
select 
  e.admissioncause code,
  mrac.admissioncause,
  count(e.*) cases
  from staging.p21_encounter e
    left join metadata_repository.p21_admission_cause mrac
      on e.admissioncause = mrac.id 
    group by e.admissioncause, mrac.admissioncause
;


drop view if exists p21.encounter_remuneration_area;

create or replace view p21.encounter_remuneration_area
as
select e.remunerationArea code,
  mrra.remunerationArea,
  count(e.*) cases
    from staging.p21_encounter e
      left join metadata_repository.p21_remuneration_area mrra
      on e.remunerationarea = mrra.id 
    group by e.remunerationarea, mrra.remunerationarea
;


drop view if exists p21.encounter_merging;

create or replace view p21.encounter_merging
as
select e.ismerging,
  count(e.*) cases
    from staging.p21_encounter e
    group by e.ismerging
;


drop view if exists p21.encounter_merging_reason;

create or replace view p21.encounter_merging_reason
as
select e.mergingreason code,
  mrmr.mergingreason ,
  count(e.*) cases
    from staging.p21_encounter e
      left join metadata_repository.p21_merging_reason mrmr
      on e.mergingreason = mrmr.id 
    group by e.mergingreason, mrmr.mergingreason 
;


drop view if exists p21.operation_quantity;

create view p21.operation_quantity
as
select opscode, 
  count(*) quantity 
   from staging.p21_operation 
   group by opscode 
   order by quantity desc
;


drop view if exists p21.operation_quantity_year;

create view p21.operation_quantity_year
as
select 
  date_part('year', opsdate) "year",
  opscode, 
  count(*) quantity 
   from staging.p21_operation 
   group by opscode, date_part('year', opsdate)
;

drop view if exists p21.operation_with_titel_quantity_year;

create or replace view p21.operation_with_titel_quantity_year
as
select 
  date_part('year', opsdate) "year",
  opscode,
  titel,
  count(op.*) quantity 
   from staging.p21_operation op
     join metadata_repository.ops mop
       on op.opscode = mop.ops
   group by opscode, date_part('year', opsdate), titel
;


drop view if exists p21.operation_with_titel_quantity;

create or replace view p21.operation_with_titel_quantity
as
select opscode, 
  titel,
  count(pop.*) quantity 
   from staging.p21_operation pop
     join metadata_repository.ops mop
     on pop.opscode = mop.ops
   group by opscode, titel
   order by quantity desc
;


drop view if exists p21.diagnosis_with_titel_quantity;

create or replace view p21.diagnosis_with_titel_quantity
as
select picd.icdcode, 
  micd.titel,
  count(picd.*) quantity 
   from staging.p21_diagnosis picd
     join metadata_repository.icd micd
     on regexp_replace(picd.icdcode, '\W', '', 'g') = micd.icdnodot
   group by picd.icdcode, micd.titel--;
 union
  select picd.icdcode2, 
  micd.titel,
  count(picd.*) quantity 
   from staging.p21_diagnosis picd
     join metadata_repository.icd micd
     on regexp_replace(picd.icdcode2, '\W', '', 'g') = micd.icdnodot
   group by picd.icdcode2, micd.titel
   order by quantity desc
;

drop view if exists p21.diagnosis_with_titel_quantity_year;

create or replace view p21.diagnosis_with_titel_quantity_year
as
select count(picd.*) quantity,
  date_part('year', en.admissiondate) "year",
  picd.icdcode,   
  micd.titel  
   from staging.p21_diagnosis picd
     join metadata_repository.icd micd
       on regexp_replace(picd.icdcode, '\W', '', 'g') = micd.icdnodot
     join staging.p21_encounter en 
       on en.id = picd.encounterid 
   group by picd.icdcode, micd.titel, "year"
 union
  select count(picd.*) quantity, 
  date_part('year', en.admissiondate) "year",
  picd.icdcode2,
  micd.titel  
   from staging.p21_diagnosis picd
     join metadata_repository.icd micd
       on regexp_replace(picd.icdcode2, '\W', '', 'g') = micd.icdnodot
     join staging.p21_encounter en 
       on en.id = picd.encounterid 
   group by picd.icdcode2, micd.titel, "year"
;

create materialized view if not exists p21.p21_patient
  as
  select distinct on (patientid)
    patientid,
    gender,
    yearbirth,
    monthbirth,
    zipcode
      from staging.p21_encounter
      order by patientid, admissiondate desc
;

REFRESH MATERIALIZED VIEW p21.p21_patient;
