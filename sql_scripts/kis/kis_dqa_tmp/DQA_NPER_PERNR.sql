-- DQA_NPER_PERNR
CREATE OR REPLACE VIEW kis."DQA_NPER_PERNR"
  AS
  SELECT count(n."RetrievalDate") AS "QUANTITY",
    CASE
      WHEN n."PERNR" ~ '\w' THEN n."PERNR"
        ELSE NULL
    END AS "PERNR"/*,
    m.long_name*/
  FROM kis."NPER" n
  --LEFT JOIN metadata_repository.TABLE m ON n."PERNR" = m.sourceid
  GROUP BY n."PERNR"--, m.long_name
  ORDER BY "QUANTITY" DESC;

