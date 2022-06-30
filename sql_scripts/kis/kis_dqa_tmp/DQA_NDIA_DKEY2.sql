-- DQA_NDIA_DKEY2
CREATE OR REPLACE VIEW kis."DQA_NDIA_DKEY2"
  AS
  SELECT count(n."RetrievalDate") AS "QUANTITY",
    CASE
      WHEN n."DKEY2" ~ '\w' THEN n."DKEY2"
        ELSE NULL
    END AS "DKEY2",
    m.titel icd10_titel
  FROM kis."NDIA" n
  LEFT JOIN icd_metainfo.icd10gm m ON regexp_replace(n."DKEY2", '\W', '', 'g')  = m.codeohnepunkt
  GROUP BY n."DKEY2", m.titel
  ORDER BY "QUANTITY" desc, "DKEY2";

