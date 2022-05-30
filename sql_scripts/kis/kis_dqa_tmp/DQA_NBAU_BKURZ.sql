-- DQA_NBAU_BKURZ
CREATE OR REPLACE VIEW kis."DQA_NBAU_BKURZ"
  AS
  SELECT count(n."RetrievalDate") AS "QUANTITY",
    CASE
      WHEN n."BKURZ" ~ '\w' THEN n."BKURZ"
        ELSE NULL
    END AS "BKURZ"/*,
    m.long_name*/
  FROM kis."NBAU" n
  --LEFT JOIN metadata_repository.TABLE m ON n."BKURZ" = m.sourceid
  GROUP BY n."BKURZ"--, m.long_name
  ORDER BY "QUANTITY" DESC;

