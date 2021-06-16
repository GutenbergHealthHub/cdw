-- copra_variables definition
drop table if exists copra.CO6_Config_Variables;
drop table if exists copra.CO6_Config_Variables_tmp;

CREATE TABLE copra.CO6_Config_Variables_tmp(
  ID bigint primary key,
  EntryTime timestamp not null,
  EntryUser int,
  Name varchar,
  Description varchar,
  Unit varchar,
  CO6_Config_VariableTypes_ID int,
  Parent int,
  deleted timestamp,
  LOINC varchar,
  PersistenceAssembly varchar,
  PersistenceClass varchar,
  "Timestamp" varchar,
  DisplayName varchar
);


CREATE TABLE copra.CO6_Config_Variables(
  ID bigint primary key,
  EntryTime timestamp not null,
  EntryUser int,
  Name varchar,
  Description varchar,
  Unit varchar,
  CO6_Config_VariableTypes_ID int,
  Parent int,
  deleted timestamp,
  LOINC varchar,
  PersistenceAssembly varchar,
  PersistenceClass varchar,
  "Timestamp" varchar,
  DisplayName varchar
);

copy copra.CO6_Config_Variables_tmp from '/media/db/cdw_files/copra/CO6_Config_Variables_new.csv' WITH DELIMITER E';' csv Header;


insert into copra.co6_config_variables
select * from copra.co6_config_variables_tmp where deleted isnull;

alter table copra.co6_config_variables
  drop column deleted,
  drop column persistenceassembly,
  drop column persistenceclass,
  drop column entrytime,
  drop column entryuser,
  drop column "Timestamp"
;

drop table if exists copra.CO6_Config_Variables_tmp;
