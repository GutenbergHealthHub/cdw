-- DQA_NDIA_DKAT1
CREATE OR REPLACE VIEW kis."DQA_NDIA_DKAT1"
  AS
  SELECT count(n."RetrievalDate") AS "QUANTITY",
    CASE
      WHEN n."DKAT1" ~ '\w' THEN n."DKAT1"
        ELSE NULL
    END AS "DKAT1"/*,
    m.long_name*/
  FROM kis."NDIA" n
  --LEFT JOIN metadata_repository.TABLE m ON n."DKAT1" = m.sourceid
  GROUP BY n."DKAT1"--, m.long_name
  ORDER BY "QUANTITY" DESC;

