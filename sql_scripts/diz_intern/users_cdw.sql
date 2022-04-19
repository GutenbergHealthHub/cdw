create role schema_management with nologin replication;

-- all in schemas to schema_management

--grant all on schema diz_intern to schema_management;         
grant all on schema imagic to schema_management;             
grant all on schema centrallab to schema_management;         
grant all on schema copra to schema_management;              
grant all on schema gtds to schema_management;               
grant all on schema metadata_repository to schema_management;
grant all on schema p21 to schema_management;                
grant all on schema icd_metainfo to schema_management;       
grant all on schema kis to schema_management;                
grant all on schema ops_metainfo to schema_management;       
grant all on schema aktin to schema_management; 


-- all tables in schemas
--grant all on all tables in schema diz_intern to schema_management;         
grant all on all tables in schema imagic to schema_management;             
grant all on all tables in schema centrallab to schema_management;         
grant all on all tables in schema copra to schema_management;              
grant all on all tables in schema gtds to schema_management;               
grant all on all tables in schema metadata_repository to schema_management;
grant all on all tables in schema p21 to schema_management;                
grant all on all tables in schema icd_metainfo to schema_management;       
grant all on all tables in schema kis to schema_management;                
grant all on all tables in schema ops_metainfo to schema_management;       
grant all on all tables in schema aktin to schema_management;

-- all functions in schema

--grant all on all functions in schema diz_intern to schema_management;         
grant all on all functions in schema imagic to schema_management;             
grant all on all functions in schema centrallab to schema_management;         
grant all on all functions in schema copra to schema_management;              
grant all on all functions in schema gtds to schema_management;               
grant all on all functions in schema metadata_repository to schema_management;
grant all on all functions in schema p21 to schema_management;                
grant all on all functions in schema icd_metainfo to schema_management;       
grant all on all functions in schema kis to schema_management;                
grant all on all functions in schema ops_metainfo to schema_management;       
grant all on all functions in schema aktin to schema_management;

-- all procedures in schema
grant all on all procedures in schema diz_intern to schema_management;         
grant all on all procedures in schema imagic to schema_management;             
grant all on all procedures in schema centrallab to schema_management;         
grant all on all procedures in schema copra to schema_management;              
grant all on all procedures in schema gtds to schema_management;               
grant all on all procedures in schema metadata_repository to schema_management;
grant all on all procedures in schema p21 to schema_management;                
grant all on all procedures in schema icd_metainfo to schema_management;       
grant all on all procedures in schema kis to schema_management;                
grant all on all procedures in schema ops_metainfo to schema_management;       
grant all on all procedures in schema aktin to schema_management;              


-- Abel
create role her11a_test with password '58R_`@*mNI5.&h!Y-,s5aLc}7-uy^7' login in role schema_management;
grant all on database staging_test to her11a_test;

--Daniel
create role scm14d_test with replication password 'JGOewv5~T,S(M7/cYq~-\=vb\av`-J' login in role schema_management;
grant all on database staging_test to scm14d_test;


-- Sami
create role hab0s_test with password '#j"p+InkT4;k{hKDH~!?,"*p-Yg?8B' login;

grant usage on schema aktin to hab0s_test;
grant select on all tables in schema aktin to hab0s_test;
grant trigger on all tables in schema aktin to hab0s_test;
grant execute on all functions in schema aktin to hab0s_test;

grant usage on schema kis to hab0s_test;
grant select on all tables in schema kis to hab0s_test;
grant select on all tables in schema kis to hab0s_test;

-- Eric
create role scu0e_test with password 'j0)q6xntr3CQiz[biyD<7e{lr5nU1t' login;

grant usage on schema aktin to scu0e_test;
grant select on all tables in schema aktin to scu0e_test;
grant insert on all tables in schema aktin to scu0e_test;
grant update on all tables in schema aktin to scu0e_test;
grant delete on all tables in schema aktin to scu0e_test;
grant truncate on all tables in schema aktin to scu0e_test;

grant usage on schema copra to scu0e_test;
grant select on all tables in schema copra to scu0e_test;
grant insert on all tables in schema copra to scu0e_test;
grant update on all tables in schema copra to scu0e_test;
grant delete on all tables in schema copra to scu0e_test;
grant truncate on all tables in schema copra to scu0e_test;


-- Philipp
create role mac0p_test with password 'ULhkjOH[}{!7OJ{Nbfnoq4@40yk=9M' login;

grant usage on schema imagic to mac0p_test;
grant select on all tables in schema imagic to mac0p_test;
grant trigger on all tables in schema imagic to mac0p_test;
grant execute on all functions in schema imagic to mac0p_test;
grant execute on all procedures in schema imagic to mac0p_test;





/*
select 
  'grant all on schema '||schema_name||' to '|| pg.rolname||';' all_in_schema
from information_schema.schemata s,
pg_catalog.pg_roles pg
where schema_name not like 'public' 
and schema_name not like 'pg%' 
and schema_name not like '%schema%'
and rolname like '%schema%';
 
select 
  'grant all on all tables in schema '||schema_name||' to '|| pg.rolname||';' all_tables_in_schema
from information_schema.schemata s,
pg_catalog.pg_roles pg 
where schema_name not like 'public' 
and schema_name not like 'pg%' 
and schema_name not like '%schema%'
and rolname like '%schema%'
;

select 
  'grant all on all functions in schema '||schema_name||' to '|| pg.rolname||';' all_functions_in_schema
from information_schema.schemata s,
pg_catalog.pg_roles pg 
where schema_name not like 'public' 
and schema_name not like 'pg%' 
and schema_name not like '%schema%'
and rolname like '%schema%'
;

select 
  'grant all on all procedures in schema '||schema_name||' to '|| pg.rolname||';' all_procedures_in_schema
from information_schema.schemata s,
pg_catalog.pg_roles pg 
where schema_name not like 'public' 
and schema_name not like 'pg%' 
and schema_name not like '%schema%'
and rolname like '%schema%'
;


revoke all on database staging_test from her11a_test cascade;
drop user if exists her11a_test;

revoke all on database staging_test from scm14d_test cascade;
drop user if exists scm14d_test;

drop role hab0s_test;
*/
