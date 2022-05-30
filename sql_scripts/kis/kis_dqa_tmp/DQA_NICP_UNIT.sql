-- DQA_NICP_UNIT
CREATE OR REPLACE VIEW kis."DQA_NICP_UNIT"
  AS
  SELECT count(n."RetrievalDate") AS "QUANTITY",
    CASE
      WHEN n."UNIT" ~ '\w' THEN n."UNIT"
        ELSE NULL
    END AS "UNIT"/*,
    m.long_name*/
  FROM kis."NICP" n
  --LEFT JOIN metadata_repository.TABLE m ON n."UNIT" = m.sourceid
  GROUP BY n."UNIT"--, m.long_name
  ORDER BY "QUANTITY" DESC;

