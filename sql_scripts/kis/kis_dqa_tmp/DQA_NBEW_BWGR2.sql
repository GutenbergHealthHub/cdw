-- DQA_NBEW_BWGR2
CREATE OR REPLACE VIEW kis."DQA_NBEW_BWGR2"
  AS
  SELECT count(n."RetrievalDate") AS "QUANTITY",
    CASE
      WHEN n."BWGR2" ~ '\w' THEN n."BWGR2"
        ELSE NULL
    END AS "BWGR2"/*,
    m.long_name*/
  FROM kis."NBEW" n
  --LEFT JOIN metadata_repository.TABLE m ON n."BWGR2" = m.sourceid
  GROUP BY n."BWGR2"--, m.long_name
  ORDER BY "QUANTITY" DESC;

