-- DQA_NPER_SPTYP
CREATE OR REPLACE VIEW kis."DQA_NPER_SPTYP"
  AS
  SELECT count(n."RetrievalDate") AS "QUANTITY",
    CASE
      WHEN n."SPTYP" ~ '\w' THEN n."SPTYP"
        ELSE NULL
    END AS "SPTYP"/*,
    m.long_name*/
  FROM kis."NPER" n
  --LEFT JOIN metadata_repository.TABLE m ON n."SPTYP" = m.sourceid
  GROUP BY n."SPTYP"--, m.long_name
  ORDER BY "QUANTITY" DESC;

