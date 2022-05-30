-- DQA_NORG_FACHRA
CREATE OR REPLACE VIEW kis."DQA_NORG_FACHRA"
  AS
  SELECT count(n."RetrievalDate") AS "QUANTITY",
    CASE
      WHEN n."FACHRA" ~ '\w' THEN n."FACHRA"
        ELSE NULL
    END AS "FACHRA"/*,
    m.long_name*/
  FROM kis."NORG" n
  --LEFT JOIN metadata_repository.TABLE m ON n."FACHRA" = m.sourceid
  GROUP BY n."FACHRA"--, m.long_name
  ORDER BY "QUANTITY" DESC;

