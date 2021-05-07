create index idx_department on p21.p21_department (departmentCode asc);

--diagnosis
create index idx_diagnosis_pd on p21.p21_diagnosis (icdCode asc);
create index idx_diagnosis_sd on p21.p21_diagnosis (icdCode2 asc);

--operation
create index idx_operation on p21.p21_operation (opsCode asc);

--encounter
create index idx_gender on p21.p21_encounter (gender asc);
create index idx_zipcode on p21.p21_encounter (zipCode asc);
create index idx_admissionReason on p21.p21_encounter (admissionReason asc);
create index idx_admissionCause on p21.p21_encounter (admissionCause asc);
create index idx_mergingReason on p21.p21_encounter (mergingReason asc);
create index idx_discargeReason on p21.p21_encounter (dischargeReason asc);
