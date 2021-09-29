-- p21.fab source

CREATE OR REPLACE VIEW p21.fab
AS SELECT p21_department.institutionmark AS "IK",
    p21_department.dismissinglocation AS "Entlassender-Standort",
    p21_department.remunerationarea AS "Entgeltbereich",
    p21_department.encounterid AS "KH-internes-Kennzeichen",
    p21_department.numbertreatmentplace AS "Standortnummer-Behandlungsort",
    p21_department.departmentcode AS "Fachabteilung",
    to_char(p21_department.admissiondate, 'YYYYMMDDHH24MI'::text) AS "FAB-Aufnahmedatum",
    to_char(p21_department.dischargedate, 'YYYYMMDDHH24MI'::text) AS "FAB-Entlassungsdatum",
        CASE
            WHEN p21_department.isintensivecarebed IS NULL THEN NULL::text
            WHEN p21_department.isintensivecarebed THEN 'J'::text
            ELSE 'N'::text
        END AS "Kennung-Intensivbett"
   FROM p21.p21_department;
   
   
-- p21.fall source

DROP VIEW IF EXISTS p21.fall;
CREATE OR REPLACE VIEW p21.fall
AS 
SELECT p21_encounter.institutionmark AS "IK",
    p21_encounter.dismissinglocation AS "Entlassender-Standort",
    p21_encounter.remunerationarea AS "Entgeltbereich",
    p21_encounter.id AS "KH-internes-Kennzeichen",
    NULL::text AS "Versicherten-ID",
    NULL::text AS "Vertragskennzeichen-64b-Modellvorhaben",
    NULL::text AS "IK-der-Krankenkasse",
    p21_encounter.yearbirth AS "Geburtsjahr",
    p21_encounter.monthbirth AS "Geburtsmonat",
    p21_encounter.gender AS "Geschlecht",
        CASE 
        	WHEN length(p21_encounter.zipcode) < 5 then lpad(p21_encounter.zipcode::text, 5, '0'::text)
        	ELSE p21_encounter.zipcode
        END "PLZ",
    --p21_encounter.zipcode AS "PLZ",
    p21_encounter.placeresidence AS "Wohnort",
    to_char(p21_encounter.admissiondate, 'YYYYMMDDHH24MI'::text) AS "Aufnahmedatum",
        CASE
            WHEN p21_encounter.admissioncause::text ~~ ''::text OR p21_encounter.admissioncause IS NULL THEN NULL::character varying
            ELSE p21_encounter.admissioncause
        END AS "Aufnahmeanlass",
        CASE
            WHEN p21_encounter.admissionreason::text ~~ ''::text OR p21_encounter.admissionreason IS NULL THEN NULL::text
            ELSE lpad(p21_encounter.admissionreason::text, 4, '0'::text)
        END AS "Aufnahmegrund",
        CASE
            WHEN p21_encounter.ismerging IS NULL THEN NULL::text
            WHEN p21_encounter.ismerging THEN 'J'::text
            ELSE 'N'::text
        END AS "Fallzusammenführung",
        CASE
            WHEN p21_encounter.mergingreason::text ~~ ''::text THEN NULL::character varying
            ELSE p21_encounter.mergingreason
        END AS "Fallzusammenführungsgrund",
    p21_encounter.admissionweight AS "Aufnahmegewicht",
    to_char(p21_encounter.dischargedate, 'YYYYMMDDHH24MI'::text) AS "Entlassungsdatum",
        CASE
            WHEN p21_encounter.dischargereason::text ~~ ''::text THEN NULL::character varying
            WHEN length(p21_encounter.dischargereason::text) < 2 THEN (('0'::text || p21_encounter.dischargereason::text) || '9'::text)::character varying
            WHEN length(p21_encounter.dischargereason::text) = 2 AND p21_encounter.dischargereason::text ~ '^\d{2}$'::text THEN
            CASE
                WHEN p21_encounter.dischargereason::integer <= 10 OR p21_encounter.dischargereason::integer = 15 THEN p21_encounter.dischargereason::text || '9'::text
                WHEN p21_encounter.dischargereason::integer <> 15 THEN '0'::text || p21_encounter.dischargereason::text
                ELSE NULL::text
            END::character varying
            ELSE p21_encounter.dischargereason
        END AS "Entlassungsgrund",
    p21_encounter.ageday AS "Alter-in-Tagen-am-Aufnahmetag",
    p21_encounter.ageyear AS "Alter-in-Jahren-am-Aufnahmetag",
    p21_encounter.patientid AS "Patientennummer",
    p21_encounter.numberintercompetitivedialyses AS "interkurrente-Dialysen",
    p21_encounter.ventilationhours AS "Beatmungsstunden",
    to_char(p21_encounter.starttreatmentpreinpatient::timestamp with time zone, 'YYYYMMDD'::text) AS "Behandlungsbeginn-vorstationär",
    p21_encounter.treatmentdayspreinpatient AS "Behandlungstage-vorstationär",
    to_char(p21_encounter.endtreatmentinpatient::timestamp with time zone, 'YYYYMMDD'::text) AS "Behandlungsende-nachstationär",
    p21_encounter.treatmentdaysafterinpatient AS "Behandlungstage-nachstationär",
    p21_encounter.institutionalrelocatinghospitalid AS "IK-Verlegungs-KH",
    p21_encounter.occupancydaysdifferentpayrange AS "Belegungstage-in-anderem-Entgeltbereich",
    p21_encounter.leaveabsencebpflvpayarea AS "Beurlaubungstage-PSY",
    p21_encounter.isspecialcasemodelproject AS "Kennung-Besonderer-Fall-Modellvorhaben",
    p21_encounter.intensivedwelltime AS "Verweildauer-intensiv"
   FROM p21.p21_encounter;
      
-- p21.icd source

CREATE OR REPLACE VIEW p21.icd
AS SELECT p21_diagnosis.institutionmark AS "IK",
    p21_diagnosis.dismissinglocation AS "Entlassender-Standort",
    p21_diagnosis.remunerationarea AS "Entgeltbereich",
    p21_diagnosis.encounterid AS "KH-internes-Kennzeichen",
    p21_diagnosis.diagnosistyp AS "Diagnoseart",
    p21_diagnosis.icdversion AS "ICD-Version",
    p21_diagnosis.icdcode AS "ICD-Kode",
    p21_diagnosis.localisation AS "Lokalisation",
    p21_diagnosis.diagnosticsecurity AS "Diagnosensicherheit",
    p21_diagnosis.icdcode2 AS "Sekundär-Kode",
    p21_diagnosis.localisation2 AS "Lokalisation2",
    p21_diagnosis.diagnosticsecurity2 AS "Diagnosensicherheit2"
   FROM p21.p21_diagnosis;
   
   
-- p21.ops source

CREATE OR REPLACE VIEW p21.ops
AS SELECT p21_operation.institutionmark AS "IK",
    p21_operation.dismissinglocation AS "Entlassender-Standort",
    p21_operation.remunerationarea AS "Entgeltbereich",
    p21_operation.encounterid AS "KH-internes-Kennzeichen",
        CASE
            WHEN p21_operation.opsversion::text ~~ ''::text OR p21_operation.opsversion IS NULL THEN date_part('year'::text, p21_operation.opsdate)::character varying(6)
            ELSE p21_operation.opsversion
        END AS "OPS-Version",
    p21_operation.opscode AS "OPS-Kode",
    p21_operation.localisation AS "Lokalisation",
    to_char(p21_operation.opsdate, 'YYYYMMDDHH24MI'::text) AS "OPS-Datum",
        CASE
            WHEN p21_operation.surgeon THEN 'J'::text
            WHEN p21_operation.surgeon IS NULL THEN NULL::text
            ELSE 'N'::text
        END AS "Belegoperateur",
        CASE
            WHEN p21_operation.anesthetist IS NULL THEN NULL::text
            WHEN p21_operation.anesthetist THEN 'J'::text
            ELSE 'N'::text
        END AS "Beleganästhesist",
        CASE
            WHEN p21_operation.midwife IS NULL THEN NULL::text
            WHEN p21_operation.midwife THEN 'J'::text
            ELSE 'N'::text
        END AS "Beleghebamme"
   FROM p21.p21_operation;
