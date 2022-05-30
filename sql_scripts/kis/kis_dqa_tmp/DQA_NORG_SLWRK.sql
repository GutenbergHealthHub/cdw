-- DQA_NORG_SLWRK
CREATE OR REPLACE VIEW kis."DQA_NORG_SLWRK"
  AS
  SELECT count(n."RetrievalDate") AS "QUANTITY",
    CASE
      WHEN n."SLWRK" ~ '\w' THEN n."SLWRK"
        ELSE NULL
    END AS "SLWRK"/*,
    m.long_name*/
  FROM kis."NORG" n
  --LEFT JOIN metadata_repository.TABLE m ON n."SLWRK" = m.sourceid
  GROUP BY n."SLWRK"--, m.long_name
  ORDER BY "QUANTITY" DESC;

