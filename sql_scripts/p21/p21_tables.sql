-- tables
--DROP table if exists p21.p21_encounter cascade;

-- fall
CREATE TABLE p21.p21_encounter
(
    
    institutionMark varchar(10), -- IK
    dismissingLocation varchar(255), -- Entlassender Standort
    remunerationArea varchar(4), -- Entgeltbereich
    id varchar(45) primary key, -- KH-internes Kennzeichen
    healthInsuranceNumber varchar(10) default null,-- Krankenversichertennummer
    contractIdentifierP64bPilotProject varchar(255), --Vertragskennzeichen § 64b-Modellvorhaben
    healthInsuranceCompanyId varchar(15), -- Institutionskennzeichen der Krankenkasse
    yearBirth int, -- Geburtsjahr
    monthBirth int, -- Geburtsmonat
    gender varchar(2), -- Geschlecht    
    zipCode varchar(6), -- PLZ    
    placeResidence varchar(255),-- Wohnort
    admissionDate timestamp, -- Aufnahmedatum
    admissionCause varchar(2), -- Aufnahmeanlass
    admissionReason varchar(5), -- Aufnahmegrund
    isMerging boolean NOT null default false, -- Fallzusammenführung
    mergingReason varchar(4), -- Fallzusammenführungsgrund
    admissionWeight real,-- Aufnahmegewicht    
    dischargeDate timestamp, -- Entlassungsdatum
    dischargeReason varchar(5), -- Entlassungsgrund
    ageDay int, -- Alter_in_Tagen_am_Aufnahmetag
    ageYear int, -- Alter_in_Jahren_am_Aufnahmetag
    patientId varchar(32) NOT NULL, -- Patientennummer
    numberIntercompetitiveDialyses int, -- Interkurrente_Dialysen
    ventilationHours int, -- Beatmungsstunden
    startTreatmentPreinpatient date,-- Behandlungsbeginn vorstationär
    treatmentDaysPreinpatient int, -- Behandlungstage vorstationär
    endTreatmentInpatient date, -- Behandlungsende nachstationär
    treatmentDaysAfterInpatient int, -- Behandlungstage nachstationär    
    institutionalRelocatingHospitalId varchar(10), -- Institutionskennzeichen des verlegenden Krankenhauses
    occupancyDaysDifferentPayRange int,-- Belegungstage in einem anderen Entgeltbereich
    leaveAbsenceBPflVPayArea int,-- Beurlaubungstage im BPflV-Entgeltbereich
    isSpecialCaseModelProject boolean default false,-- Kennung Besonderer Fall Modellvorhaben []
    intensiveDwellTime real,-- Verweildauer Intensiv (noch nicht in unseren Dateien)
    source varchar(255) default 'FALL.csv'-- Quelle-Datei  
);

CREATE INDEX patientIndex on p21.p21_encounter (patientId);
/*
-- patienten
--DROP table if exists p21.patient cascade;
CREATE TABLE p21.patient
(
    id varchar(32) primary key,
    yearOfBirth integer,
    administrativeSex char(1),
    source varchar(255)
);
*/
-- icd
--DROP table if exists p21.p21_diagnosis cascade;
CREATE TABLE p21.p21_diagnosis
(
    id bigserial PRIMARY KEY,
    institutionMark varchar(10), -- IK
    dismissingLocation varchar(255), -- Entlassender Standort
    remunerationArea varchar(4), -- Entgeltbereich
    encounterId varchar(45) NOT null, -- KH-internes Kennzeichen
    diagnosisTyp varchar(3),-- Diagnoseart
    icdVersion varchar(6), -- ICD-Version
    icdCode varchar(10) not null, --Diagnoseschlüssel (ICD-Kode)    
    localisation char(1), -- Lokalisation (constraint('L', 'R', 'B'))
    diagnosticSecurity varchar(2), -- Diagnosensicherheit
    icdCode2 varchar(10), -- Sekundär-Diagnoseschlüssel (Sekundär-Kode)
    localisation2 char(1), -- Lokalisation (constraint('L', 'R', 'B'))
    diagnosticSecurity2 varchar(2), -- Diagnosensicherheit
    source varchar(255) default 'ICD.csv'-- Quelle-Datei 
);

CREATE INDEX encounterIndexIcd ON p21.p21_diagnosis (encounterId);

-- ops
--DROP table if exists p21.p21_operation cascade;
CREATE TABLE p21.p21_operation
(
    id bigserial PRIMARY key,
    institutionMark varchar(10), -- IK
    dismissingLocation varchar(255), -- Entlassender Standort
    remunerationArea varchar(4), -- Entgeltbereich
    encounterId varchar(45) NOT null, -- KH-internes Kennzeichen
    opsVersion varchar(6), -- OPS-Version
    opsCode varchar(10) not null, --Prozedurenschlüssel (OPS-Kode)    
    localisation char(1), --Lokalisation (constraint ('L', 'R', 'B'))
    opsDate timestamp, -- OPS-Datum
    surgeon boolean default false,-- Belegoperateur [J/N]
    anesthetist boolean default false,-- Beleganästhesist [J/N]
    midwife boolean default false, -- Beleghebamme [J/N]
    source varchar(255) default 'OPS.csv'-- Quelle-Datei 
);

CREATE INDEX encounterIndexOps ON p21.p21_operation (encounterId);

-- fab
--DROP table if exists p21.p21_department cascade;
CREATE TABLE p21.p21_department
(
    id bigserial primary key,
    institutionMark varchar(10), --IK
    dismissingLocation varchar(255), -- Entlassender Standort
    remunerationArea varchar(4), -- Entgeltbereich
    encounterId varchar(45) NOT null, -- KH-internes Kennzeichen
    numberTreatmentPlace varchar(10), -- Standortnummer Behandlungsort (neue eingefügte Spalte in 2020)
    departmentCode varchar(10) NOT NULL, --Fachabteilung
    admissionDate timestamp, -- Datum der Aufnahme in die Fachabteilung
    dischargeDate timestamp, -- Datum der Verlegung-/Entlassung aus der Fachabteilung
    isIntensiveCareBed boolean default false, -- Kennung Intensivbett (noch nicht in unseren Dateien) [J/N]
    source varchar(255) default 'FAB.csv'-- Quelle-Datei 
);

CREATE INDEX encounterIndexFab ON p21.p21_department (encounterId);


--DROP TABLE if exists p21.loinc_mapping_central_lab;

CREATE TABLE p21.loinc_mapping_central_lab (
	id bigserial PRIMARY KEY, 
	analyteAbbr varchar(10), --Analytkürzel
	loinc varchar(10), -- LOINC
	analyTetext varchar(255), -- Analyttext
	unit varchar(20), -- Einheit 
	unitUCUM varchar(20), -- Einheit (UCUM)
	conversionFactor varchar(20), -- Umrechnungsfaktor
	material varchar(255), --Material
	laborProcedure varchar(100), -- Verfahren
	validfrom date, -- Gültig ab
	source varchar(255) default 'LOINC-Zentrallabor-Liste Version 1.0'--Quelle-Datei
);

-- Table to management the cases numbers 

create table p21.management(
  casenumber varchar,
  retrievaldate timestamp,
  trigger_event varchar,
  user_event varchar,
  trigger_name varchar,
  table_name varchar
);
