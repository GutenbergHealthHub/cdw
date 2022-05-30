-- DQA_NORG_ORGTY
CREATE OR REPLACE VIEW kis."DQA_NORG_ORGTY"
  AS
  SELECT count(n."RetrievalDate") AS "QUANTITY",
    CASE
      WHEN n."ORGTY" ~ '\w' THEN n."ORGTY"
        ELSE NULL
    END AS "ORGTY"/*,
    m.long_name*/
  FROM kis."NORG" n
  --LEFT JOIN metadata_repository.TABLE m ON n."ORGTY" = m.sourceid
  GROUP BY n."ORGTY"--, m.long_name
  ORDER BY "QUANTITY" DESC;

