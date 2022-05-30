-- DQA_NBEW_UNFRT
CREATE OR REPLACE VIEW kis."DQA_NBEW_UNFRT"
  AS
  SELECT count(n."RetrievalDate") AS "QUANTITY",
    CASE
      WHEN n."UNFRT" ~ '\w' THEN n."UNFRT"
        ELSE NULL
    END AS "UNFRT"/*,
    m.long_name*/
  FROM kis."NBEW" n
  --LEFT JOIN metadata_repository.TABLE m ON n."UNFRT" = m.sourceid
  GROUP BY n."UNFRT"--, m.long_name
  ORDER BY "QUANTITY" DESC;

