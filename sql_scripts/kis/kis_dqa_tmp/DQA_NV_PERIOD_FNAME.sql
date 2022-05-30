-- DQA_NV_PERIOD_FNAME
CREATE OR REPLACE VIEW kis."DQA_NV_PERIOD_FNAME"
  AS
  SELECT count(n."RetrievalDate") AS "QUANTITY",
    CASE
      WHEN n."FNAME" ~ '\w' THEN n."FNAME"
        ELSE NULL
    END AS "FNAME"/*,
    m.long_name*/
  FROM kis."NV_PERIOD" n
  --LEFT JOIN metadata_repository.TABLE m ON n."FNAME" = m.sourceid
  GROUP BY n."FNAME"--, m.long_name
  ORDER BY "QUANTITY" DESC;

