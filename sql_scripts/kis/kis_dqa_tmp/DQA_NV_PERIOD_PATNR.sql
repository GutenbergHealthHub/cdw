-- DQA_NV_PERIOD_PATNR
CREATE OR REPLACE VIEW kis."DQA_NV_PERIOD_PATNR"
  AS
  SELECT count(n."RetrievalDate") AS "QUANTITY",
    CASE
      WHEN n."PATNR" ~ '\w' THEN n."PATNR"
        ELSE NULL
    END AS "PATNR"/*,
    m.long_name*/
  FROM kis."NV_PERIOD" n
  --LEFT JOIN metadata_repository.TABLE m ON n."PATNR" = m.sourceid
  GROUP BY n."PATNR"--, m.long_name
  ORDER BY "QUANTITY" DESC;

