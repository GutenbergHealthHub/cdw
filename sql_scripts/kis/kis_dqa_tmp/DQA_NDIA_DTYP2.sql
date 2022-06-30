-- DQA_NDIA_DTYP2
CREATE OR REPLACE VIEW kis."DQA_NDIA_DTYP2"
  AS
  SELECT 
    count(n."RetrievalDate") AS "QUANTITY",
    "DTYP2",
    m.diagnosis_type_icd typ_icd10
  FROM kis."NDIA" n
  LEFT JOIN metadata_repository.diagnosis_type_icd m ON n."DTYP2" = m.sourceid
  GROUP BY n."DTYP2", m.diagnosis_type_icd
  ORDER BY "QUANTITY" DESC;

