-- DQA_NFAL_GREIN
CREATE OR REPLACE VIEW kis."DQA_NFAL_GREIN"
  AS
  SELECT count(n."RetrievalDate") AS "QUANTITY",
    CASE
      WHEN n."GREIN" ~ '\w' THEN n."GREIN"
        ELSE NULL
    END AS "GREIN"/*,
    m.long_name*/
  FROM kis."NFAL" n
  --LEFT JOIN metadata_repository.TABLE m ON n."GREIN" = m.sourceid
  GROUP BY n."GREIN"--, m.long_name
  ORDER BY "QUANTITY" DESC;

