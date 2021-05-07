create schema dermatology_clinic;
create schema emergency_department;

--create role emergencydepartmentuser with password 'm?H]|BGTqXD;e$:Z;b7P' login;
grant all privileges on schema emergency_department to emergencydepartmentuser;

--create role dermatologyclinicuser with password ',o^)UmeV>K-~bf&{$!.J' login;
grant all privileges on schema dermatology_clinic to dermatologyclinicuser;


--revoke all privileges on schema emergency_department from emergencydepartmentuser;
--drop role if exists emergencydepartmentuser;

--revoke all privileges on schema dermatology_clinic from dermatologyclinicuser;
--drop role if exists dermatologyclinicuser;
