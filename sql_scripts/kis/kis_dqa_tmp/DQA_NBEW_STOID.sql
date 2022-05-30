-- DQA_NBEW_STOID
CREATE OR REPLACE VIEW kis."DQA_NBEW_STOID"
  AS
  SELECT count(n."RetrievalDate") AS "QUANTITY",
    CASE
      WHEN n."STOID" ~ '\w' THEN n."STOID"
        ELSE NULL
    END AS "STOID"/*,
    m.long_name*/
  FROM kis."NBEW" n
  --LEFT JOIN metadata_repository.TABLE m ON n."STOID" = m.sourceid
  GROUP BY n."STOID"--, m.long_name
  ORDER BY "QUANTITY" DESC;

