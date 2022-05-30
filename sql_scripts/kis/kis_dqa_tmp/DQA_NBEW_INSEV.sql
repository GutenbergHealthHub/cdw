-- DQA_NBEW_INSEV
CREATE OR REPLACE VIEW kis."DQA_NBEW_INSEV"
  AS
  SELECT count(n."RetrievalDate") AS "QUANTITY",
    CASE
      WHEN n."INSEV" ~ '\w' THEN n."INSEV"
        ELSE NULL
    END AS "INSEV"/*,
    m.long_name*/
  FROM kis."NBEW" n
  --LEFT JOIN metadata_repository.TABLE m ON n."INSEV" = m.sourceid
  GROUP BY n."INSEV"--, m.long_name
  ORDER BY "QUANTITY" DESC;

