-- Estructure and insert into table norg

-- drop temporary table if exists
drop table if exists kis.norg_tmp;

--create temporary table with all columns as varchar.
create table kis.norg_tmp(
  einri varchar(4) not null,
  orgid varchar(8) not null,
  orgty varchar(2),
  orgna varchar(30),
  orgkb varchar(12),
  okurz varchar(5),
  fachr varchar(4),
  fachr2 varchar(4),
  aufkz varchar,
  inten varchar,
  fachr9 varchar(4),
  paedkz varchar,
  fachr1 varchar(4),
  primary key (einri, orgid)
);

-- import the information from csv-file into temporary table
copy kis.norg_tmp from '/media/db/cdw_files/kis/norg.csv' WITH DELIMITER E';' CSV QUOTE E'\b' header;

-- save the old information of norg in another table in public schema
select * into norg from kis.norg n;

-- drop table norg
/*
  The drop and create table are only if the norg-table change the structure.
 */

-- drop table if exists norg
drop table if exists kis.norg cascade;

-- create table norg
create table kis.norg(
  einri varchar(4) not null,
  orgid varchar(8) not null,
  orgty varchar(2),
  orgna varchar(30),
  orgkb varchar(12),
  okurz varchar(5),
  fachr varchar(4),
  fachr2 varchar(4),
  aufkz boolean,
  inten boolean,
  fachr9 varchar(4),
  paedkz boolean,
  fachr1 varchar(4),
  primary key (einri, orgid)
);

--truncate the table norg
truncate table kis.norg cascade;

--isert transformed information (some varchar to boolean)
insert into kis.norg
  select 
  einri,
  orgid,
  orgty,
  orgna,
  orgkb,
  okurz,
  fachr,
  fachr2,
  case 
    when aufkz isnull then false 
    else true 
  end aufkz,
  case 
    when inten isnull then false
    else true 
  end inten,
  fachr9,
  case
    when paedkz isnull then false 
    else true 
  end paedkz,
  fachr1 
from kis.norg_tmp nt;

-- drop temporary table
drop table if exists kis.norg_tmp;
