-- DQA_NFAL_BEKAT
CREATE OR REPLACE VIEW kis."DQA_NFAL_BEKAT"
  AS
  SELECT count(n."RetrievalDate") AS "QUANTITY",
    CASE
      WHEN n."BEKAT" ~ '\w' THEN n."BEKAT"
        ELSE NULL
    END AS "BEKAT"/*,
    m.long_name*/
  FROM kis."NFAL" n
  --LEFT JOIN metadata_repository.TABLE m ON n."BEKAT" = m.sourceid
  GROUP BY n."BEKAT"--, m.long_name
  ORDER BY "QUANTITY" DESC;

