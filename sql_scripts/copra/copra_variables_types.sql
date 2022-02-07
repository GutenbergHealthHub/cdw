-- COPRA co6_config_variable_types 

create table copra.co6_config_variable_types(
  ID integer primary key,
  Name varchar not null unique,
  TableName varchar not null,
  StorageType integer not null
);

copy copra.co6_config_variable_types from '/home/abel/git_repos/cdw/csv/copra/copra_config_variable_types.csv' WITH DELIMITER E';' HEADER CSV QUOTE E'\b';

--select * from copra.co6_config_variable_types ccvt;

--select distinct storagetype from copra.co6_config_variable_types ccvt;