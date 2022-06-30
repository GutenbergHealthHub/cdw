-- DQA_NDIA_DKEY_REF
CREATE OR REPLACE VIEW kis."DQA_NDIA_DKEY_REF"
  AS
  SELECT count(n."RetrievalDate") AS "QUANTITY",
    CASE
      WHEN n."DKEY_REF" ~ '\w' THEN n."DKEY_REF"
        ELSE NULL
    END AS "DKEY_REF",
    m.titel icd10_titel
  FROM kis."NDIA" n
  LEFT JOIN icd_metainfo.icd10gm m ON regexp_replace(n."DKEY_REF", '\W', '', 'g') = m.codeohnepunkt
  GROUP BY n."DKEY_REF", m.titel
  ORDER BY "QUANTITY" desc, "DKEY_REF";

