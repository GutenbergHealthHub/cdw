-- DQA_NBEW_STATU
CREATE OR REPLACE VIEW kis."DQA_NBEW_STATU"
  AS
  SELECT count(n."RetrievalDate") AS "QUANTITY",
    CASE
      WHEN n."STATU" ~ '\w' THEN n."STATU"
        ELSE NULL
    END AS "STATU"/*,
    m.long_name*/
  FROM kis."NBEW" n
  --LEFT JOIN metadata_repository.TABLE m ON n."STATU" = m.sourceid
  GROUP BY n."STATU"--, m.long_name
  ORDER BY "QUANTITY" DESC;

