-- insert into icd...
COPY metadata_repository.tmp_icd from '/home/cdw/cdw/ICD/to_import/2008/icd2008_tr_3c.txt' WITH DELIMITER E';' CSV QUOTE E'\b';
COPY metadata_repository.tmp_icd from '/home/cdw/cdw/ICD/to_import/2009/icd2009_tr_3c.txt' WITH DELIMITER E';' CSV QUOTE E'\b';
COPY metadata_repository.tmp_icd from '/home/cdw/cdw/ICD/to_import/2010/icd2010_tr_3c.txt' WITH DELIMITER E';' CSV QUOTE E'\b';
COPY metadata_repository.tmp_icd from '/home/cdw/cdw/ICD/to_import/2011/icd2011_tr_3c.txt' WITH DELIMITER E';' CSV QUOTE E'\b';
COPY metadata_repository.tmp_icd from '/home/cdw/cdw/ICD/to_import/2012/icd2012_tr_3c.txt' WITH DELIMITER E';' CSV QUOTE E'\b';
COPY metadata_repository.tmp_icd from '/home/cdw/cdw/ICD/to_import/2013/icd2013_tr_3c.txt' WITH DELIMITER E';' CSV QUOTE E'\b';
COPY metadata_repository.tmp_icd from '/home/cdw/cdw/ICD/to_import/2014/icd2014_tr_3c.txt' WITH DELIMITER E';' CSV QUOTE E'\b';
COPY metadata_repository.tmp_icd from '/home/cdw/cdw/ICD/to_import/2015/icd2015_tr_3c.txt' WITH DELIMITER E';' CSV QUOTE E'\b';
COPY metadata_repository.tmp_icd from '/home/cdw/cdw/ICD/to_import/2016/icd2016_tr_3c.txt' WITH DELIMITER E';' CSV QUOTE E'\b';
COPY metadata_repository.tmp_icd from '/home/cdw/cdw/ICD/to_import/2017/icd2017_tr_3c.txt' WITH DELIMITER E';' CSV QUOTE E'\b';
COPY metadata_repository.tmp_icd from '/home/cdw/cdw/ICD/to_import/2018/icd2018_tr_3c.txt' WITH DELIMITER E';' CSV QUOTE E'\b';
COPY metadata_repository.tmp_icd from '/home/cdw/cdw/ICD/to_import/2019/icd2019_tr_3c.txt' WITH DELIMITER E';' CSV QUOTE E'\b';
COPY metadata_repository.tmp_icd from '/home/cdw/cdw/ICD/to_import/2020/icd2020_tr_3c.txt' WITH DELIMITER E';' CSV QUOTE E'\b';
