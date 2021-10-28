
--drop table if exists copra.CO6_Medic_Data_Patient;
CREATE TABLE copra.CO6_Medic_Data_Patient(
	ID bigint NOT NULL PRIMARY KEY,
	Name varchar(100) NULL,
	VNAME varchar(100) NULL,
	GEB timestamp NULL,
	GESCHLECHT varchar(50) NULL,
	PatID varchar(50) NULL,
	deleted boolean NOT NULL,
	Timestamp bigint NOT NULL
);
create index if not exists ix_timestamp_medic_data_patient on copra.CO6_Medic_Data_Patient(Timestamp);

--drop table if exists copra.CO6_Medic_Pressure;
CREATE TABLE copra.CO6_Medic_Pressure(
	ID bigint NOT NULL,
	VarID int NOT NULL,
	Version bigint NOT NULL PRIMARY KEY,
	PreviousVersion bigint NOT NULL,
	EntryUser int NOT NULL,
	EntryTime timestamp NOT NULL,
	deleted boolean NOT NULL,
	Parent_ID bigint NOT NULL,
	Parent_VarID int NOT NULL,
	DateTimeTo timestamp NOT NULL,
	validated boolean NOT NULL,
	systolic decimal(9, 3) NULL,
	mean decimal(9, 3) NULL,
	diastolic decimal(9, 3) NULL,
	FlagCurrent boolean NOT NULL,
	Timestamp bigint NOT NULL
);
create index if not exists ix_timestamp_medic_prssure on copra.CO6_Medic_Pressure(Timestamp);

--drop table if exists copra.CO6_Data_Decimal_6_3;
CREATE TABLE copra.CO6_Data_Decimal_6_3(
	ID bigint NOT NULL,
	VarID int NOT NULL,
	Version bigint NOT NULL PRIMARY KEY,
	PreviousVersion bigint NOT NULL,
	EntryUser int NOT NULL,
	EntryTime timestamp NOT NULL,
	deleted boolean NOT NULL,
	Parent_ID bigint NOT NULL,
	Parent_VarID int NOT NULL,
	DateTimeTo timestamp NOT NULL,
	validated boolean NOT NULL,
	val decimal(9, 3) NOT NULL,
	FlagCurrent boolean NOT NULL,
	Timestamp bigint NOT NULL
);
create index if not exists ix_timestamp_data_decimal_6_3 on copra.CO6_Data_Decimal_6_3(Timestamp);

--drop table if exists copra.CO6_Data_Object;
CREATE TABLE copra.CO6_Data_Object(
	ID bigint NOT NULL,
	VarID int NOT NULL,
	Version bigint NOT NULL PRIMARY KEY,
	PreviousVersion bigint NOT NULL,
	EntryUser int NOT NULL,
	EntryTime timestamp NOT NULL,
	deleted boolean NOT NULL,
	Parent_ID bigint NOT NULL,
	Parent_VarID int NOT NULL,
	FlagCurrent boolean NOT NULL,
	Template boolean NOT NULL,
	Timestamp bigint NOT NULL
);
create index if not exists ix_timestamp_data_object on copra.CO6_Data_Object(Timestamp);

--drop table if exists copra.CO6_Data_String;
CREATE TABLE copra.CO6_Data_String(
	ID bigint NOT NULL,
	VarID int NOT NULL,
	Version bigint NOT NULL PRIMARY KEY,
	PreviousVersion bigint NOT NULL,
	EntryUser int NOT NULL,
	EntryTime timestamp NOT NULL,
	deleted boolean NOT NULL,
	Parent_ID bigint NOT NULL,
	Parent_VarID int NOT NULL,
	DateTimeTo timestamp NOT NULL,
	validated boolean NOT NULL,
	val varchar NOT NULL,
	FlagCurrent boolean NOT NULL,
	Timestamp bigint NOT NULL
);
create index if not exists ix_timestamp_data_string on copra.CO6_Data_String(Timestamp);


-- table to management the new patients in copra
create table copra.patient_management(
  patid varchar,
  modif_date timestamp,
  user_name varchar,
  trigger_event varchar
);
