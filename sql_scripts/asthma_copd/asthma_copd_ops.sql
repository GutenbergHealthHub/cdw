drop table if exists dativa_study1_ops cascade;

create table dativa_study1_ops(
  ops varchar
);

-- ops of interes
insert into dativa_study1_ops values
('8-701'),
('8-980'),
('5-311'),
('5-312'),
('5-431.2');


drop table if exists asthm_copd cascade;

-- Cases with COPD between 2009 and 2019
select distinct encounterid into asthm_copd from p21.p21_diagnosis pd where icdcode ~ 'J44'
and encounterid in (select id from p21.p21_encounter pe where date_part('year', admissiondate) >2008 and date_part('year', admissiondate) < 2019)
and encounterid not like '';


-- Patients with COPD and their procedures
copy (
  select distinct
    'COPD_AATM'||uuid_id patid,
    date_trunc('month',admissiondate)::date as admissiondate ,
    date_trunc('month', dischargedate)::date as dischargedate,
    CASE
      WHEN admissionreason::text ~~ ''::text OR admissionreason IS NULL THEN NULL::text
      ELSE lpad(admissionreason::text, 4, '0'::text)
    end as "admissionreason",
    CASE
      WHEN dischargereason::text ~~ ''::text THEN NULL::character varying
      WHEN length(dischargereason::text) < 2 THEN (('0'::text || dischargereason::text) || '9'::text)::character varying
      WHEN length(dischargereason::text) = 2 AND dischargereason::text ~ '^\d{2}$'::text THEN
        CASE
          WHEN dischargereason::integer <= 10 OR dischargereason::integer = 15 THEN dischargereason::text || '9'::text
           WHEN dischargereason::integer <> 15 THEN '0'::text || dischargereason::text
            ELSE NULL::text
         END::character varying
         ELSE dischargereason
     END as "dischargereason",
    gender,
    ageyear / 5 * 5 as age_range,
    ventilationhours,
    opscode as "ops"
  from p21.p21_encounter pe
  join asthm_copd ac on ac.encounterid = pe.id
  join p21.p21_operation pd on pe.id = pd.encounterid
  join diz_intern.diziduuid d on d.fall_pat_nummer = pe.patientid
  join dativa_study1_ops dso on pd.opscode ~ dso.ops
) to '/media/db/cdw_database/asthma_copd-procedures.csv' delimiter ',' csv header;

