drop schema if exists FAB cascade;

create schema FAB;

create table FAB.fabCodeMeans (
  fab_code_id serial primary key,
  fab_code varchar(5) unique,
  fab_mean varchar(255) not null
);

create table FAB.fabPrefix(
  prefix_id serial primary key,
  prefix varchar(3) unique,
  prefix_means varchar(255) not null
);

create table FAB.fabPrefixCodeMeans(
  fab_id serial primary key,
  prefix_id int references FAB.fabPrefix(prefix_id),
  fab_code_id int references FAB.fabCodeMeans (fab_code_id),
  fab varchar(8) unique not null,
  unique(prefix_id, fab_code_id)
);

COPY FAB.fabPrefix (prefix, prefix_means) FROM '/home/abel/cdw/FAB/fabPrefix.txt' WITH DELIMITER E';' CSV QUOTE E'\b' ;
COPY FAB.fabCodeMeans (fab_code, fab_mean) FROM '/home/abel/cdw/FAB/fabCodesMeans.txt' WITH DELIMITER E';' CSV QUOTE E'\b' ;


insert into  FAB.fabPrefixCodeMeans(prefix_id, fab_code_id, fab)
  select p.prefix_id, cm.fab_code_id, prefix || fab_code as fab from FAB.fabPrefix p, FAB.fabCodeMeans cm ;

 
--special fab code

create table fab.temp_special_department_part_code(
  part_code_int int check(part_code_int between 90 and 98 ) unique,
  part_code_letter char(1) unique,
  primary key (part_code_int, part_code_letter)
);

create table fab.temp_special_department(
  fab_code varchar(6) unique,
  fab_mean varchar(255) unique,
  primary key (fab_code, fab_mean)
);

insert into fab.temp_special_department_part_code(part_code_int, part_code_letter)
  select generate_series(90,98) part_code_int,regexp_split_to_table('B C D E F G H I J', ' ') part_code_letter ;

insert into fab.temp_special_department
select regexp_replace(fab_code, '00', '') ||cast(part_code_int as varchar(2)) fab_code, fab_mean||' '|| part_code_letter as fab_mean from
(select * from fab.temp_special_department_part_code) as t1,
(select fab_code, fab_mean from fab.fabcodemeans where fab_code like '%00' and fab_code not like '00%' order by fab_code) as t2; 

insert into fab.fabcodemeans (fab_code , fab_mean )
  select * from fab.temp_special_department;
  
insert into  FAB.fabPrefixCodeMeans(prefix_id, fab_code_id, fab) 
 select p.prefix_id, cm.fab_code_id, prefix || fab_code as fab from FAB.fabPrefix p, FAB.fabCodeMeans cm where fab_code_id not in (select fab_code_id from fab.fabprefixcodemeans f ) order by fab;

--- in metadata repository
create table metadata_repository.p21_department_code_mean(
  code varchar(6) primary key,
  mean varchar(255) unique,
  source varchar(255) default ('§ 301 Abs. 3 SGB V, § 21 KHEntgG') not null
);

create table metadata_repository.p21_department_prefix(
  prefix varchar(3) primary key,
  mean varchar(255) unique,
  source varchar(255) default ('§ 301 Abs. 3 SGB V, § 21 KHEntgG') not null
);

insert into metadata_repository.p21_department_code_mean(code, mean)
 select fab_code, fab_mean from fab.fabcodemeans f;

insert into metadata_repository.p21_department_prefix(prefix, mean)
  select prefix, prefix_means from fab.fabprefix ;

    
drop schema if exists fab cascade;

