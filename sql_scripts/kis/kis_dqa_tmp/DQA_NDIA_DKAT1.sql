-- DQA_NDIA_DKAT1
CREATE OR REPLACE VIEW kis."DQA_NDIA_DKAT1"
  AS
  SELECT count(n."RetrievalDate") AS "QUANTITY",
    CASE
      WHEN n."DKAT1" ~ '\w' THEN n."DKAT1"
        ELSE NULL
    END AS "DKAT1",
    m.kapti
  FROM kis."NDIA" n
  LEFT join icd_metainfo.kapitel m ON n."DKAT1" = m.kapnr
  GROUP BY n."DKAT1", m.kapti
  ORDER BY "QUANTITY" DESC;
 