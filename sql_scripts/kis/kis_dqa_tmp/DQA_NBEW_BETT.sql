-- DQA_NBEW_BETT
CREATE OR REPLACE VIEW kis."DQA_NBEW_BETT"
  AS
  SELECT count(n."RetrievalDate") AS "QUANTITY",
    CASE
      WHEN n."BETT" ~ '\w' THEN n."BETT"
        ELSE NULL
    END AS "BETT"/*,
    m.long_name*/
  FROM kis."NBEW" n
  --LEFT JOIN metadata_repository.TABLE m ON n."BETT" = m.sourceid
  GROUP BY n."BETT"--, m.long_name
  ORDER BY "QUANTITY" DESC;

