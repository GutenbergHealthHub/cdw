-- DQA_NBEW_TPART
CREATE OR REPLACE VIEW kis."DQA_NBEW_TPART"
  AS
  SELECT count(n."RetrievalDate") AS "QUANTITY",
    CASE
      WHEN n."TPART" ~ '\w' THEN n."TPART"
        ELSE NULL
    END AS "TPART"/*,
    m.long_name*/
  FROM kis."NBEW" n
  --LEFT JOIN metadata_repository.TABLE m ON n."TPART" = m.sourceid
  GROUP BY n."TPART"--, m.long_name
  ORDER BY "QUANTITY" DESC;

