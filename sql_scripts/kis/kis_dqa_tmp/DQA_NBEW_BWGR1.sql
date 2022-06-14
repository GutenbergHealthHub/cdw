-- DQA_NBEW_BWGR1
--CREATE OR REPLACE VIEW kis."DQA_NBEW_BWGR1"
--  AS
  SELECT count(n."RetrievalDate") AS "QUANTITY",
    CASE
      WHEN n."BWGR1" ~ '\w' THEN n."BWGR1"
        ELSE NULL
    END AS "BWGR1"/*,
    m.long_name*/
  FROM kis."NBEW" n
  --LEFT JOIN metadata_repository.TABLE m ON n."BWGR1" = m.sourceid
  GROUP BY n."BWGR1"--, m.long_name
  ORDER BY "QUANTITY" DESC;

