-- DQA_NORG_FACHR7
CREATE OR REPLACE VIEW kis."DQA_NORG_FACHR7"
  AS
  SELECT count(n."RetrievalDate") AS "QUANTITY",
    CASE
      WHEN n."FACHR7" ~ '\w' THEN n."FACHR7"
        ELSE NULL
    END AS "FACHR7"/*,
    m.long_name*/
  FROM kis."NORG" n
  --LEFT JOIN metadata_repository.TABLE m ON n."FACHR7" = m.sourceid
  GROUP BY n."FACHR7"--, m.long_name
  ORDER BY "QUANTITY" DESC;

