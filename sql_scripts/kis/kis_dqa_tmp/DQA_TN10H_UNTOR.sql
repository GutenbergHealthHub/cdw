-- DQA_TN10H_UNTOR
CREATE OR REPLACE VIEW kis."DQA_TN10H_UNTOR"
  AS
  SELECT count(n."RetrievalDate") AS "QUANTITY",
    CASE
      WHEN n."UNTOR" ~ '\w' THEN n."UNTOR"
        ELSE NULL
    END AS "UNTOR"/*,
    m.long_name*/
  FROM kis."TN10H" n
  --LEFT JOIN metadata_repository.TABLE m ON n."UNTOR" = m.sourceid
  GROUP BY n."UNTOR"--, m.long_name
  ORDER BY "QUANTITY" DESC;

