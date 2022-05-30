-- DQA_NBAU_BAUTY
CREATE OR REPLACE VIEW kis."DQA_NBAU_BAUTY"
  AS
  SELECT count(n."RetrievalDate") AS "QUANTITY",
    CASE
      WHEN n."BAUTY" ~ '\w' THEN n."BAUTY"
        ELSE NULL
    END AS "BAUTY"/*,
    m.long_name*/
  FROM kis."NBAU" n
  --LEFT JOIN metadata_repository.TABLE m ON n."BAUTY" = m.sourceid
  GROUP BY n."BAUTY"--, m.long_name
  ORDER BY "QUANTITY" DESC;

