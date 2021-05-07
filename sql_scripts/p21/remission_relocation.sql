create table metadata_repository.p21_remission_relocation_1_2(
  id varchar(3) primary key,
  mean varchar(255) not null,
  source varchar(255) default ('§ 301 Abs. 3 SGB V, § 21 KHEntgG') not null
);

create table metadata_repository.p21_remission_relocation_3(
  id varchar(2) primary key,
  mean varchar(255) not null,
  source varchar(255) default ('§ 301 Abs. 3 SGB V, § 21 KHEntgG') not null
);

insert into metadata_repository.p21_remission_relocation_3(id, mean)
  values
  ('1','arbeitsfähig entlassen')
  ,('2','arbeitsunfähig entlassen')
  ,('9','keine Angabe')
;

COPY metadata_repository.p21_remission_relocation_1_2(id, mean) FROM '/home/abel/cdw/remission_relocation/remission_relocation.txt' WITH DELIMITER E';' CSV QUOTE E'\b' ;
    

  
  