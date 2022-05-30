-- DQA_NBEW_TODUR
CREATE OR REPLACE VIEW kis."DQA_NBEW_TODUR"
  AS
  SELECT count(n."RetrievalDate") AS "QUANTITY",
    CASE
      WHEN n."TODUR" ~ '\w' THEN n."TODUR"
        ELSE NULL
    END AS "TODUR"/*,
    m.long_name*/
  FROM kis."NBEW" n
  --LEFT JOIN metadata_repository.TABLE m ON n."TODUR" = m.sourceid
  GROUP BY n."TODUR"--, m.long_name
  ORDER BY "QUANTITY" DESC;

