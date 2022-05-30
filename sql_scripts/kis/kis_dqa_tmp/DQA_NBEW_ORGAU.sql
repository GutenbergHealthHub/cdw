-- DQA_NBEW_ORGAU
CREATE OR REPLACE VIEW kis."DQA_NBEW_ORGAU"
  AS
  SELECT count(n."RetrievalDate") AS "QUANTITY",
    CASE
      WHEN n."ORGAU" ~ '\w' THEN n."ORGAU"
        ELSE NULL
    END AS "ORGAU"/*,
    m.long_name*/
  FROM kis."NBEW" n
  --LEFT JOIN metadata_repository.TABLE m ON n."ORGAU" = m.sourceid
  GROUP BY n."ORGAU"--, m.long_name
  ORDER BY "QUANTITY" DESC;

