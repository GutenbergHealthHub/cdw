-- DQA_NORG_FACHR1
CREATE OR REPLACE VIEW kis."DQA_NORG_FACHR1"
  AS
  SELECT count(n."RetrievalDate") AS "QUANTITY",
    CASE
      WHEN n."FACHR1" ~ '\w' THEN n."FACHR1"
        ELSE NULL
    END AS "FACHR1"/*,
    m.long_name*/
  FROM kis."NORG" n
  --LEFT JOIN metadata_repository.TABLE m ON n."FACHR1" = m.sourceid
  GROUP BY n."FACHR1"--, m.long_name
  ORDER BY "QUANTITY" DESC;

