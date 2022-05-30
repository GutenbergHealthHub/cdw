-- DQA_NBEW_UNFKZ
CREATE OR REPLACE VIEW kis."DQA_NBEW_UNFKZ"
  AS
  SELECT count(n."RetrievalDate") AS "QUANTITY",
    CASE
      WHEN n."UNFKZ" ~ '\w' THEN n."UNFKZ"
        ELSE NULL
    END AS "UNFKZ"/*,
    m.long_name*/
  FROM kis."NBEW" n
  --LEFT JOIN metadata_repository.TABLE m ON n."UNFKZ" = m.sourceid
  GROUP BY n."UNFKZ"--, m.long_name
  ORDER BY "QUANTITY" DESC;

