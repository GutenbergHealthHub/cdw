drop table if exists metadata_repository.departmentkis;
create table metadata_repository.departmentkis(
  mandt varchar,
  fatyp varchar,
  fachr varchar not null,
  fatxt varchar not null,
  inten varchar,
  subsp varchar,
  obste varchar,
  extkz varchar,
  unqcd varchar
);

copy metadata_repository.departmentkis FROM '/media/db/cdw_files/kis/tnkfa.csv' WITH DELIMITER E',' CSV QUOTE E'"' header;
 
--select * from metadata_repository.departmentkis;

alter table metadata_repository.departmentkis
 drop column if exists mandt,
 drop column if exists inten,
 drop column if exists subsp,
 drop column if exists obste,
 drop column if exists extkz,
 drop column if exists unqcd
;

alter table metadata_repository.departmentkis
  add "source" varchar references metadata_repository.sources(sourceid) default 'kis';

drop table if exists metadata_repository.department;
create table metadata_repository.department(
  id serial primary key,
  code varchar(10) not null,
  department varchar(255) not null,
  source varchar references metadata_repository.sources(sourceid),
  inserted timestamp not null default now(),
  unique(code, department, source)
);

insert into metadata_repository.department(code, department, source)
select code fa, mean, 'p301abs3sgb5' from metadata_repository.department_code_mean
  union
select fachr, fatxt, 'kis' from  metadata_repository.departmentkis
order by fa;

drop table if exists metadata_repository.department_code;
create table metadata_repository.department_code(
  department_code varchar(10) primary key,
  inserted timestamp not null default now()
);

insert into metadata_repository.department_code(department_code)
select distinct code fa from metadata_repository.department_code_mean
  union
select distinct fachr from  metadata_repository.departmentkis
order by fa;
