-- DQA_NORG_FACHR2
CREATE OR REPLACE VIEW kis."DQA_NORG_FACHR2"
  AS
  SELECT count(n."RetrievalDate") AS "QUANTITY",
    CASE
      WHEN n."FACHR2" ~ '\w' THEN n."FACHR2"
        ELSE NULL
    END AS "FACHR2"/*,
    m.long_name*/
  FROM kis."NORG" n
  --LEFT JOIN metadata_repository.TABLE m ON n."FACHR2" = m.sourceid
  GROUP BY n."FACHR2"--, m.long_name
  ORDER BY "QUANTITY" DESC;

