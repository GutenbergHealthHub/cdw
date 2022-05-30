-- DQA_NBEW_ORGFA
CREATE OR REPLACE VIEW kis."DQA_NBEW_ORGFA"
  AS
  SELECT count(n."RetrievalDate") AS "QUANTITY",
    CASE
      WHEN n."ORGFA" ~ '\w' THEN n."ORGFA"
        ELSE NULL
    END AS "ORGFA"/*,
    m.long_name*/
  FROM kis."NBEW" n
  --LEFT JOIN metadata_repository.TABLE m ON n."ORGFA" = m.sourceid
  GROUP BY n."ORGFA"--, m.long_name
  ORDER BY "QUANTITY" DESC;

