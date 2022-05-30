-- DQA_NBEW_RFSRC
CREATE OR REPLACE VIEW kis."DQA_NBEW_RFSRC"
  AS
  SELECT count(n."RetrievalDate") AS "QUANTITY",
    CASE
      WHEN n."RFSRC" ~ '\w' THEN n."RFSRC"
        ELSE NULL
    END AS "RFSRC"/*,
    m.long_name*/
  FROM kis."NBEW" n
  --LEFT JOIN metadata_repository.TABLE m ON n."RFSRC" = m.sourceid
  GROUP BY n."RFSRC"--, m.long_name
  ORDER BY "QUANTITY" DESC;

