-- DQA_NDIA_DKEY1
CREATE OR REPLACE VIEW kis."DQA_NDIA_DKEY1"
  AS
  SELECT count(n."RetrievalDate") AS "QUANTITY",
    CASE
      WHEN n."DKEY1" ~ '\w' THEN n."DKEY1"
        ELSE NULL
    END AS "DKEY1",
    m.titel icd10_titel
  FROM kis."NDIA" n
  LEFT JOIN icd_metainfo.icd10gm m ON regexp_replace(n."DKEY1", '\W','','g')  = m.codeohnepunkt
  GROUP BY "DKEY1", m.titel
  ORDER BY "QUANTITY" desc, icd10_titel;

