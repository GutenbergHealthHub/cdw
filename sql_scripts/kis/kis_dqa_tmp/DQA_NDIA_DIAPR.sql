-- DQA_NDIA_DIAPR
CREATE OR REPLACE VIEW kis."DQA_NDIA_DIAPR"
  AS
  SELECT count(n."RetrievalDate") AS "QUANTITY",
    CASE
      WHEN n."DIAPR" ~ '\w' THEN n."DIAPR"
        ELSE NULL
    END AS "DIAPR"/*,
    m.long_name*/
  FROM kis."NDIA" n
  --LEFT JOIN metadata_repository.TABLE m ON n."DIAPR" = m.sourceid
  GROUP BY n."DIAPR"--, m.long_name
  ORDER BY "QUANTITY" DESC;

