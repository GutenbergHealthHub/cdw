--Table Tn24 in metadata_repository

drop table if exists metadata_repository.tn24_tmp;
create table metadata_repository.tn24_tmp(
  MANDT varchar,
  EINRI varchar,
  BEKAT varchar,
  BEGDT date,
  ENDDT date,
  FALAR integer,
  ACCCAT varchar,
  INPAT varchar,
  OUTPAT varchar,
  DAYPAT varchar,
  BKTXT varchar,
  BLTXT varchar
);

copy metadata_repository.tn24_tmp from '/media/db/cdw_files/kis/tn24.csv' WITH DELIMITER E',' CSV QUOTE E'"' header;
drop table if exists metadata_repository.tn24;
create table metadata_repository.tn24(  
  EINRI varchar,
  BEKAT varchar,
  BEGDT date,
  ENDDT date,
  FALAR integer,
  --ACCCAT varchar,
  INPAT boolean,
  OUTPAT boolean,
  DAYPAT boolean,
  BKTXT varchar not null,
  BLTXT varchar not null,
  source varchar not null default 'kis' references metadata_repository.sources(sourceid),
  inserted timestamp not null default now(),
  primary key (EINRI, BEKAT)
);

--select * from metadata_repository.tn24;
insert into metadata_repository.tn24(EINRI,
  BEKAT,
  BEGDT,
  ENDDT,
  FALAR,
  INPAT,
  OUTPAT,
  DAYPAT,
  BKTXT,
  BLTXT) 
select 
  EINRI,
  BEKAT,
  BEGDT,
  ENDDT,
  FALAR,
  case 
    when INPAT ~*'x' then true
    else false
  end inpat,
  case 
    when OUTPAT ~*'x' then true
    else false
  end outpat,
  case 
    when DAYPAT ~*'x' then true
    else false
  end DAYPAT,
  BKTXT,
  BLTXT
from metadata_repository.tn24_tmp;

drop table if exists metadata_repository.tn24_tmp;
