-- DQA_NICP_OPART
CREATE OR REPLACE VIEW kis."DQA_NICP_OPART"
  AS
  SELECT count(n."RetrievalDate") AS "QUANTITY",
    CASE
      WHEN n."OPART" ~ '\w' THEN n."OPART"
        ELSE NULL
    END AS "OPART"/*,
    m.long_name*/
  FROM kis."NICP" n
  --LEFT JOIN metadata_repository.TABLE m ON n."OPART" = m.sourceid
  GROUP BY n."OPART"--, m.long_name
  ORDER BY "QUANTITY" DESC;

