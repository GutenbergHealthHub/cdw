-- DQA_NDIA_DIAZS
CREATE OR REPLACE VIEW kis."DQA_NDIA_DIAZS"
  AS
  SELECT count(n."RetrievalDate") AS "QUANTITY",
    CASE
      WHEN n."DIAZS" ~ '\w' THEN n."DIAZS"
        ELSE NULL
    END AS "DIAZS"/*,
    m.long_name*/
  FROM kis."NDIA" n
  --LEFT JOIN metadata_repository.TABLE m ON n."DIAZS" = m.sourceid
  GROUP BY n."DIAZS"--, m.long_name
  ORDER BY "QUANTITY" DESC;

