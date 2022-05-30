-- DQA_NFAL_FATYP
CREATE OR REPLACE VIEW kis."DQA_NFAL_FATYP"
  AS
  SELECT count(n."RetrievalDate") AS "QUANTITY",
    CASE
      WHEN n."FATYP" ~ '\w' THEN n."FATYP"
        ELSE NULL
    END AS "FATYP"/*,
    m.long_name*/
  FROM kis."NFAL" n
  --LEFT JOIN metadata_repository.TABLE m ON n."FATYP" = m.sourceid
  GROUP BY n."FATYP"--, m.long_name
  ORDER BY "QUANTITY" DESC;

