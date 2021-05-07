create table metadata_repository.ops(
  ops varchar(15) primary key,
  titel varchar(255) not null,
  source varchar (255) not null default 'Deutschen Instituts für Medizinische Dokumentation und Information (DIMDI), https://www.dimdi.de/dynamic/de/startseite/'
);

create table metadata_repository.tmp_ops(
  ops varchar(15) not null,
  titel varchar(255) not null
);


/*
-- insert into ops...

*/


insert into metadata_repository.ops(ops, titel)

  select distinct tmp.ops, max(tmp.titel) t from metadata_repository.tmp_ops tmp 
  join staging.p21_operation pops on tmp.ops = pops.opscode 
    left join metadata_repository.ops nops 
    on tmp.ops = nops.ops where nops.ops isnull
  group by tmp.ops;

truncate metadata_repository.tmp_ops;
--truncate metadata_repository.ops;

