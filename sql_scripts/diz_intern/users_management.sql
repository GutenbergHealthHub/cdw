--drop table if exists diz_intern.user_management;
drop table if exists diz_intern.phone cascade;
create table diz_intern.phone(
  phone varchar primary key,
  active boolean default true not null
);

insert into diz_intern.phone(phone)
  values
    ('7222'),
    ('7463')
;
--select * from diz_intern.phone;

drop table if exists diz_intern.department cascade;

create table diz_intern.department(
  department_id varchar primary key,
  department varchar not null,
  active boolean default true not null
);

insert into diz_intern.department (department_id, department)
  values 
    ('ghh', 'Gutenberg Health Hub'),
    ('imbei', 'Institut für Medizinische Biometrie, Epidemiologie und Informatik')
;

--select * from diz_intern.department;
drop table if exists diz_intern.person cascade;

create table diz_intern.person(
  person_id varchar primary key,
  firstname varchar not null,
  lastname varchar not null,
  mail varchar unique,
  alternate_mail varchar,
  active boolean default true not null
);

insert into diz_intern.person(person_id, firstname, lastname, mail, alternate_mail)
  values 
    ('her11a', 'Abel', 'Hodelin Hernandez', 'abel.hodelin-hernandez@unimedizin-mainz.de', 'ahodelin@uni-mainz.de'),
    ('scm14d', 'Daniel', 'Schmitz', 'daniel.schmitz@unimedizin-mainz.de', 'daniel.schmitz@uni-mainz.de'),
    ('hab0s', 'Sami', 'Habib', 'sami.habib@unimedizin-mainz.de', 'samhabib@uni-mainz.de'),
    ('mac0p', 'Philipp', 'Macho', 'philipp.macho@unimedizin-mainz.de', 'philipp.macho@uni-mainz.de')
;

--select * from diz_intern.person;


drop table if exists diz_intern.users cascade;

create table diz_intern.users(
  username varchar primary key,
  active boolean default true
);

insert into diz_intern.users (username)
  select usename from pg_catalog.pg_user pu; 
/*
insert into diz_intern.users(username)
  values
    ('her11a_admin'),
    ('her11a_test'),
    ('scm14d_test')
;
*/
--select * from diz_intern.users;

drop table if exists diz_intern.person_phone cascade;

create table diz_intern.person_phone(
  person_id varchar references diz_intern.person(person_id),
  phone varchar references diz_intern.phone(phone),
  primary key (person_id, phone)
);

insert into diz_intern.person_phone
  values
    ('her11a', '7222'),
    ('hab0s', '7222'),
    ('scm14d', '7463'),
    ('mac0p', '7463')
;

--select * from diz_intern.person_phone;


drop table if exists diz_intern.person_department cascade;

create table diz_intern.person_department(
  person_id varchar references diz_intern.person(person_id),
  department_id varchar references diz_intern.department(department_id),
  primary key (person_id, department_id)
);

insert into diz_intern.person_department
  values
    ('her11a', 'ghh'),
    ('hab0s', 'ghh'),
    ('scm14d', 'imbei'),
    ('mac0p', 'imbei')
;

--select * from diz_intern.person_department;

drop table if exists diz_intern.person_users cascade;

create table diz_intern.person_users(
  person_id varchar references diz_intern.person(person_id),
  username varchar references diz_intern.users(username),
  primary key (username, person_id)
);

insert into diz_intern.person_users
  values 
    ('her11a', 'her11a_admin'),
    --('her11a', 'her11a_test'),
    --('scm14d', 'scm14d_test')
;

--select * from diz_intern.person_users;

drop view if exists diz_intern.user_management;

create or replace view diz_intern.user_management
as
select 
  p.person_id klinik_id,
  u.username database_user_id,
  p.firstname ||' '||  p.lastname person, 
  ph.phone, 
  upper(d.department_id) department_id, 
  d.department
from diz_intern.person p 
join diz_intern.person_users pu 
  on p.person_id = pu.person_id 
join diz_intern.users u 
  on pu.username = u.username 
join diz_intern.person_phone pph 
  on pph.person_id = p.person_id 
join diz_intern.phone ph 
  on ph.phone = pph.phone
join diz_intern.person_department pd 
  on p.person_id = pd.person_id 
join diz_intern.department d 
  on d.department_id = pd.department_id
order by klinik_id
;
