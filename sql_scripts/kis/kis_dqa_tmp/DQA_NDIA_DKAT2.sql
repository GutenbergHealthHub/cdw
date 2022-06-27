-- DQA_NDIA_DKAT2
CREATE OR REPLACE VIEW kis."DQA_NDIA_DKAT2"
  AS
  SELECT count(n."RetrievalDate") AS "QUANTITY",
    CASE
      WHEN n."DKAT2" ~ '\w' THEN n."DKAT2"
        ELSE NULL
    END AS "DKAT2",
    m.kapti
  FROM kis."NDIA" n
  LEFT JOIN icd_metainfo.kapitel m ON n."DKAT2" = m.kapnr
  GROUP BY n."DKAT2", m.kapti
  ORDER BY "QUANTITY" DESC;

