-- DQA_NV_PERIOD_VALUE
CREATE OR REPLACE VIEW kis."DQA_NV_PERIOD_VALUE"
  AS
  SELECT count(n."RetrievalDate") AS "QUANTITY",
    CASE
      WHEN n."VALUE" ~ '\w' THEN n."VALUE"
        ELSE NULL
    END AS "VALUE"/*,
    m.long_name*/
  FROM kis."NV_PERIOD" n
  --LEFT JOIN metadata_repository.TABLE m ON n."VALUE" = m.sourceid
  GROUP BY n."VALUE"--, m.long_name
  ORDER BY "QUANTITY" DESC;

