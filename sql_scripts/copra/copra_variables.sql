-- Variables for COPRA
drop table if exists copra.co6_config_variables_tmp;
CREATE TABLE copra.co6_config_variables_tmp (
  ID integer primary key,
  EntryTime timestamp ,
  EntryUser integer ,
  Name varchar(50) ,
  Description varchar,
  Unit varchar(50) ,
  CO6_Config_VariableTypes_ID int ,
  Parent int ,
  deleted varchar ,
  LOINC varchar(50),
  PersistenceAssembly varchar(100),
  PersistenceClass varchar(100) ,
  Timestamp varchar ,
  DisplayName varchar(50)
);

/*
drop table if exists copra.varids;
create table copra.varids(
  varid integer primary key
);
*/

-- import inte temp tables
copy copra.co6_config_variables_tmp from '/media/db/cdw_files/copra/CO6_Config_Variables.csv' WITH DELIMITER E';' CSV QUOTE E'"' header;
--copy copra.varids from '/media/db/cdw_files/copra/copra_varid';


drop table if exists metadata_repository.copra_variables cascade;
create table metadata_repository.copra_variables(
  id serial primary key,
  varid bigint not null,
  name varchar not null,
  description varchar,  
  unit varchar,
  loinc varchar,
  displayname varchar,
  inserted timestamp not null default now(),
  source varchar references metadata_repository.sources(sourceid) default 'copra' not null,
  unique(varid)
);

-- insert copra variables into metadata
insert into metadata_repository.copra_variables (varid, name, description, unit, loinc, displayname)
select
  id,
  name,
  case
    when description like 'NULL' then null
    else description
  end description,
  case
    when unit isnull or unit like 'NULL' then null
    else unit
  end unit,
  case
    when loinc like 'NULL' or loinc isnull then null
    else loinc
  end loinc,
  case
    when displayname like 'NULL' or displayname isnull then
      case
        when description isnull or description ~*'NULL|liste' then regexp_replace(name, '_', ' ','g')
        else description
      end
    else displayname
   end displayname
from copra.co6_config_variables_tmp ccvt
--join copra.varids
--on id = varid
where name notnull
/*and id not between 2 and 3
and id not between 20 and 130
and id not between 100003 and 100038
and id not between 100904 and 101328
and id not between 101461 and 101468
and id not between 101766 and 101795
and id not between 102199 and 102382
and id not between 102409 and 102438
and id not between 106485 and 106516
and id not between 108097 and 108108
and id not between 108152 and 108164
and id not between 108276 and 108283
and id not in (8, 100067, 102523, 106592, 106617, 108242, 108478, 108479,108623, 117170)*/
;

-- drop temp tables
drop table if exists copra.co6_config_variables_tmp;
--drop table if exists copra.varids;
